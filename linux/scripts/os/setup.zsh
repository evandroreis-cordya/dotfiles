#!/usr/bin/env zsh
# Linux-specific setup script

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
JARVIS_DIR="$HOME/.jarvistoolset"

# Source generic utilities
source "${JARVIS_DIR}/generic/scripts/os/detect_environment.zsh"
source "${JARVIS_DIR}/generic/scripts/os/utils.zsh"
source "${JARVIS_DIR}/generic/scripts/os/logging.zsh"

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

# Verify we're running on Linux
if [[ "$JARVIS_OS" != "linux" ]]; then
    print_error "This script is intended for Linux only. Detected OS: $JARVIS_OS"
    log_error "Linux setup script called on non-Linux system: $JARVIS_OS"
    exit 1
fi

# Log configuration
log_info "Linux setup configuration:"
log_info "  Hostname: $HOSTNAME"
log_info "  Username: $USERNAME"
log_info "  Email: $EMAIL"
log_info "  Directory: $DIRECTORY"
log_info "  Package Manager: $JARVIS_PACKAGE_MANAGER"

# Script groups for installation
typeset -A SCRIPT_GROUPS
SCRIPT_GROUPS=(
    "system" "System Setup (zsh, oh-my-zsh, wezterm, build-essential)"
    "dev_langs" "Development Languages (python, node, ruby, go, java, kotlin, rust, php, cpp)"
    "data_science" "Data Science Environment"
    "dev_tools" "Development Tools (git, docker, vscode, jetbrains, yarn)"
    "web_tools" "Web and Frontend Tools"
    "daily_tools" "Daily Tools and Utilities (browsers, compression, misc, office)"
    "media_tools" "Media and Creative Tools"
    "creative_tools" "Creative and 3D Design Tools (blender, gimp, inkscape)"
    "cloud_tools" "Cloud and DevOps Tools"
    "ai_tools" "AI and Productivity Tools (including Anthropic Libraries and MCP Servers/Clients)"
)

# Default: all groups are selected
typeset -A SELECTED_GROUPS
for group in ${(k)SCRIPT_GROUPS}; do
    SELECTED_GROUPS[$group]="true"
done

# Function to install system packages
install_system_packages() {
    print_in_purple "
 >> Installing system packages
"
    log_info "Installing system packages"

    local packages=(
        "build-essential"
        "curl"
        "wget"
        "git"
        "vim"
        "htop"
        "tree"
        "jq"
        "unzip"
        "zip"
        "tar"
        "gzip"
        "bzip2"
        "xz-utils"
        "software-properties-common"
        "apt-transport-https"
        "ca-certificates"
        "gnupg"
        "lsb-release"
        "zsh"
        "tmux"
        "neofetch"
        "bat"
        "exa"
        "fd-find"
        "ripgrep"
        "fzf"
    )

    case "$JARVIS_PACKAGE_MANAGER" in
        apt)
            execute_with_log "sudo apt update" "Updating package list"
            for package in "${packages[@]}"; do
                execute_with_log "sudo apt install -y $package" "Installing $package"
            done
            ;;
        yum)
            for package in "${packages[@]}"; do
                execute_with_log "sudo yum install -y $package" "Installing $package"
            done
            ;;
        dnf)
            for package in "${packages[@]}"; do
                execute_with_log "sudo dnf install -y $package" "Installing $package"
            done
            ;;
        pacman)
            execute_with_log "sudo pacman -S --noconfirm ${packages[*]}" "Installing system packages"
            ;;
        zypper)
            for package in "${packages[@]}"; do
                execute_with_log "sudo zypper install -y $package" "Installing $package"
            done
            ;;
        *)
            print_error "Unsupported package manager: $JARVIS_PACKAGE_MANAGER"
            return 1
            ;;
    esac
}

# Function to install WezTerm
install_wezterm() {
    if ! command_exists wezterm; then
        print_in_purple "
 >> Installing WezTerm
"
        log_info "Installing WezTerm"

        case "$JARVIS_PACKAGE_MANAGER" in
            apt)
                # Add WezTerm repository
                execute_with_log "curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/wezterm-fury.gpg" "Adding WezTerm GPG key"
                execute_with_log "echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list" "Adding WezTerm repository"
                execute_with_log "sudo apt update" "Updating package list"
                execute_with_log "sudo apt install -y wezterm" "Installing WezTerm"
                ;;
            yum|dnf)
                execute_with_log "sudo dnf install -y wezterm" "Installing WezTerm"
                ;;
            pacman)
                execute_with_log "sudo pacman -S --noconfirm wezterm" "Installing WezTerm"
                ;;
            zypper)
                execute_with_log "sudo zypper install -y wezterm" "Installing WezTerm"
                ;;
            *)
                # Fallback to manual installation
                local latest_version=$(get_latest_release "wez/wezterm")
                local arch=$(get_arch)
                local download_url="https://github.com/wez/wezterm/releases/download/${latest_version}/wezterm-${latest_version}-Ubuntu-${arch}.deb"

                execute_with_log "wget -O /tmp/wezterm.deb $download_url" "Downloading WezTerm"
                execute_with_log "sudo dpkg -i /tmp/wezterm.deb" "Installing WezTerm"
                execute_with_log "sudo apt-get install -f" "Fixing dependencies"
                ;;
        esac

        print_result $? "WezTerm"
    else
        log_info "WezTerm is already installed"
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_in_purple "
 >> Installing Oh My Zsh
"
        log_info "Installing Oh My Zsh"

        # Install Oh My Zsh
        execute_with_log 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended' "Installing Oh My Zsh"

        print_result $? "Oh My Zsh"
    else
        log_info "Oh My Zsh is already installed"
    fi
}

# Function to install PowerLevel10k
install_powerlevel10k() {
    if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
        print_in_purple "
 >> Installing PowerLevel10k
"
        log_info "Installing PowerLevel10k"

        # Install PowerLevel10k
        execute_with_log "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" "Installing PowerLevel10k"

        print_result $? "PowerLevel10k"
    else
        log_info "PowerLevel10k is already installed"
    fi
}

# Function to install Zsh plugins
install_zsh_plugins() {
    print_in_purple "
 >> Installing Zsh plugins
"
    log_info "Installing Zsh plugins"

    # Install zsh-syntax-highlighting
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
        execute_with_log "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" "Installing zsh-syntax-highlighting"
    fi

    # Install zsh-autosuggestions
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
        execute_with_log "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" "Installing zsh-autosuggestions"
    fi

    # Install zsh-completions
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]]; then
        execute_with_log "git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions" "Installing zsh-completions"
    fi
}

# Function to configure Zsh
configure_zsh() {
    print_in_purple "
 >> Configuring Zsh
"
    log_info "Configuring Zsh"

    # Backup existing .zshrc
    backup_file "$HOME/.zshrc"

    # Create symbolic links to configuration files
    create_symlink "${JARVIS_DIR}/linux/configs/shell/zshrc" "$HOME/.zshrc"
    create_symlink "${JARVIS_DIR}/linux/configs/shell/zsh_exports" "$HOME/.zsh_exports"
    create_symlink "${JARVIS_DIR}/linux/configs/shell/zsh_functions" "$HOME/.zsh_functions"
    create_symlink "${JARVIS_DIR}/linux/configs/shell/zsh_options" "$HOME/.zsh_options"
    create_symlink "${JARVIS_DIR}/linux/configs/shell/zsh_prompt" "$HOME/.zsh_prompt"
    create_symlink "${JARVIS_DIR}/linux/configs/shell/zsh_aliases" "$HOME/.zsh_aliases"

    # Create .zshrc with PowerLevel10k configuration
    cat > "$HOME/.zshrc" << 'EOF'
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    docker
    docker-compose
    kubectl
    helm
    terraform
    aws
    gcloud
    python
    node
    npm
    yarn
    rust
    golang
    java
    maven
    gradle
    sdk
    conda
    pip
    systemd
    vscode
    vim
    tmux
    history
    colored-man-pages
    command-not-found
    extract
    web-search
    copypath
    copyfile
    dirhistory
    history-substring-search
    per-directory-history
    z
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load Jarvis Toolset configurations
for file in ~/.jarvistoolset/linux/configs/shell/*.zsh; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

    log_success "Zsh configuration completed"
}

# Function to configure WezTerm
configure_wezterm() {
    print_in_purple "
 >> Configuring WezTerm
"
    log_info "Configuring WezTerm"

    # Create WezTerm config directory
    local wezterm_config_dir="$HOME/.config/wezterm"
    mkdir -p "$wezterm_config_dir"

    # Create WezTerm configuration
    cat > "$wezterm_config_dir/wezterm.lua" << 'EOF'
-- WezTerm configuration for Linux
local wezterm = require 'wezterm'

return {
    -- Font configuration
    font = wezterm.font_with_fallback({
        'JetBrains Mono',
        'Fira Code',
        'Cascadia Code',
        'Ubuntu Mono',
        'Liberation Mono',
        'Courier New',
        'monospace',
    }),
    font_size = 14.0,

    -- Color scheme
    color_scheme = 'Catppuccin Mocha',

    -- Window configuration
    window_background_opacity = 0.95,
    window_decorations = "RESIZE",
    window_close_confirmation = "NeverPrompt",

    -- Tab configuration
    use_fancy_tab_bar = true,
    tab_bar_at_bottom = true,
    show_tab_index_in_tab_bar = true,
    show_new_tab_button_in_tab_bar = true,

    -- Key bindings
    keys = {
        {
            key = 'n',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.SpawnTab 'DefaultDomain',
        },
        {
            key = 'w',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.CloseCurrentTab { confirm = false },
        },
        {
            key = 't',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.SpawnTab 'DefaultDomain',
        },
        {
            key = 'Tab',
            mods = 'CTRL',
            action = wezterm.action.ActivateTabRelative(1),
        },
        {
            key = 'Tab',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivateTabRelative(-1),
        },
    },

    -- Launch menu
    launch_menu = {
        {
            label = 'Bash',
            args = { 'bash', '-l' },
        },
        {
            label = 'Zsh',
            args = { 'zsh', '-l' },
        },
        {
            label = 'Fish',
            args = { 'fish', '-l' },
        },
    },
}
EOF

    log_success "WezTerm configuration completed"
}

# Function to set Zsh as default shell
set_zsh_default() {
    print_in_purple "
 >> Setting Zsh as default shell
"
    log_info "Setting Zsh as default shell"

    # Check if zsh is installed
    if ! command_exists zsh; then
        print_error "Zsh is not installed. Please install zsh first."
        return 1
    fi

    # Get zsh path
    local zsh_path=$(which zsh)

    # Check if zsh is already the default shell
    if [[ "$SHELL" == "$zsh_path" ]]; then
        log_info "Zsh is already the default shell"
        return 0
    fi

    # Add zsh to /etc/shells if not already there
    if ! grep -q "$zsh_path" /etc/shells; then
        execute_with_log "echo '$zsh_path' | sudo tee -a /etc/shells" "Adding zsh to /etc/shells"
    fi

    # Change default shell to zsh
    execute_with_log "chsh -s $zsh_path" "Changing default shell to zsh"

    log_success "Zsh set as default shell. Please log out and log back in for changes to take effect."
}

# Function to run PowerLevel10k configuration
run_p10k_configure() {
    print_in_purple "
 >> Running PowerLevel10k configuration
"
    log_info "Running PowerLevel10k configuration"

    # Run p10k configure
    execute_with_log "p10k configure" "Configuring PowerLevel10k"
}

# Interactive menu to select script groups
select_script_groups() {
    local answer

    print_in_purple "
 >> Installation Options
"
    print_in_yellow "Would you like to install the complete toolset or select specific groups?
"
    print_in_yellow "1) Install complete toolset (all groups)
"
    print_in_yellow "2) Select specific groups to install
"

    answer=""
    vared -p $'Enter your choice (1/2): ' answer

    if [[ "$answer" == "2" ]]; then
        # Reset all groups to false
        for group in ${(k)SCRIPT_GROUPS}; do
            SELECTED_GROUPS[$group]="false"
        done

        print_in_purple "
 >> Available groups to install
"

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
        print_in_purple "
 >> Installation Summary
"
        for group in ${(k)SCRIPT_GROUPS}; do
            if [[ "${SELECTED_GROUPS[$group]}" == "true" ]]; then
                print_in_green "Will install: ${SCRIPT_GROUPS[$group]}
"
            else
                print_in_red   "Will skip...: ${SCRIPT_GROUPS[$group]}
"
            fi
        done

        # Confirmation
        local confirm_answer=""
        vared -p $'
 >> Proceed with installation? (y/n): ' confirm_answer

        if [[ ! "$confirm_answer" =~ ^[Yy]$ ]]; then
            print_in_red "
** Installation cancelled by user!!
"
            exit 0
        fi
    else
        print_in_green "
Installing complete toolset (all groups).
"
    fi
}

# Main function
main() {
    clear

    # Display banner
    print_in_yellow "
 >> Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition for Linux
"
    print_in_yellow "Copyright (c) 2025 ARVOS.AI. All rights reserved.
"

    # Ask for sudo password upfront
    print_in_purple "
 >> Requesting administrator privileges...
"
    ask_for_sudo

    # Display configuration
    print_in_green "
 >> Starting Jarvis Toolset with the following configuration:
"
    print_in_green "---------------------------------------------------------------
"
    print_in_green "Hostname : $HOSTNAME
"
    print_in_green "Username : $USERNAME
"
    print_in_green "Email    : $EMAIL
"
    print_in_green "Directory: $DIRECTORY
"
    print_in_green "Package Manager: $JARVIS_PACKAGE_MANAGER
"
    print_in_green "---------------------------------------------------------------
"

    # Install system prerequisites
    install_system_packages
    install_wezterm
    install_oh_my_zsh
    install_powerlevel10k
    install_zsh_plugins

    # Configure shell and terminal
    configure_zsh
    configure_wezterm
    set_zsh_default

    # Interactive menu to select script groups
    select_script_groups

    # Export the SELECTED_GROUPS associative array
    export SELECTED_GROUPS

    # Create directories
    create_directories

    # Install everything based on selected groups
    source "${JARVIS_DIR}/linux/install/main.zsh" \
        "$HOSTNAME" \
        "$USERNAME" \
        "$EMAIL" \
        "$DIRECTORY"

    # Run PowerLevel10k configuration
    run_p10k_configure

    print_in_purple "
 >> Setup completed! Please log out and log back in for Zsh to become the default shell.
"
    print_in_yellow "Alternatively, you can run 'exec zsh' to switch to Zsh immediately.
"
}

main "$@"
