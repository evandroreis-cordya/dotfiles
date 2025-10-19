#!/usr/bin/env zsh
# Generic logging functions for multi-platform support

# Global variables for logging
CURRENT_LOG_FILE=""
LOGS_DIR="$HOME/dotfiles/logs"

# Initialize logging
init_logging() {
    # Create timestamp in format YYYY-MM-DD-HHMMSS
    local timestamp=$(date "+%Y-%m-%d-%H%M%S")

    # Create log filename
    CURRENT_LOG_FILE="${LOGS_DIR}/dotfiles-${timestamp}.log"

    # Ensure logs directory exists
    mkdir -p "$(dirname "$CURRENT_LOG_FILE")" 2>/dev/null

    # Create empty log file
    touch "$CURRENT_LOG_FILE"

    # Print log file location
    echo -e "\n >> Logging initialized\n\n   Log file: $CURRENT_LOG_FILE\n"

    # Add header to log file
    {
        echo "========================================================"
        echo "  DOTFILES TOOLSET INSTALLATION LOG"
        echo "  Started: $(date)"
        echo "  Hostname: $(hostname)"
        echo "  User: $(whoami)"
        echo "  OS: ${DOTFILES_OS:-$(get_os)}"
        echo "  Shell: ${DOTFILES_SHELL:-$(detect_shell)}"
        echo "========================================================"
        echo ""
    } >> "$CURRENT_LOG_FILE"
}

# Log a message to the log file
log_message() {
    local message="$1"
    local level="${2:-INFO}"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    # Initialize logging if not already done
    if [[ -z "$CURRENT_LOG_FILE" || ! -f "$CURRENT_LOG_FILE" ]]; then
        init_logging
    fi

    # Ensure logs directory exists
    if [[ ! -d "$(dirname "$CURRENT_LOG_FILE")" ]]; then
        mkdir -p "$(dirname "$CURRENT_LOG_FILE")" 2>/dev/null
    fi

    echo "[${timestamp}] [${level}] ${message}" >> "$CURRENT_LOG_FILE"
}

# Logging functions
log_info() {
    log_message "$1" "INFO"
}

log_warning() {
    log_message "$1" "WARNING"
}

log_error() {
    log_message "$1" "ERROR"
}

log_success() {
    log_message "$1" "SUCCESS"
}

log_debug() {
    log_message "$1" "DEBUG"
}

# Log command execution
log_command() {
    local command="$1"
    local description="${2:-$command}"
    log_info "Executing: $description"

    local output
    if output=$(eval "$command" 2>&1); then
        log_success "Command succeeded: $description"
        if [[ -n "$output" ]]; then
            {
                echo "--- Command output start ---"
                echo "$output"
                echo "--- Command output end ---"
                echo ""
            } >> "$CURRENT_LOG_FILE"
        fi
        return 0
    else
        local exit_code=$?
        log_error "Command failed (exit code $exit_code): $description"
        if [[ -n "$output" ]]; then
            {
                echo "--- Command output start ---"
                echo "$output"
                echo "--- Command output end ---"
                echo ""
            } >> "$CURRENT_LOG_FILE"
        fi
        return $exit_code
    fi
}

# Execute command with logging
execute_with_log() {
    local cmd="$1"
    local msg="${2:-$1}"
    print_in_yellow "   $msg..."
    log_command "$cmd" "$msg"
    local exit_code=$?
    print_result $exit_code "$msg"
    return $exit_code
}

# Log system information
log_system_info() {
    log_info "System Information:"
    log_info "  OS: ${DOTFILES_OS:-$(get_os)}"
    log_info "  Architecture: ${DOTFILES_ARCH:-$(get_arch)}"
    log_info "  Shell: ${DOTFILES_SHELL:-$(detect_shell)}"
    log_info "  Package Manager: ${DOTFILES_PACKAGE_MANAGER:-$(detect_package_manager "${DOTFILES_OS:-$(get_os)}")}"
    log_info "  Terminal: ${DOTFILES_TERMINAL:-$(detect_terminal)}"
    log_info "  User: $(whoami)"
    log_info "  Hostname: $(hostname)"
    log_info "  Home Directory: $HOME"

    # OS-specific system information
    case "${DOTFILES_OS:-$(get_os)}" in
        macos)
            log_info "  macOS Version: $(sw_vers -productVersion)"
            log_info "  macOS Build: $(sw_vers -buildVersion)"
            ;;
        linux)
            if [[ -f /etc/os-release ]]; then
                source /etc/os-release
                log_info "  Distribution: $NAME $VERSION"
                log_info "  Kernel: $(uname -r)"
            fi
            ;;
        windows)
            log_info "  Windows Version: $(systeminfo | findstr /B /C:"OS Name" /C:"OS Version")"
            ;;
    esac
}

# Log environment variables
log_environment() {
    log_info "Environment Variables:"
    log_info "  DOTFILES_OS: $DOTFILES_OS"
    log_info "  DOTFILES_SHELL: $DOTFILES_SHELL"
    log_info "  DOTFILES_PACKAGE_MANAGER: $DOTFILES_PACKAGE_MANAGER"
    log_info "  DOTFILES_TERMINAL: $DOTFILES_TERMINAL"
    log_info "  HOSTNAME: $HOSTNAME"
    log_info "  USERNAME: $USERNAME"
    log_info "  EMAIL: $EMAIL"
    log_info "  DIRECTORY: $DIRECTORY"
}

# Log installation progress
log_installation_progress() {
    local step="$1"
    local total="$2"
    local description="$3"

    log_info "Installation Progress: Step $step of $total - $description"
}

# Log package installation
log_package_install() {
    local package="$1"
    local method="$2"
    local version="${3:-unknown}"

    log_info "Package Installation:"
    log_info "  Package: $package"
    log_info "  Method: $method"
    log_info "  Version: $version"
}

# Log configuration changes
log_config_change() {
    local file="$1"
    local action="$2"
    local description="$3"

    log_info "Configuration Change:"
    log_info "  File: $file"
    log_info "  Action: $action"
    log_info "  Description: $description"
}

# Log error with context
log_error_with_context() {
    local error="$1"
    local context="$2"
    local suggestion="${3:-}"

    log_error "Error: $error"
    log_error "Context: $context"
    if [[ -n "$suggestion" ]]; then
        log_error "Suggestion: $suggestion"
    fi
}

# Log performance metrics
log_performance() {
    local operation="$1"
    local duration="$2"
    local memory_usage="${3:-}"
    local cpu_usage="${4:-}"

    log_info "Performance Metrics:"
    log_info "  Operation: $operation"
    log_info "  Duration: ${duration}s"
    if [[ -n "$memory_usage" ]]; then
        log_info "  Memory Usage: $memory_usage"
    fi
    if [[ -n "$cpu_usage" ]]; then
        log_info "  CPU Usage: $cpu_usage"
    fi
}

# Finalize logging
finalize_logging() {
    if [[ -n "$CURRENT_LOG_FILE" && -f "$CURRENT_LOG_FILE" ]]; then
        {
            echo ""
            echo "========================================================"
            echo "  DOTFILES TOOLSET INSTALLATION COMPLETED"
            echo "  Finished: $(date)"
            echo "  Total Duration: $(($(date +%s) - $(stat -f %B "$CURRENT_LOG_FILE" 2>/dev/null || echo $(date +%s)))) seconds"
            echo "========================================================"
        } >> "$CURRENT_LOG_FILE"

        log_info "Logging finalized. Log file: $CURRENT_LOG_FILE"
    fi
}

# Clean up old log files
cleanup_logs() {
    local days_to_keep="${1:-7}"
    local log_pattern="${LOGS_DIR}/dotfiles-*.log"

    if [[ -d "$LOGS_DIR" ]]; then
        find "$LOGS_DIR" -name "dotfiles-*.log" -type f -mtime +$days_to_keep -delete 2>/dev/null
        log_info "Cleaned up log files older than $days_to_keep days"
    fi
}

# Export logging functions
export -f log_info log_warning log_error log_success log_debug log_command execute_with_log log_system_info log_environment log_installation_progress log_package_install log_config_change log_error_with_context log_performance finalize_logging cleanup_logs
