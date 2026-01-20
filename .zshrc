export GPG_TTY=$(tty)
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
ZSH_THEME=""

# Which plugins would you like to load?
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	web-search
)

source $ZSH/oh-my-zsh.sh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/fast-syntax-highlighting

### End of Zinit's installer chunk
zinit load agkozak/zsh-z

### Aliases

alias zshrc="code ~/.zshrc"
alias ohmyzshrc="code ~/.oh-my-zsh"
alias gitconfig="code ~/.gitconfig"
alias sstoml="code ~/.config/starship.toml"

### Custom scripts
# This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# This loads Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv virtualenv-init -)"

# This loads colorls
# source $(dirname $(gem which colorls))/tab_complete.sh



# Function for create venv
function cvenv {
  if $1
   then python3 -m venv .venv
   source .venv/bin/activate

  else
    python -m venv .venv 
    source .venv/bin/activate

  fi
}

# Function to enter into a venv
function venv {
  source .venv/bin/activate
}

# java and android development environment
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$PWD/.bun/bin

# bun completions
[ -s "/Users/ebertondias/.bun/_bun" ] && source "/Users/ebertondias/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PYTHONDONTWRITEBYTECODE=1

# go development environment
export GOROOT="$(brew --prefix golang)/libexec"
export GOPATH="$HOME/go"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin


alias vim=nvim

export EDITOR=nvim

eval "$(starship init zsh)"
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
# fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ebertondias/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ebertondias/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ebertondias/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ebertondias/google-cloud-sdk/completion.zsh.inc'; fi

# Obsidian
alias oo='cd $HOME/library/Mobile\ Documents/iCloud~md~obsidian/Documents/bits'
alias or='vim $HOME/library/Mobile\ Documents/iCloud~md~obsidian/Documents/bits/inbox/*.md'

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/Downloads/instantclient_23_3"


. "$HOME/.local/bin/env"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

# to support tmux.config on .config folder
export XDG_CONFIG_HOME="$HOME/.config"

alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# Load variables from a .env file into the current shell session.
load-env() {
  local env_file="$1"

  if [[ -z "$env_file" ]]; then
    echo "Error: .env file path not provided." >&2
    return 1
  fi

  if [[ ! -f "$env_file" ]]; then
    echo "Error: file '$env_file' not found." >&2
    return 1
  fi

  echo "Loading environment variables from $env_file:"

  local regex='^([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*([A-Za-z0-9_]+|".+"|'.+')[[:space:]]*(#.*)?$'

  while IFS= read -r line || [[ -n "$line" ]]; do
    # Trim leading/trailing whitespace.
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"

    # Skip blank lines and comments.
    [[ -z "$line" || "$line" == \#* ]] && continue

    # Remove 'export' if present.
    line="${line#export }"

    # Extract variable name and value.
    if [[ "$line" =~ $regex ]]; then
      var_name="${match[1]}"
      var_value="${match[2]}"

      # Remove inline comment if present.
      var_value="${var_value%%#*}"

      # Trim leading/trailing whitespace (due to inline comments).
      var_value="${var_value#"${var_value%%[![:space:]]*}"}"
      var_value="${var_value%"${var_value##*[![:space:]]}"}"

      # Remove surrounding quotes (single or double).
      if [[ "$var_value" =~ \".*\"$ ]]; then
        var_value="${var_value:1:-1}"
      elif [[ "$var_value" =~ \'*\'$ ]]; then
        var_value="${var_value:1:-1}"
      fi

      # Expand escape sequences if double quoted.
      if [[ "$var_value" == *'\'* ]]; then
        var_value=$(printf "%b" "$var_value")
      fi

      if [[ -n "$var_name" ]]; then
        echo "$var_name=$var_value"
        export "$var_name=$var_value"
      fi
    fi
  done <"$env_file"
}

# Unload all environment variables declared in a .env file.
unload-env() {
  local env_file="$1"

  if [[ -z "$env_file" ]]; then
    echo "Error: .env file path not provided." >&2
    return 1
  fi

  if [[ ! -f "$env_file" ]]; then
    echo "Error: file '$env_file' not found." >&2
    return 1
  fi

  echo "Unloading environment variables from $env_file:"

  local regex='^([A-Za-z0-9_]+)[[:space:]]*='

  while IFS= read -r line || [[ -n "$line" ]]; do
    # Trim leading/trailing whitespace.
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"

    # Skip blank lines and comments.
    [[ -z "$line" || "$line" == \#* ]] && continue

    # Remove 'export' if present.
    line="${line#export }"

    # Extract variable name only.
    if [[ "$line" =~ $regex ]]; then
      var_name="${match[1]}"
      echo "$var_name"
      unset "$var_name"
    fi
  done <"$env_file"
}
eval "$(/opt/homebrew/bin/rbenv init - zsh)"

# Added by Antigravity
export PATH="/Users/ebertondias/.antigravity/antigravity/bin:$PATH"
