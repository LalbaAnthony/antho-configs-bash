#!/bin/bash

set -euo pipefail

REPO="LalbaAnthony/antho-configs-bash"
BRANCH="main"

ALIASES_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/src/bashrc_extra.sh"
ALIASES_FILE="$HOME/.bashrc_extra"

BASHRC_FILE="$HOME/.bashrc"
BASHRC_HOOK='[ -f ~/.bashrc_extra ] && . ~/.bashrc_extra'

download_aliases() {
    echo "Downloading bash aliases..."
    curl -fsSL "$ALIASES_URL" -o "$ALIASES_FILE"
}

register_in_bashrc() {
    if grep -qxF "$BASHRC_HOOK" "$BASHRC_FILE"; then
        echo "Hook already present in $BASHRC_FILE, skipping."
    else
        echo "Registering hook in $BASHRC_FILE..."
        echo "$BASHRC_HOOK" >> "$BASHRC_FILE"
    fi
}

reload_shell() {
    echo "Reloading shell..."
    # source may not propagate to the parent shell when run via curl | bash
    # shellcheck disable=SC1090
    source "$BASHRC_FILE" || true
}

main() {
    download_aliases
    register_in_bashrc
    reload_shell
    echo "Bash aliases installed successfully!"
}

main
