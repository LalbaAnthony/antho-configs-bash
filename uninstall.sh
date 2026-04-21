#!/bin/bash

set -euo pipefail

ALIASES_FILE="$HOME/.bash_aliases"

remove_aliases() {
    if [ -f "$ALIASES_FILE" ]; then
        echo "Removing $ALIASES_FILE..."
        rm "$ALIASES_FILE"
    else
        echo "$ALIASES_FILE not found, skipping."
    fi
}

main() {
    remove_aliases
    echo "Bash aliases uninstalled successfully!"
}

main
