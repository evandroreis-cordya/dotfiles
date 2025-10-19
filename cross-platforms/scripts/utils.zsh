#!/usr/bin/env zsh
# Generic utility functions for multi-platform support

# Color output functions
print_in_yellow() {
    printf "\e[0;33m%s\e[0m" "$1"
}

print_in_green() {
    printf "\e[0;32m%s\e[0m" "$1"
}

print_in_red() {
    printf "\e[0;31m%s\e[0m" "$1"
}

print_in_purple() {
    printf "\e[0;35m%s\e[0m" "$1"
}

print_error() {
    print_in_red "✗ $1\n"
}

print_success() {
    print_in_green "✓ $1\n"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to get the operating system
get_os() {
    case "$(uname -s)" in
        Darwin*)
            echo "macos"
            ;;
        Linux*)
            echo "linux"
            ;;
        CYGWIN*|MINGW*|MSYS*)
            echo "windows"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Function to get the architecture
get_arch() {
    case "$(uname -m)" in
        x86_64|amd64)
            echo "x86_64"
            ;;
        arm64|aarch64)
            echo "arm64"
            ;;
        armv7l)
            echo "armv7"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# DEPRECATED: create_directories() function removed - use GNU Stow instead

# DEPRECATED: backup_file() function removed - GNU Stow handles this automatically

# DEPRECATED: create_symlink() function removed - use GNU Stow instead

# Function to install package using platform-specific package manager
install_package() {
    local package="$1"
    local os="${DOTFILES_OS:-$(get_os)}"

    case "$os" in
        macos)
            if command_exists brew; then
                brew install "$package"
            else
                print_error "Homebrew not found. Please install Homebrew first."
                return 1
            fi
            ;;
        linux)
            local package_manager="${DOTFILES_PACKAGE_MANAGER:-$(detect_package_manager linux)}"
            case "$package_manager" in
                apt)
                    sudo apt update && sudo apt install -y "$package"
                    ;;
                yum)
                    sudo yum install -y "$package"
                    ;;
                dnf)
                    sudo dnf install -y "$package"
                    ;;
                pacman)
                    sudo pacman -S --noconfirm "$package"
                    ;;
                zypper)
                    sudo zypper install -y "$package"
                    ;;
                *)
                    print_error "Unsupported package manager: $package_manager"
                    return 1
                    ;;
            esac
            ;;
        windows)
            if command_exists winget; then
                winget install "$package"
            else
                print_error "Winget not found. Please install Windows Package Manager first."
                return 1
            fi
            ;;
        *)
            print_error "Unsupported operating system: $os"
            return 1
            ;;
    esac
}

# Function to check if running as root/admin
is_root() {
    if [[ "$(get_os)" == "windows" ]]; then
        # Check if running as administrator on Windows
        net session >/dev/null 2>&1
    else
        # Check if running as root on Unix-like systems
        [[ "$EUID" -eq 0 ]]
    fi
}

# Function to ask for sudo/admin privileges
ask_for_sudo() {
    if ! is_root; then
        if [[ "$(get_os)" == "windows" ]]; then
            print_in_yellow "Please run this script as Administrator (right-click and 'Run as administrator')"
        else
            print_in_yellow "Please enter your password for sudo access:"
            sudo -v
        fi
    fi
}

# Function to execute command with logging
execute_with_log() {
    local cmd="$1"
    local msg="${2:-$1}"

    print_in_yellow "   $msg..."

    if type log_command &>/dev/null; then
        log_command "$cmd" "$msg"
        local exit_code=$?
    else
        eval "$cmd"
        local exit_code=$?
    fi

    print_result $exit_code "$msg"
    return $exit_code
}

# Function to download file
download_file() {
    local url="$1"
    local output="$2"

    if command_exists curl; then
        curl -LsSo "$output" "$url"
    elif command_exists wget; then
        wget -qO "$output" "$url"
    else
        print_error "Neither curl nor wget is available for downloading"
        return 1
    fi
}

# Function to extract archive
extract_archive() {
    local archive="$1"
    local destination="${2:-.}"

    case "$archive" in
        *.tar.gz|*.tgz)
            tar -xzf "$archive" -C "$destination"
            ;;
        *.tar.bz2|*.tbz2)
            tar -xjf "$archive" -C "$destination"
            ;;
        *.zip)
            if command_exists unzip; then
                unzip -q "$archive" -d "$destination"
            else
                print_error "unzip not found. Please install unzip."
                return 1
            fi
            ;;
        *.7z)
            if command_exists 7z; then
                7z x "$archive" -o"$destination"
            else
                print_error "7z not found. Please install 7zip."
                return 1
            fi
            ;;
        *)
            print_error "Unsupported archive format: $archive"
            return 1
            ;;
    esac
}

# Function to get latest release from GitHub
get_latest_release() {
    local repo="$1"
    local url="https://api.github.com/repos/$repo/releases/latest"

    if command_exists curl; then
        curl -s "$url" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
    elif command_exists wget; then
        wget -qO- "$url" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
    else
        print_error "Neither curl nor wget is available for API calls"
        return 1
    fi
}

# Function to check if a port is in use
is_port_in_use() {
    local port="$1"
    local os="${DOTFILES_OS:-$(get_os)}"

    case "$os" in
        macos|linux)
            if command_exists lsof; then
                lsof -i ":$port" >/dev/null 2>&1
            elif command_exists netstat; then
                netstat -an | grep ":$port " >/dev/null 2>&1
            else
                print_error "Neither lsof nor netstat is available for port checking"
                return 1
            fi
            ;;
        windows)
            netstat -an | findstr ":$port " >/dev/null 2>&1
            ;;
        *)
            print_error "Unsupported operating system for port checking: $os"
            return 1
            ;;
    esac
}

# Function to wait for a service to be ready
wait_for_service() {
    local host="$1"
    local port="$2"
    local timeout="${3:-30}"
    local interval="${4:-1}"

    local count=0
    while [[ $count -lt $timeout ]]; do
        if command_exists nc; then
            if nc -z "$host" "$port" 2>/dev/null; then
                return 0
            fi
        elif command_exists telnet; then
            if echo "quit" | telnet "$host" "$port" 2>/dev/null | grep -q "Connected"; then
                return 0
            fi
        fi

        sleep "$interval"
        count=$((count + interval))
    done

    return 1
}

# Function to get system information
get_system_info() {
    local os="${DOTFILES_OS:-$(get_os)}"
    local arch="${DOTFILES_ARCH:-$(get_arch)}"

    echo "Operating System: $os"
    echo "Architecture: $arch"
    echo "Shell: ${DOTFILES_SHELL:-$(detect_shell)}"
    echo "Package Manager: ${DOTFILES_PACKAGE_MANAGER:-$(detect_package_manager "$os")}"
    echo "Terminal: ${DOTFILES_TERMINAL:-$(detect_terminal)}"

    case "$os" in
        macos)
            echo "macOS Version: $(sw_vers -productVersion)"
            ;;
        linux)
            if [[ -f /etc/os-release ]]; then
                source /etc/os-release
                echo "Distribution: $NAME $VERSION"
            fi
            ;;
        windows)
            echo "Windows Version: $(systeminfo | findstr /B /C:"OS Name" /C:"OS Version")"
            ;;
    esac
}

# ----------------------------------------------------------------------
# | GNU Stow Functions                                                  |
# ----------------------------------------------------------------------

# Function to check if stow is installed
stow_installed() {
    command_exists stow
}

# Function to install stow
install_stow() {
    local os="${DOTFILES_OS:-$(get_os)}"

    if stow_installed; then
        if type log_info &>/dev/null; then
            log_info "GNU Stow is already installed"
        fi
        return 0
    fi

    print_in_purple "\n >> Installing GNU Stow\n\n"

    if type log_info &>/dev/null; then
        log_info "Installing GNU Stow"
    fi

    case "$os" in
        macos)
            if command_exists brew; then
                if type execute_with_log &>/dev/null; then
                    execute_with_log "brew install stow" "Installing GNU Stow via Homebrew"
                else
                    brew install stow
                fi
            else
                print_error "Homebrew not found. Please install Homebrew first."
                return 1
            fi
            ;;
        linux)
            local package_manager="${DOTFILES_PACKAGE_MANAGER:-$(detect_package_manager linux)}"
            case "$package_manager" in
                apt)
                    if type execute_with_log &>/dev/null; then
                        execute_with_log "sudo apt update && sudo apt install -y stow" "Installing GNU Stow via apt"
                    else
                        sudo apt update && sudo apt install -y stow
                    fi
                    ;;
                yum)
                    if type execute_with_log &>/dev/null; then
                        execute_with_log "sudo yum install -y stow" "Installing GNU Stow via yum"
                    else
                        sudo yum install -y stow
                    fi
                    ;;
                dnf)
                    if type execute_with_log &>/dev/null; then
                        execute_with_log "sudo dnf install -y stow" "Installing GNU Stow via dnf"
                    else
                        sudo dnf install -y stow
                    fi
                    ;;
                pacman)
                    if type execute_with_log &>/dev/null; then
                        execute_with_log "sudo pacman -S --noconfirm stow" "Installing GNU Stow via pacman"
                    else
                        sudo pacman -S --noconfirm stow
                    fi
                    ;;
                zypper)
                    if type execute_with_log &>/dev/null; then
                        execute_with_log "sudo zypper install -y stow" "Installing GNU Stow via zypper"
                    else
                        sudo zypper install -y stow
                    fi
                    ;;
                *)
                    print_error "Unsupported package manager: $package_manager"
                    return 1
                    ;;
            esac
            ;;
        *)
            print_error "Unsupported operating system: $os"
            return 1
            ;;
    esac

    if stow_installed; then
        print_success "GNU Stow installed successfully"
        if type log_success &>/dev/null; then
            log_success "GNU Stow installed successfully"
        fi
        return 0
    else
        print_error "Failed to install GNU Stow"
        if type log_error &>/dev/null; then
            log_error "Failed to install GNU Stow"
        fi
        return 1
    fi
}

# Function to simulate stow operations
stow_simulate() {
    local package="$1"
    local stow_dir="${2:-$HOME/dotfiles/stow}"
    local target_dir="${3:-$HOME}"

    if ! stow_installed; then
        print_error "GNU Stow is not installed"
        return 1
    fi

    if type log_info &>/dev/null; then
        log_info "Simulating stow operation for package: $package"
    fi

    stow --simulate --verbose --dir="$stow_dir" --target="$target_dir" "$package"
}

# Function to install stow package
stow_install() {
    local package="$1"
    local stow_dir="${2:-$HOME/dotfiles/stow}"
    local target_dir="${3:-$HOME}"
    local force="${4:-false}"

    if ! stow_installed; then
        print_error "GNU Stow is not installed"
        return 1
    fi

    if [[ ! -d "$stow_dir/$package" ]]; then
        print_error "Stow package '$package' not found in $stow_dir"
        if type log_error &>/dev/null; then
            log_error "Stow package '$package' not found in $stow_dir"
        fi
        return 1
    fi

    if type log_info &>/dev/null; then
        log_info "Installing stow package: $package"
    fi

    local stow_cmd="stow --dir=\"$stow_dir\" --target=\"$target_dir\""

    if [[ "$force" == "true" ]]; then
        stow_cmd="$stow_cmd --adopt"
    fi

    stow_cmd="$stow_cmd \"$package\""

    if type execute_with_log &>/dev/null; then
        execute_with_log "$stow_cmd" "Installing stow package: $package"
    else
        eval "$stow_cmd"
    fi

    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        print_success "Stow package '$package' installed successfully"
        if type log_success &>/dev/null; then
            log_success "Stow package '$package' installed successfully"
        fi
    else
        print_error "Failed to install stow package '$package'"
        if type log_error &>/dev/null; then
            log_error "Failed to install stow package '$package'"
        fi
    fi

    return $exit_code
}

# Function to remove stow package
stow_remove() {
    local package="$1"
    local stow_dir="${2:-$HOME/dotfiles/stow}"
    local target_dir="${3:-$HOME}"

    if ! stow_installed; then
        print_error "GNU Stow is not installed"
        return 1
    fi

    if type log_info &>/dev/null; then
        log_info "Removing stow package: $package"
    fi

    local stow_cmd="stow --delete --dir=\"$stow_dir\" --target=\"$target_dir\" \"$package\""

    if type execute_with_log &>/dev/null; then
        execute_with_log "$stow_cmd" "Removing stow package: $package"
    else
        eval "$stow_cmd"
    fi

    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        print_success "Stow package '$package' removed successfully"
        if type log_success &>/dev/null; then
            log_success "Stow package '$package' removed successfully"
        fi
    else
        print_error "Failed to remove stow package '$package'"
        if type log_error &>/dev/null; then
            log_error "Failed to remove stow package '$package'"
        fi
    fi

    return $exit_code
}

# Function to restore stow package
stow_restore() {
    local package="$1"
    local stow_dir="${2:-$HOME/dotfiles/stow}"
    local target_dir="${3:-$HOME}"

    if ! stow_installed; then
        print_error "GNU Stow is not installed"
        return 1
    fi

    if type log_info &>/dev/null; then
        log_info "Restoring stow package: $package"
    fi

    local stow_cmd="stow --restow --dir=\"$stow_dir\" --target=\"$target_dir\" \"$package\""

    if type execute_with_log &>/dev/null; then
        execute_with_log "$stow_cmd" "Restoring stow package: $package"
    else
        eval "$stow_cmd"
    fi

    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        print_success "Stow package '$package' restored successfully"
        if type log_success &>/dev/null; then
            log_success "Stow package '$package' restored successfully"
        fi
    else
        print_error "Failed to restore stow package '$package'"
        if type log_error &>/dev/null; then
            log_error "Failed to restore stow package '$package'"
        fi
    fi

    return $exit_code
}

# Function to setup stow packages
setup_stow_packages() {
    local stow_dir="${1:-$HOME/dotfiles/stow}"
    local target_dir="${2:-$HOME}"
    local packages=("${@:3}")

    if [[ ${#packages[@]} -eq 0 ]]; then
        # Default packages
        packages=(shell git nvim ssh gnupg config)
    fi

    print_in_purple "\n >> Setting up GNU Stow packages\n\n"

    if type log_info &>/dev/null; then
        log_info "Setting up stow packages: ${packages[*]}"
    fi

    # Install stow if not already installed
    if ! install_stow; then
        return 1
    fi

    # Process each package
    for package in "${packages[@]}"; do
        if [[ -d "$stow_dir/$package" ]]; then
            # Simulate first to show what will happen
            print_in_yellow "Simulating stow operation for package: $package\n"
            stow_simulate "$package" "$stow_dir" "$target_dir"

            # Ask for confirmation
            if type ask_for_confirmation &>/dev/null; then
                ask_for_confirmation "Install stow package '$package'?"
                if answer_is_yes; then
                    stow_install "$package" "$stow_dir" "$target_dir"
                else
                    print_in_yellow "Skipping package: $package\n"
                    if type log_info &>/dev/null; then
                        log_info "Skipped stow package: $package"
                    fi
                fi
            else
                # Auto-install if no confirmation function available
                stow_install "$package" "$stow_dir" "$target_dir"
            fi
        else
            print_error "Package '$package' not found in $stow_dir"
            if type log_error &>/dev/null; then
                log_error "Package '$package' not found in $stow_dir"
            fi
        fi
    done

    print_success "Stow package setup completed"
    if type log_success &>/dev/null; then
        log_success "Stow package setup completed"
    fi
}
