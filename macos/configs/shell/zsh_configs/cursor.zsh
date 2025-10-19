#!/bin/zsh
#
# Cursor IDE Configuration
# This file contains environment variables and aliases for Cursor IDE
#

# Cursor IDE paths
export CURSOR_PATH="/Applications/Cursor.app/Contents/MacOS/Cursor"

# Cursor configuration directory
export CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"

# Cursor dot directory for MCP configuration
export CURSOR_DOT_DIR="$HOME/.cursor"

# Cursor workspace directory
export CURSOR_WORKSPACE_DIR="$HOME/Workspace"

# Create Cursor directories if they don't exist
if [[ ! -d "$CURSOR_CONFIG_DIR" ]]; then
    mkdir -p "$CURSOR_CONFIG_DIR"
fi

if [[ ! -d "$CURSOR_DOT_DIR" ]]; then
    mkdir -p "$CURSOR_DOT_DIR"
fi

if [[ ! -d "$CURSOR_WORKSPACE_DIR" ]]; then
    mkdir -p "$CURSOR_WORKSPACE_DIR"
fi

# Cursor aliases
alias cursor="open -a Cursor"
alias cur="cursor"
alias ccode="cursor"

# Function to open Cursor with specific file or directory
cursor_open() {
    if [[ $# -eq 0 ]]; then
        cursor .
    else
        cursor "$@"
    fi
}

# Function to open Cursor workspace
cursor_workspace() {
    if [[ $# -eq 0 ]]; then
        cursor "$CURSOR_WORKSPACE_DIR"
    else
        cursor "$CURSOR_WORKSPACE_DIR/$1"
    fi
}

# Function to create new Cursor workspace
cursor_new_workspace() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: cursor_new_workspace <workspace_name>"
        return 1
    fi

    local workspace_name="$1"
    local workspace_path="$CURSOR_WORKSPACE_DIR/$workspace_name"

    mkdir -p "$workspace_path"
    cursor "$workspace_path"
}

# Function to list Cursor workspaces
cursor_list_workspaces() {
    if [[ -d "$CURSOR_WORKSPACE_DIR" ]]; then
        ls -la "$CURSOR_WORKSPACE_DIR"
    else
        echo "No workspaces directory found at $CURSOR_WORKSPACE_DIR"
    fi
}

# Function to backup Cursor settings
cursor_backup_settings() {
    local backup_dir="$HOME/Backups/Configs/cursor"
    mkdir -p "$backup_dir"

    if [[ -d "$CURSOR_CONFIG_DIR" ]]; then
        cp -r "$CURSOR_CONFIG_DIR" "$backup_dir/cursor-config-$(date +%Y%m%d-%H%M%S)"
        echo "Cursor settings backed up to $backup_dir"
    fi

    if [[ -d "$CURSOR_DOT_DIR" ]]; then
        cp -r "$CURSOR_DOT_DIR" "$backup_dir/cursor-dot-$(date +%Y%m%d-%H%M%S)"
        echo "Cursor MCP configuration backed up to $backup_dir"
    fi
}

# Function to restore Cursor settings
cursor_restore_settings() {
    local backup_dir="$HOME/Backups/Configs/cursor"

    if [[ ! -d "$backup_dir" ]]; then
        echo "No backup directory found at $backup_dir"
        return 1
    fi

    local latest_config=$(ls -t "$backup_dir"/cursor-config-* 2>/dev/null | head -1)
    local latest_dot=$(ls -t "$backup_dir"/cursor-dot-* 2>/dev/null | head -1)

    if [[ -n "$latest_config" ]]; then
        cp -r "$latest_config"/* "$CURSOR_CONFIG_DIR/"
        echo "Cursor settings restored from $latest_config"
    fi

    if [[ -n "$latest_dot" ]]; then
        cp -r "$latest_dot"/* "$CURSOR_DOT_DIR/"
        echo "Cursor MCP configuration restored from $latest_dot"
    fi
}

# Function to update Cursor extensions
cursor_update_extensions() {
    echo "Updating Cursor extensions..."
    # This would typically be done through Cursor's extension manager
    echo "Please update extensions manually through Cursor's extension manager"
}

# Function to check Cursor installation
cursor_check_install() {
    if [[ -f "$CURSOR_PATH" ]]; then
        echo "✓ Cursor is installed at $CURSOR_PATH"

        # Check version
        if command -v cursor &> /dev/null; then
            cursor --version 2>/dev/null || echo "Version information not available"
        fi
    else
        echo "✗ Cursor is not installed or not found at $CURSOR_PATH"
        echo "Install Cursor using: brew install --cask cursor"
    fi
}

# Function to open Cursor with MCP debugging
cursor_debug_mcp() {
    echo "Opening Cursor with MCP debugging enabled..."
    CURSOR_LOG_LEVEL=debug cursor "$@"
}

# Export functions for use in shell
export -f cursor_open
export -f cursor_workspace
export -f cursor_new_workspace
export -f cursor_list_workspaces
export -f cursor_backup_settings
export -f cursor_restore_settings
export -f cursor_update_extensions
export -f cursor_check_install
export -f cursor_debug_mcp

# Add Cursor to PATH if not already there
if [[ -d "/Applications/Cursor.app/Contents/MacOS" ]]; then
    export PATH="/Applications/Cursor.app/Contents/MacOS:$PATH"
fi

# Cursor-specific environment variables
export CURSOR_LOG_LEVEL="info"
export CURSOR_EXTENSIONS_GALLERY_SERVICE_URL="https://marketplace.visualstudio.com/_apis/public/gallery"
export CURSOR_EXTENSIONS_GALLERY_CACHE_URL="https://vscode.blob.core.windows.net/gallery/index"
