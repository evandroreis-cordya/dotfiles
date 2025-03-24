#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Repository configuration
typeset -r GITHUB_REPOSITORY="evandropaes/jarvistoolset"
typeset -r JARVIS_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
typeset -r JARVIS_TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
typeset -r JARVIS_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/scripts/os/utils.zsh"

# Default configuration
typeset jarvisDirectory="."
typeset skipQuestions=false

# Default values for user information
typeset -r HOSTNAME=${1:-$(hostname)}
typeset -r USERNAME=${2:-$(whoami)}
typeset -r EMAIL=${3:-"evandro.reis@arvos.ai"}
typeset -r DIRECTORY=${4:-"$HOME"}

# ----------------------------------------------------------------------
# | Helper Functions                                                     |
# ----------------------------------------------------------------------

download() {
    local url="$1"
    local output="$2"

    if (( $+commands[curl] )); then
        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects
        return $?
    elif (( $+commands[wget] )); then
        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output
        return $?
    fi
    return 1
}

download_jarvis() {
    local tmpFile=""

    print_in_purple "\n • Downloading jarvistoolset\n\n"

    tmpFile="$(mktemp /tmp/XXXXX)"
    download "$JARVIS_TARBALL_URL" "$tmpFile"
    print_result $? "Download jarvistoolset archive" "true"
    
    if ! $skipQuestions; then
        ask_for_confirmation "Do you want to store the jarvistoolset in '$jarvisDirectory'?"
        if ! answer_is_yes; then
            jarvisDirectory=""
            while [[ ! -n "$jarvisDirectory" ]]; do
                ask "Please specify another location for the jarvistoolset (path): "
                jarvisDirectory="$(eval echo $REPLY)"
            done
        fi
    fi

    # Create directory if it doesn't exist
    mkdir -p "$jarvisDirectory"
    print_result $? "Create directory" "true"

    # Extract archive to the jarvistoolset directory
    extract "$tmpFile" "$jarvisDirectory"
    print_result $? "Extract archive" "true"

    # Remove temporary file
    rm -rf "$tmpFile"
    print_result $? "Remove temporary file" "true"
}

download_utils() {
    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"
    download "$JARVIS_UTILS_URL" "$tmpFile" \
        && . "$tmpFile" \
        && rm -rf "$tmpFile" \
        && return 0

    return 1
}

verify_os() {
    local os_name=""
    os_name="$(get_os)"

    if [[ "$os_name" == "macos" ]]; then
        return 0
    else
        printf "Sorry, this script is intended only for macOS.\n"
        return 1
    fi
}

# ----------------------------------------------------------------------
# | Main                                                                |
# ----------------------------------------------------------------------

main() {
    # Ensure the script is run on macOS
    verify_os || exit 1

    # Ensure we have necessary commands
    if ! (( $+commands[git] )); then
        printf "Git is not installed. Please install it first.\n"
        exit 1
    fi

    download_jarvis

    # Create directories
    source "${SCRIPT_DIR}/create_directories.zsh"
    
    # Create local config files
    source "${SCRIPT_DIR}/create_local_config_files.zsh"

    # Install everything
    if ! $skipQuestions; then
        ask_for_confirmation "Do you want to install the applications and tools?"
        if answer_is_yes; then
            source "${SCRIPT_DIR}/install/main.zsh" \
                "$HOSTNAME" \
                "$USERNAME" \
                "$EMAIL" \
                "$DIRECTORY"
        fi
    fi

    print_in_purple "\n • Setup completed! Please restart your terminal.\n\n"
}

main "$@"
