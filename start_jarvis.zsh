#!/usr/bin/env zsh

# Script to start Jarvis Toolset
# This script calls the Jarvis Toolset setup script with default arguments

# Default values for user information
HOSTNAME=${1:-$(hostname)}
USERNAME=${2:-$(whoami)}
EMAIL=${3:-"evandro.reis@arvos.ai"}
DIRECTORY=${4:-"$HOME"}

# Path to the setup script
SETUP_SCRIPT="/Users/evandroreis/.jarvistoolset/scripts/os/setup.zsh"

# Check if the setup script exists
if [[ ! -f "$SETUP_SCRIPT" ]]; then
    echo "Error: Setup script not found at $SETUP_SCRIPT"
    exit 1
fi

# Call the setup script with the arguments
"$SETUP_SCRIPT" "$HOSTNAME" "$USERNAME" "$EMAIL" "$DIRECTORY"
