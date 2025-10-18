#!/usr/bin/env zsh
# Environment detection script for multi-platform support

# Function to detect the operating system
detect_os() {
    local os_name=""

    case "$(uname -s)" in
        Darwin*)
            os_name="macos"
            ;;
        Linux*)
            os_name="linux"
            ;;
        CYGWIN*|MINGW*|MSYS*)
            os_name="windows"
            ;;
        *)
            os_name="unknown"
            ;;
    esac

    echo "$os_name"
}

# Function to detect the shell
detect_shell() {
    local shell_name=""

    if [[ -n "$ZSH_VERSION" ]]; then
        shell_name="zsh"
    elif [[ -n "$BASH_VERSION" ]]; then
        shell_name="bash"
    elif [[ -n "$PSVersionTable" ]]; then
        shell_name="powershell"
    else
        shell_name="unknown"
    fi

    echo "$shell_name"
}

# Function to detect the package manager
detect_package_manager() {
    local os="$1"
    local package_manager=""

    case "$os" in
        macos)
            if command -v brew >/dev/null 2>&1; then
                package_manager="homebrew"
            else
                package_manager="homebrew"
            fi
            ;;
        linux)
            if command -v apt >/dev/null 2>&1; then
                package_manager="apt"
            elif command -v yum >/dev/null 2>&1; then
                package_manager="yum"
            elif command -v dnf >/dev/null 2>&1; then
                package_manager="dnf"
            elif command -v pacman >/dev/null 2>&1; then
                package_manager="pacman"
            elif command -v zypper >/dev/null 2>&1; then
                package_manager="zypper"
            else
                package_manager="unknown"
            fi
            ;;
        windows)
            if command -v winget >/dev/null 2>&1; then
                package_manager="winget"
            elif command -v choco >/dev/null 2>&1; then
                package_manager="chocolatey"
            else
                package_manager="winget"
            fi
            ;;
        *)
            package_manager="unknown"
            ;;
    esac

    echo "$package_manager"
}

# Function to detect the terminal
detect_terminal() {
    local terminal=""

    if [[ -n "$WEZTERM_PANE" ]]; then
        terminal="wezterm"
    elif [[ -n "$ITERM_SESSION_ID" ]]; then
        terminal="iterm2"
    elif [[ -n "$TERM_PROGRAM" ]]; then
        terminal="$TERM_PROGRAM"
    elif [[ -n "$TERMINAL_EMULATOR" ]]; then
        terminal="$TERMINAL_EMULATOR"
    else
        terminal="unknown"
    fi

    echo "$terminal"
}

# Function to get environment information
get_environment_info() {
    local os=$(detect_os)
    local shell=$(detect_shell)
    local package_manager=$(detect_package_manager "$os")
    local terminal=$(detect_terminal)

    echo "OS: $os"
    echo "Shell: $shell"
    echo "Package Manager: $package_manager"
    echo "Terminal: $terminal"
}

# Export environment variables
export JARVIS_OS=$(detect_os)
export JARVIS_SHELL=$(detect_shell)
export JARVIS_PACKAGE_MANAGER=$(detect_package_manager "$JARVIS_OS")
export JARVIS_TERMINAL=$(detect_terminal)

# Log environment detection
if type log_info &>/dev/null; then
    log_info "Environment detected:"
    log_info "  OS: $JARVIS_OS"
    log_info "  Shell: $JARVIS_SHELL"
    log_info "  Package Manager: $JARVIS_PACKAGE_MANAGER"
    log_info "  Terminal: $JARVIS_TERMINAL"
fi
