#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Repository configuration
typeset -r GITHUB_REPOSITORY="arvosai/jarvistoolset"
typeset -r JARVIS_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"

# Default configuration
typeset skipQuestions=false

# Default values for user information
HOSTNAME=${1:-$(hostname)}
USERNAME=${2:-$(whoami)}
EMAIL=${3:-"evandro.reis@arvos.ai"}
DIRECTORY=${4:-"$HOME/.jarvistoolset"}

# Export variables for use in other scripts
export HOSTNAME
export USERNAME
export EMAIL
export DIRECTORY

# Script groups for installation
# Ensure we're using zsh associative arrays properly
typeset -A SCRIPT_GROUPS
SCRIPT_GROUPS=(
    "system" "System Setup (xcode, homebrew)"
    "dev_langs" "Development Languages (python, node, ruby, go, java, kotlin, rust, swift, php)"
    "data_science" "Data Science Environment"
    "dev_tools" "Development Tools (devtools, databasetools, docker, git, gpg, jetbrains, vscode, yarn)"
    "web_tools" "Web and Frontend Tools"
    "daily_tools" "Daily Tools and Utilities (browsers, compression, misc, office, apps)"
    "media_tools" "Media and Creative Tools"
    "cloud_tools" "Cloud and DevOps Tools"
    "ai_tools" "AI and Productivity Tools"
    "app_store" "App Store and System Tools"
)

# Default: all groups are selected
typeset -A SELECTED_GROUPS
for group in ${(k)SCRIPT_GROUPS}; do
    SELECTED_GROUPS[$group]="true"
done

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
        print_in_purple "\n >> Installing Homebrew\n\n"
        
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
        # Install Homebrew if not already installed (silently)
        install_homebrew > /dev/null 2>&1
        
        # Install figlet using Homebrew (silently)
        brew install figlet > /dev/null 2>&1
        # print_result $? "figlet"
    fi
    
    return 0
}

install_git() {
    if ! (( $+commands[git] )); then
        print_in_purple "\n >> Installing Git\n\n"
        
        # Install Homebrew if not already installed
        install_homebrew
        
        # Install Git using Homebrew
        brew install git
        print_result $? "Git"
        
        # Make Git available in the current shell session
        if [[ "$(uname -m)" = "arm64" ]]; then
            export PATH="/opt/homebrew/bin:$PATH"
        else
            export PATH="/usr/local/bin:$PATH"
        fi
        
        # Verify Git is now available
        if (( $+commands[git] )); then
            print_success "Git is now available"
        else
            print_error "Git installation failed or Git is not in PATH"
            exit 1
        fi
    fi
    
    return 0
}

display_banner() {
    if (( $+commands[figlet] )); then
        print_in_yellow "$(figlet -f ogre -c 'Jarvis Toolset')\n"
        print_in_yellow "Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition, the complete Mac OS tools and apps installer for AI and Vibe Coders!\n"
        print_in_yellow "Copyright (c) 2025 ARVOS.AI. All rights reserved.\n"
    else
        print_in_yellow "\n >> Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition, the complete Mac OS tools and apps installer for AI and Vibe Coders!\n"
        print_in_yellow "Copyright (c) 2025 ARVOS.AI. All rights reserved.\n"
    fi
}

# Interactive menu to select script groups
select_script_groups() {
    local answer
    
    print_in_purple "\n >> Installation Options\n\n"
    print_in_yellow "Would you like to install the complete toolset or select specific groups?\n\n"
    print_in_yellow "1) Install complete toolset (all groups)\n"
    print_in_yellow "2) Select specific groups to install\n\n"
    
    answer=""
    vared -p $'Enter your choice (1/2): ' answer
    
    if [[ "$answer" == "2" ]]; then
        # Reset all groups to false
        for group in ${(k)SCRIPT_GROUPS}; do
            SELECTED_GROUPS[$group]="false"
        done
        
        print_in_purple "\n >> Available groups to install\n\n"

        for group in ${(k)SCRIPT_GROUPS}; do
            local group_answer=""
            
            vared -p $'Install '"${SCRIPT_GROUPS[$group]}"$'? (y/n): ' group_answer
            
            if [[ "$group_answer" =~ ^[Yy]$ ]]; then
                SELECTED_GROUPS[$group]="true"
            else
                SELECTED_GROUPS[$group]="false"
            fi
        done
        
        # Summary of selected groups
        print_in_purple "\n >> Installation Summary\n\n"
        for group in ${(k)SCRIPT_GROUPS}; do
            if [[ "${SELECTED_GROUPS[$group]}" == "true" ]]; then
                print_in_green "Will install: ${SCRIPT_GROUPS[$group]}\n"
            else
                print_in_red   "Will skip...: ${SCRIPT_GROUPS[$group]}\n"
            fi
        done
        
        # Confirmation
        local confirm_answer=""
        vared -p $'\n\n >> Proceed with installation? (y/n): ' confirm_answer
        
        if [[ ! "$confirm_answer" =~ ^[Yy]$ ]]; then
            print_in_red "\n\n** Installation cancelled by user!!\n\n"
            exit 0
        fi
    else
        print_in_green "\n\nInstalling complete toolset (all groups).\n\n"
    fi
}

# Function to update configuration
update_configuration() {
    local update_config=""
    
    vared -p $'Would you like to update this configuration? (y/n): ' update_config
    
    if [[ "$update_config" =~ ^[Yy]$ ]]; then
        print_in_yellow "\nEnter new values (or press Enter to keep current value):\n"
        
        # Update hostname
        local new_hostname=""
        vared -p $'Hostname ['"$HOSTNAME"$']: ' new_hostname
        
        if [[ -n "$new_hostname" ]]; then
            HOSTNAME="$new_hostname"
        fi
        
        # Update username
        local new_username=""
        vared -p $'Username ['"$USERNAME"$']: ' new_username
        
        if [[ -n "$new_username" ]]; then
            USERNAME="$new_username"
        fi
        
        # Update email
        local new_email=""
        vared -p $'Email ['"$EMAIL"$']: ' new_email
        
        if [[ -n "$new_email" ]]; then
            EMAIL="$new_email"
        fi
        
        # Update directory
        local new_directory=""
        vared -p $'Directory ['"$DIRECTORY"$']: ' new_directory
        
        if [[ -n "$new_directory" ]]; then
            DIRECTORY="$new_directory"
        fi
        
        # Display updated configuration
        print_in_green "\n >> Updated configuration:\n"
        print_in_green "---------------------------------------------------------------\n"
        print_in_green "Hostname: $HOSTNAME\n"
        print_in_green "Username : $USERNAME\n"
        print_in_green "Email    : $EMAIL\n"
        print_in_green "Directory: $DIRECTORY\n"
        print_in_green "---------------------------------------------------------------\n"
    else
        print_in_yellow "Continuing with current configuration.\n"
    fi
}

# ----------------------------------------------------------------------
# | Main                                                                |
# ----------------------------------------------------------------------

main() {
    # Ensure that the following actions
    # are made relative to this file's path.
    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1

    # Load utils
    source "./utils.zsh"
    # Install figlet for banner display
    install_figlet
    
    # Display welcome banner
    display_banner
    
    # Ask for sudo password upfront and keep sudo credentials alive
    print_in_purple "\n >> Requesting administrator privileges...\n\n"
    ask_for_sudo

    # Create a sudo timestamp directory with appropriate permissions
    setup_sudo_timestamp_dir() {
        local sudo_timestamp_dir="/var/run/sudo/${USER}"
        
        # Create the timestamp directory if it doesn't exist
        if [ ! -d "$sudo_timestamp_dir" ]; then
            sudo mkdir -p "$sudo_timestamp_dir" 2>/dev/null
            sudo chmod 700 "$sudo_timestamp_dir" 2>/dev/null
        fi
        
        # Set the sudo timeout to 2 hours (7200 seconds)
        sudo sh -c "echo 'Defaults:${USER} timestamp_timeout=7200' > /etc/sudoers.d/jarvis_timeout"
        sudo chmod 440 /etc/sudoers.d/jarvis_timeout
        
        # Export the SUDO_REQUESTED variable to child processes
        export SUDO_REQUESTED=true
    }

    # Set up the sudo timestamp directory
    setup_sudo_timestamp_dir

    # Display information about what's happening
    print_in_green "\n >> Starting Jarvis Toolset with the following configuration:\n"
    print_in_green "---------------------------------------------------------------\n"
    print_in_green "Hostname: $HOSTNAME\n"
    print_in_green "Username : $USERNAME\n"
    print_in_green "Email    : $EMAIL\n"
    print_in_green "Directory: $DIRECTORY\n"
    print_in_green "---------------------------------------------------------------\n"
    
    # Ask if user wants to update configuration
    update_configuration
    
    # Ensure the script is run on macOS
    verify_os || exit 1

    # Install Git if not already installed
    install_git

    # Interactive menu to select script groups
    select_script_groups

    # Create directories
    source "${SCRIPT_DIR}/create_directories.zsh"
    
    # Create local config files
    source "${SCRIPT_DIR}/create_local_config_files.zsh"

    # Use typeset -A to ensure the associative array is properly exported
    typeset -Ax SELECTED_GROUPS
    export SELECTED_GROUPS

    # Install everything
    source "${SCRIPT_DIR}/install/main.zsh" \
        "$HOSTNAME" \
        "$USERNAME" \
        "$EMAIL" \
        "$DIRECTORY"

    print_in_purple "\n >> Setup completed! Please restart your terminal.\n\n"
}

main "$@"
