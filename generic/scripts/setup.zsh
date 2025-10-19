#!/usr/bin/env zsh
# Generic setup script that detects environment and calls appropriate platform script

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
DOTFILES_DIR="$HOME/dotfiles"

# Source environment detection
source "${SCRIPT_DIR}/detect_environment.zsh"

# Source utility scripts
source "${SCRIPT_DIR}/utils.zsh" 2>/dev/null || true
source "${SCRIPT_DIR}/logging.zsh" 2>/dev/null || true

# Default values for user information
HOSTNAME=${1:-$(hostname)}
USERNAME=${2:-$(whoami)}
EMAIL=${3:-"evandro.reis@cordya.ai"}
DIRECTORY=${4:-"$HOME/dotfiles"}

# Export variables for use in other scripts
export HOSTNAME
export USERNAME
export EMAIL
export DIRECTORY

# Log configuration
if type log_info &>/dev/null; then
    log_info "Generic setup configuration:"
    log_info "  Hostname: $HOSTNAME"
    log_info "  Username: $USERNAME"
    log_info "  Email: $EMAIL"
    log_info "  Directory: $DIRECTORY"
    log_info "  Detected OS: $DOTFILES_OS"
fi

# Function to call platform-specific setup
call_platform_setup() {
    local platform="$1"
    local setup_script=""

    case "$platform" in
        macos)
            setup_script="${DOTFILES_DIR}/macos/scripts/setup.zsh"
            ;;
        linux)
            setup_script="${DOTFILES_DIR}/linux/scripts/setup.zsh"
            ;;
        windows)
            setup_script="${DOTFILES_DIR}/windows/scripts/setup.ps1"
            ;;
        *)
            print_error "Unsupported platform: $platform"
            if type log_error &>/dev/null; then
                log_error "Unsupported platform: $platform"
            fi
            return 1
            ;;
    esac

    if [[ -f "$setup_script" ]]; then
        if type log_info &>/dev/null; then
            log_info "Calling platform-specific setup: $setup_script"
        fi

        # Call the platform-specific setup script
        if [[ "$platform" == "windows" ]]; then
            # For Windows PowerShell scripts
            powershell -ExecutionPolicy Bypass -File "$setup_script" "$HOSTNAME" "$USERNAME" "$EMAIL" "$DIRECTORY"
        else
            # For Unix-like systems (macOS, Linux)
            "$setup_script" "$HOSTNAME" "$USERNAME" "$EMAIL" "$DIRECTORY"
        fi

        return $?
    else
        print_error "Platform-specific setup script not found: $setup_script"
        if type log_error &>/dev/null; then
            log_error "Platform-specific setup script not found: $setup_script"
        fi
        return 1
    fi
}

# Main function
main() {
    # Display environment information
    print_in_purple "
 >> Environment Detection
"
    print_in_yellow "Detected environment:"
    print_in_yellow "  OS: $DOTFILES_OS"
    print_in_yellow "  Shell: $DOTFILES_SHELL"
    print_in_yellow "  Package Manager: $DOTFILES_PACKAGE_MANAGER"
    print_in_yellow "  Terminal: $DOTFILES_TERMINAL"

    # Verify OS support
    if [[ "$DOTFILES_OS" == "unknown" ]]; then
        print_error "Unknown operating system detected. This toolset supports macOS, Linux, and Windows."
        if type log_error &>/dev/null; then
            log_error "Unknown operating system detected"
        fi
        exit 1
    fi

    # Call platform-specific setup
    print_in_purple "
 >> Starting platform-specific setup for $DOTFILES_OS
"

    call_platform_setup "$DOTFILES_OS"
    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        print_success "Setup completed successfully for $DOTFILES_OS"
        if type log_success &>/dev/null; then
            log_success "Setup completed successfully for $DOTFILES_OS"
        fi
    else
        print_error "Setup failed for $DOTFILES_OS with exit code $exit_code"
        if type log_error &>/dev/null; then
            log_error "Setup failed for $DOTFILES_OS with exit code $exit_code"
        fi
    fi

    return $exit_code
}

# Run main function
main "$@"
