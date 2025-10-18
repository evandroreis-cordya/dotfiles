#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Default values
HOSTNAME=${1:-$(hostname)}
USERNAME=${2:-$(whoami)}
EMAIL=${3:-"$DIRECTORY"}
DIRECTORY=${4:-"$HOME"}

# Log the script execution
if type log_info &>/dev/null; then
    log_info "Running install/main.zsh with SELECTED_GROUPS: ${(k)SELECTED_GROUPS}"
fi

# Get OS type and run appropriate setup script
OS_TYPE=$(get_os)
if [[ -f "${SCRIPT_DIR}/${OS_TYPE}/main.zsh" ]]; then
    # Make sure SELECTED_GROUPS is exported
    export SELECTED_GROUPS
    source "${SCRIPT_DIR}/${OS_TYPE}/main.zsh"
else
    print_error "Unsupported operating system: ${OS_TYPE}"
    exit 1
fi

print_in_purple "\n >> Installation completed!\n\n"
