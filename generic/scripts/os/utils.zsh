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

# Function to create directories
create_directories() {
    local dirs=(
        "$HOME/.config"
        "$HOME/.local/bin"
        "$HOME/.local/share"
        "$HOME/.cache"
        "$HOME/.logs"
    )

    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            if type log_info &>/dev/null; then
                log_info "Created directory: $dir"
            fi
        fi
    done
}

# Function to backup existing files
backup_file() {
    local file="$1"
    local backup_dir="$HOME/.jarvistoolset/backups"

    if [[ -f "$file" ]]; then
        mkdir -p "$backup_dir"
        local backup_file="${backup_dir}/$(basename "$file").$(date +%Y%m%d_%H%M%S).bak"
        cp "$file" "$backup_file"
        if type log_info &>/dev/null; then
            log_info "Backed up $file to $backup_file"
        fi
    fi
}

# Function to create symbolic link
create_symlink() {
    local source="$1"
    local target="$2"

    if [[ -L "$target" ]]; then
        rm "$target"
    elif [[ -f "$target" ]]; then
        backup_file "$target"
        rm "$target"
    fi

    ln -s "$source" "$target"
    if type log_info &>/dev/null; then
        log_info "Created symbolic link: $target -> $source"
    fi
}

# Function to install package using platform-specific package manager
install_package() {
    local package="$1"
    local os="${JARVIS_OS:-$(get_os)}"

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
            local package_manager="${JARVIS_PACKAGE_MANAGER:-$(detect_package_manager linux)}"
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
    local os="${JARVIS_OS:-$(get_os)}"

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
    local os="${JARVIS_OS:-$(get_os)}"
    local arch="${JARVIS_ARCH:-$(get_arch)}"

    echo "Operating System: $os"
    echo "Architecture: $arch"
    echo "Shell: ${JARVIS_SHELL:-$(detect_shell)}"
    echo "Package Manager: ${JARVIS_PACKAGE_MANAGER:-$(detect_package_manager "$os")}"
    echo "Terminal: ${JARVIS_TERMINAL:-$(detect_terminal)}"

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
