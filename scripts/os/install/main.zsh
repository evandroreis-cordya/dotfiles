#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Default values
HOSTNAME=${1:-$(hostname)}
USERNAME=${2:-$(whoami)}
EMAIL=${3:-"evandro.reis@avos.ai"}
DIRECTORY=${4:-"$HOME"}

print_in_purple "\n >> Starting installation...\n\n"

# Get OS type and run appropriate setup script
OS_TYPE=$(get_os)
if [[ -f "${SCRIPT_DIR}/${OS_TYPE}/main.zsh" ]]; then
    source "${SCRIPT_DIR}/${OS_TYPE}/main.zsh"
else
    print_error "Unsupported operating system: ${OS_TYPE}"
    exit 1
fi

print_in_purple "\n >> Installation completed!\n\n"
