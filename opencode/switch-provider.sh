#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ACTIVE="$SCRIPT_DIR/oh-my-opencode.json"
ANTHROPIC_FILE="$SCRIPT_DIR/oh-my-opencode-anthropic.json"
OPENAI_FILE="$SCRIPT_DIR/oh-my-opencode-openai.json"

if [[ ! -f "$ANTHROPIC_FILE" ]]; then
	cp "$ACTIVE" "$ANTHROPIC_FILE"
fi

current_provider() {
	if grep -q '"anthropic/' "$ACTIVE" 2>/dev/null; then
		echo "anthropic"
	else
		echo "openai"
	fi
}

switch_to() {
	local provider="$1"
	case "$provider" in
	anthropic)
		cp "$ANTHROPIC_FILE" "$ACTIVE"
		echo "Switched to Anthropic (Claude)"
		;;
	openai)
		cp "$OPENAI_FILE" "$ACTIVE"
		echo "Switched to OpenAI (GPT)"
		;;
	*)
		echo "Unknown provider: $provider" >&2
		exit 1
		;;
	esac
}

case "${1:-toggle}" in
anthropic | openai)
	target="$1"
	;;
toggle)
	current=$(current_provider)
	if [[ "$current" == "anthropic" ]]; then
		target="openai"
	else
		target="anthropic"
	fi
	;;
status)
	echo "Current provider: $(current_provider)"
	exit 0
	;;
*)
	echo "Usage: $0 [anthropic|openai|toggle|status]" >&2
	exit 1
	;;
esac

current=$(current_provider)
if [[ "$current" == "$target" ]]; then
	echo "Already using $target"
	exit 0
fi

switch_to "$target"
