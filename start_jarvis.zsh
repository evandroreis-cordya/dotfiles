#!/usr/bin/env zsh

# Clear the screen
clear

# Script to start Jarvis Toolset
# This script calls the Jarvis Toolset setup script with default arguments

# Set the Jarvis directory (can be overridden by environment variable)
JARVIS_DIR="${JARVIS_DIR:-"$HOME/.jarvistoolset"}"

# Get the absolute path to the Jarvis Toolset directory
UTILS_SCRIPT="${JARVIS_DIR}/scripts/os/utils.zsh"
MACOS_UTILS_SCRIPT="${JARVIS_DIR}/scripts/os/install/macos/utils.zsh"

# Source utility scripts if they exist
if [[ -f "$UTILS_SCRIPT" ]]; then
    source "$UTILS_SCRIPT"
else
    echo "Warning: Could not find utils.zsh at $UTILS_SCRIPT"
    # Define fallback functions if utils.zsh is not available
    cmd_exists() {
        command -v "$1" &> /dev/null
    }
    print_in_yellow() {
        echo -e "\033[33m$1\033[0m"
    }
    print_error() {
        echo -e "\033[31mError: $1\033[0m"
    }
    execute() {
        local CMD="$1"
        local MSG="${2:-$1}"
        echo "Executing: $MSG"
        eval "$CMD"
        return $?
    }
fi

if [[ -f "$MACOS_UTILS_SCRIPT" ]]; then
    source "$MACOS_UTILS_SCRIPT"
else
    echo "Warning: Could not find macos/utils.zsh at $MACOS_UTILS_SCRIPT"
    # Define fallback brew_install function if macos/utils.zsh is not available
    brew_install() {
        local FORMULA_NAME="$1"
        local FORMULA="$2"
        echo "Installing $FORMULA_NAME..."
        if ! cmd_exists "brew"; then
            print_error "$FORMULA_NAME (Homebrew is not installed)"
            return 1
        fi
        if brew list "$FORMULA" &> /dev/null; then
            echo "$FORMULA_NAME is already installed"
        else
            brew install "$FORMULA"
        fi
    }
fi

# Check if the first argument is "/help"
if [[ "$1" == "/help" ]]; then
    # Path to README.md - using absolute path to avoid directory resolution issues
    README_PATH="${JARVIS_DIR}/README.md"
    
    # Verify README.md exists at the specified path
    if [[ ! -f "$README_PATH" ]]; then
        print_error "README.md not found at $README_PATH"
        exit 1
    fi
    
    # Check if glow is installed and install it if needed
    if ! cmd_exists "glow"; then
        print_in_yellow "Installing glow for displaying markdown files..."
        
        # Check if Homebrew is installed, install it if needed
        if ! cmd_exists "brew"; then
            print_in_yellow "Homebrew is not installed. Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        # Install glow using brew directly or the brew_install helper function if available
        if type brew_install &>/dev/null; then
            brew_install "Glow Markdown Viewer" "glow"
        else
            brew install glow
        fi
    fi
    
    # Display README.md using glow
    print_in_yellow "Displaying README.md with glow"
    glow -p "$README_PATH"
    exit 0
fi

# Default values for user information
HOSTNAME=${1:-$(hostname)}
USERNAME=${2:-$(whoami)}
EMAIL=${3:-"evandro.reis@arvos.ai"}
DIRECTORY=${4:-"$HOME/.jarvistoolset"}

# Path to the setup script
SETUP_SCRIPT="${JARVIS_DIR}/scripts/os/setup.zsh"

# Check if the setup script exists
if [[ ! -f "$SETUP_SCRIPT" ]]; then
    if type print_error &>/dev/null; then
        print_error "Setup script not found at $SETUP_SCRIPT"
    else
        echo "Error: Setup script not found at $SETUP_SCRIPT"
    fi
    exit 1
fi

# Export SUDO_REQUESTED variable to ensure it's available in all child processes
export SUDO_REQUESTED=false

# Call the setup script with the arguments
"$SETUP_SCRIPT" "$HOSTNAME" "$USERNAME" "$EMAIL" "$DIRECTORY"
