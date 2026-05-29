#!/usr/bin/env bash

# Rose Pine color palette (ANSI approximations)
# overlay  -> dark gray background
# pine     -> cyan/teal
# foam     -> light cyan
# iris     -> purple/lavender
# rose     -> pink
# gold     -> yellow
# love     -> red/pink

RESET="\033[0m"
BOLD="\033[1m"

# Foreground colors (Rose Pine approximations)
FG_PINE="\033[36m"       # pine  -> cyan
FG_FOAM="\033[96m"       # foam  -> bright cyan
FG_IRIS="\033[35m"       # iris  -> magenta/purple
FG_ROSE="\033[91m"       # rose  -> bright red/pink
FG_GOLD="\033[33m"       # gold  -> yellow
FG_LOVE="\033[31m"       # love  -> red
FG_DIM="\033[2m"         # dimmed text

input=$(cat)

CWD=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
MODEL=$(echo "$input" | jq -r '.model.display_name // empty')
USED=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
VIM_MODE=$(echo "$input" | jq -r '.vim.mode // empty')

# Shorten path: replace $HOME with ~, keep last 3 segments
if [[ -n "$CWD" ]]; then
  SHORT_PATH="${CWD/#$HOME/\~}"
  # Keep up to 3 path segments from the end
  SHORT_PATH=$(echo "$SHORT_PATH" | awk -F'/' '{
    n=NF; if(n>3) { printf "…"; for(i=n-2;i<=n;i++) printf "/"$i } else print $0
  }')
fi

# Git info (skip optional locks to be safe)
GIT_BRANCH=""
GIT_STATUS_STR=""
if git -C "${CWD:-$PWD}" --no-optional-locks rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
  GIT_BRANCH=$(git -C "${CWD:-$PWD}" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || \
               git -C "${CWD:-$PWD}" --no-optional-locks rev-parse --short HEAD 2>/dev/null)

  PORCELAIN=$(git -C "${CWD:-$PWD}" --no-optional-locks status --porcelain 2>/dev/null)
  MODIFIED=$(echo "$PORCELAIN" | grep -c '^ M\| M' 2>/dev/null || true)
  UNTRACKED=$(echo "$PORCELAIN" | grep -c '^??' 2>/dev/null || true)
  STAGED=$(echo "$PORCELAIN" | grep -c '^[MADRCU]' 2>/dev/null || true)

  AHEAD=$(git -C "${CWD:-$PWD}" --no-optional-locks rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
  BEHIND=$(git -C "${CWD:-$PWD}" --no-optional-locks rev-list --count HEAD..@{u} 2>/dev/null || echo "0")

  [[ "$MODIFIED" -gt 0 ]]  && GIT_STATUS_STR+="${FG_GOLD}!${MODIFIED}${RESET} "
  [[ "$UNTRACKED" -gt 0 ]] && GIT_STATUS_STR+="${FG_GOLD}?${UNTRACKED}${RESET} "
  [[ "$STAGED" -gt 0 ]]    && GIT_STATUS_STR+="${FG_GOLD}++${STAGED}${RESET} "
  [[ "$AHEAD" -gt 0 ]]     && GIT_STATUS_STR+="${FG_FOAM}⇡${AHEAD}${RESET} "
  [[ "$BEHIND" -gt 0 ]]    && GIT_STATUS_STR+="${FG_ROSE}⇣${BEHIND}${RESET} "
  [[ -z "$GIT_STATUS_STR" ]] && GIT_STATUS_STR="${FG_IRIS}✓${RESET} "
fi

# Context usage bar
CTX_STR=""
if [[ -n "$USED" ]] && [[ "$USED" != "null" ]]; then
  USED_INT=${USED%.*}
  if [[ "$USED_INT" -ge 80 ]]; then
    CTX_COLOR="$FG_LOVE"
  elif [[ "$USED_INT" -ge 50 ]]; then
    CTX_COLOR="$FG_GOLD"
  else
    CTX_COLOR="$FG_FOAM"
  fi
  CTX_STR="${FG_DIM}ctx:${RESET}${CTX_COLOR}${USED_INT}%${RESET}"
fi

# Vim mode indicator
VIM_STR=""
if [[ -n "$VIM_MODE" ]]; then
  if [[ "$VIM_MODE" == "NORMAL" ]]; then
    VIM_STR=" ${FG_GOLD}[N]${RESET}"
  else
    VIM_STR=" ${FG_FOAM}[I]${RESET}"
  fi
fi

# Time
TIME_STR=$(date +"%I:%M%p" | tr '[:upper:]' '[:lower:]')

# Assemble status line
LINE=""

# Directory segment
if [[ -n "$SHORT_PATH" ]]; then
  LINE+="${FG_PINE}${SHORT_PATH}${RESET}"
fi

# Git segment
if [[ -n "$GIT_BRANCH" ]]; then
  LINE+="  ${FG_FOAM} ${GIT_BRANCH}${RESET} ${GIT_STATUS_STR}"
fi

# Model segment
if [[ -n "$MODEL" ]]; then
  LINE+=" ${FG_DIM}|${RESET} ${FG_IRIS}${MODEL}${RESET}"
fi

# Context usage
if [[ -n "$CTX_STR" ]]; then
  LINE+=" ${FG_DIM}|${RESET} ${CTX_STR}"
fi

# Vim mode
LINE+="$VIM_STR"

# Time
LINE+="  ${FG_DIM}${TIME_STR}${RESET}"

printf "%b\n" "$LINE"
