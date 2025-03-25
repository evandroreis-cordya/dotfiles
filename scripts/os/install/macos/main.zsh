#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Starting macOS setup\n\n"

# System setup scripts
source "${SCRIPT_DIR}/xcode.zsh"
source "${SCRIPT_DIR}/homebrew.zsh"

# Development environments
source "${SCRIPT_DIR}/python.zsh"
source "${SCRIPT_DIR}/node.zsh"
source "${SCRIPT_DIR}/ruby.zsh"
source "${SCRIPT_DIR}/go.zsh"
source "${SCRIPT_DIR}/java.zsh"
source "${SCRIPT_DIR}/kotlin.zsh"
source "${SCRIPT_DIR}/rust.zsh"
source "${SCRIPT_DIR}/swift.zsh"

# Development tools
source "${SCRIPT_DIR}/devtools.zsh"
source "${SCRIPT_DIR}/databasetools.zsh"
source "${SCRIPT_DIR}/docker.zsh"
source "${SCRIPT_DIR}/git.zsh"
source "${SCRIPT_DIR}/gpg.zsh"
source "${SCRIPT_DIR}/jetbrains.zsh"
source "${SCRIPT_DIR}/visualstudiocode.zsh"

# Daily tools and utilities
source "${SCRIPT_DIR}/browsers.zsh"
source "${SCRIPT_DIR}/compression_tools.zsh"
source "${SCRIPT_DIR}/dailytools.zsh"
source "${SCRIPT_DIR}/extratools.zsh"

# Media and creative tools
source "${SCRIPT_DIR}/video_tools.zsh"
source "${SCRIPT_DIR}/web_font_tools.zsh"

# App Store and system tools
source "${SCRIPT_DIR}/mas.zsh"
source "${SCRIPT_DIR}/cleanup.zsh"

# Activate the Data Science environment if the activation script exists
ACTIVATE_SCRIPT="$HOME/.jarvistoolset/scripts/activate_datascience.sh"
if [[ -f "$ACTIVATE_SCRIPT" ]]; then
    print_in_purple "\n • Activating Data Science Environment\n\n"
    print_in_yellow "  To use the Data Science environment with all installed packages, run:\n"
    print_in_green "  source $ACTIVATE_SCRIPT\n"
    print_in_yellow "  This will activate the Python virtual environment with Jupyter, Pandas, TensorFlow, and other data science packages.\n"
fi

print_in_purple "\n • macOS setup completed!\n\n"
