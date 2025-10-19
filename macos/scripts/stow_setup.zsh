#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"
# Source logging script if available
source "${SCRIPT_DIR}/logging.zsh" 2>/dev/null || true

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Function to create stow package structure
create_stow_structure() {
    local stow_dir="${1:-$HOME/dotfiles/cross-platforms/stow}"

    print_in_purple "\n >> Creating GNU Stow package structure\n\n"

    if type log_info &>/dev/null; then
        log_info "Creating stow package structure in: $stow_dir"
    fi

    # Create stow directory if it doesn't exist
    if [[ ! -d "$stow_dir" ]]; then
        mkdir -p "$stow_dir"
        if type log_info &>/dev/null; then
            log_info "Created stow directory: $stow_dir"
        fi
    fi

    # Create package directories with proper structure
    local -a packages=(
        "shell"
        "git"
        "nvim"
        "ssh"
        "gnupg"
        "config"
    )

    for package in "${packages[@]}"; do
        local package_dir="$stow_dir/$package"

        if [[ ! -d "$package_dir" ]]; then
            mkdir -p "$package_dir"
            if type log_info &>/dev/null; then
                log_info "Created stow package directory: $package_dir"
            fi
        fi
    done

    # Create shell package structure
    local shell_dir="$stow_dir/shell"
    local -a shell_dirs=(
        ".config/zsh"
        ".local/bin"
        ".local/share"
        ".local/state"
        ".cache"
        ".ssh"
        ".gnupg"
        ".personalize"
        "Projects"
        "Workspace"
        ".npm-global"
        ".composer"
        ".gradle"
        ".m2"
        "Backups/Apps"
        "Backups/Configs"
        "Backups/dotfiles"
    )

    for dir in "${shell_dirs[@]}"; do
        local full_dir="$shell_dir/$dir"
        if [[ ! -d "$full_dir" ]]; then
            mkdir -p "$full_dir"
            if type log_info &>/dev/null; then
                log_info "Created shell directory: $full_dir"
            fi
        fi
    done

    print_success "Stow package structure created successfully"
    if type log_success &>/dev/null; then
        log_success "Stow package structure created successfully"
    fi
}

# Function to populate stow packages with existing configurations
populate_stow_packages() {
    local stow_dir="${1:-$HOME/dotfiles/cross-platforms/stow}"
    local config_dir="${2:-$HOME/dotfiles/macos/configs}"

    print_in_purple "\n >> Populating GNU Stow packages\n\n"

    if type log_info &>/dev/null; then
        log_info "Populating stow packages from: $config_dir"
    fi

    # Copy shell configurations
    if [[ -d "$config_dir/shell" ]]; then
        cp -r "$config_dir/shell"/* "$stow_dir/shell/" 2>/dev/null
        if type log_info &>/dev/null; then
            log_info "Copied shell configurations to stow package"
        fi
    fi

    # Copy git configurations
    if [[ -d "$config_dir/git" ]]; then
        cp -r "$config_dir/git"/* "$stow_dir/git/" 2>/dev/null
        if type log_info &>/dev/null; then
            log_info "Copied git configurations to stow package"
        fi
    fi

    # Copy neovim configurations
    if [[ -d "$config_dir/neovim" ]]; then
        cp -r "$config_dir/neovim"/* "$stow_dir/nvim/" 2>/dev/null
        if type log_info &>/dev/null; then
            log_info "Copied neovim configurations to stow package"
        fi
    fi

    print_success "Stow packages populated successfully"
    if type log_success &>/dev/null; then
        log_success "Stow packages populated successfully"
    fi
}

# Function to setup stow packages
setup_stow_environment() {
    local stow_dir="${1:-$HOME/dotfiles/cross-platforms/stow}"
    local target_dir="${2:-$HOME}"

    print_in_purple "\n >> Setting up GNU Stow environment\n\n"

    if type log_info &>/dev/null; then
        log_info "Setting up stow environment"
    fi

    # Create stow structure
    create_stow_structure "$stow_dir"

    # Populate packages
    populate_stow_packages "$stow_dir"

    # Setup stow packages
    setup_stow_packages "$stow_dir" "$target_dir"

    print_success "Stow environment setup completed"
    if type log_success &>/dev/null; then
        log_success "Stow environment setup completed"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    # Log main function start
    if type log_info &>/dev/null; then
        log_info "Starting GNU Stow setup process"
    fi

    setup_stow_environment

    # Log main function completion
    if type log_success &>/dev/null; then
        log_success "GNU Stow setup process completed"
    fi
}

main
