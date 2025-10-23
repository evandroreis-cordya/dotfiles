#!/bin/zsh
#
# VS Code Configuration
# This file contains all VS Code-related configurations
#

# Environment Variables
export VSCODE_CONFIG_DIR="$HOME/.vscode"
export VSCODE_EXTENSIONS_DIR="$HOME/.vscode/extensions"
export VSCODE_USER_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
export VSCODE_KEYBINDINGS="$HOME/Library/Application Support/Code/User/keybindings.json"

# Aliases
alias code="code"
alias vscode="code"
alias code-insiders="code-insiders"

# Functions
vscode_install_extension() {
    local extension="$1"
    if [[ -z "$extension" ]]; then
        echo "Usage: vscode_install_extension <extension_id>"
        return 1
    fi
    code --install-extension "$extension"
}

vscode_uninstall_extension() {
    local extension="$1"
    if [[ -z "$extension" ]]; then
        echo "Usage: vscode_uninstall_extension <extension_id>"
        return 1
    fi
    code --uninstall-extension "$extension"
}

vscode_list_extensions() {
    code --list-extensions
}

# Tool-specific setup
if command -v code &> /dev/null; then
    # Initialize VS Code if available
    echo "VS Code is available."
fi
