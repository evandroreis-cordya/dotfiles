#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Repository configuration
typeset -r GITHUB_REPOSITORY="evandropaes/jarvistoolset"
typeset -r JARVIS_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"

# Default configuration
typeset skipQuestions=false

# Default values for user information
HOSTNAME=${1:-$(hostname)}
USERNAME=${2:-$(whoami)}
EMAIL=${3:-"evandro.reis@arvos.ai"}
DIRECTORY=${4:-"$HOME"}

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

download_utils() {
    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"
    download "$JARVIS_UTILS_URL" "$tmpFile" \
        && source "$tmpFile" \
        && rm -rf "$tmpFile" \
        && return 0

    return 1
}

verify_os() {
    local os_name=""
    os_name="$(get_os)"

    if [[ "$os_name" = "macos" ]]; then
        return 0
    else
        printf "Sorry, this script is intended only for macOS.\n"
        return 1
    fi
}

install_homebrew() {
    if ! (( $+commands[brew] )); then
        print_in_purple "\n • Installing Homebrew\n\n"
        
        # Install Homebrew using the official script
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ "$(uname -m)" = "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        print_result $? "Homebrew"
    fi
    
    return 0
}

install_figlet() {
    if ! (( $+commands[figlet] )); then
        print_in_purple "\n • Installing figlet for banner display\n\n"
        
        # Install Homebrew if not already installed
        install_homebrew
        
        # Install figlet using Homebrew
        brew install figlet
        print_result $? "figlet"
    fi
    
    return 0
}

display_banner() {
    if (( $+commands[figlet] )); then
        print_in_yellow "$(figlet -f roman 'Jarvis Toolset')\n"
        print_in_yellow "Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition, the complete Mac OS tools and apps installer for AI and Vibe Coders!\n"
        print_in_yellow "Copyright (c) 2025 ARVOS.AI. All rights reserved.\n"
    else
        print_in_yellow "\n • Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition, the complete Mac OS tools and apps installer for AI and Vibe Coders!\n"
        print_in_yellow "Copyright (c) 2025 ARVOS.AI. All rights reserved.\n"
    fi
}

# ----------------------------------------------------------------------
# | Main                                                                |
# ----------------------------------------------------------------------

main() {
    # Install figlet for banner display
    install_figlet
    
    # Display welcome banner
    display_banner
    
    # Ensure the script is run on macOS
    verify_os || exit 1

    # Ensure we have necessary commands
    if ! (( $+commands[git] )); then
        printf "Git is not installed. Please install it first.\n"
        exit 1
    fi

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
