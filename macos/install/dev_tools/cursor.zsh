#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
print_in_purple "
   Cursor IDE

"

# Check if Cursor is already installed
if brew list --cask | grep -q "cursor"; then
    print_success "Cursor (already installed)"
else
    brew install --cask cursor &> /dev/null
    print_result $? "Cursor IDE"
fi

# Create Cursor configuration directory if it doesn't exist
CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_CONFIG_DIR"

# Create .cursor directory for MCP configuration
CURSOR_DOT_DIR="$HOME/.cursor"
mkdir -p "$CURSOR_DOT_DIR"

print_in_green "
  Cursor IDE setup complete!
"

print_in_yellow "
  Cursor configuration files will be set up by the stow configuration.
"
