#!/bin/zsh
#
# Neovim Configuration
# This file contains all Neovim-related configurations
#

# Environment Variables
export NVIM_CONFIG_DIR="$HOME/.config/nvim"
export NVIM_DATA_DIR="$HOME/.local/share/nvim"
export NVIM_CACHE_DIR="$HOME/.cache/nvim"

# Aliases
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# Functions
nvim_setup() {
    # Create directories if they don't exist
    mkdir -p "$NVIM_CONFIG_DIR"
    mkdir -p "$NVIM_DATA_DIR"
    mkdir -p "$NVIM_CACHE_DIR"

    echo "Neovim directories created."
}

nvim_install_plugin() {
    local plugin="$1"
    if [[ -z "$plugin" ]]; then
        echo "Usage: nvim_install_plugin <plugin_name>"
        return 1
    fi
    nvim --headless -c "PlugInstall $plugin" -c "qa"
}

# Tool-specific setup
if command -v nvim &> /dev/null; then
    # Initialize Neovim if available
    nvim_setup
fi
