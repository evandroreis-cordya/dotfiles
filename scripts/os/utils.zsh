#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | User Input Functions                                                 |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read -r
}

ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -r -k 1
    print
}

ask_for_sudo() {
    # Ask for the administrator password upfront
    sudo -v &> /dev/null

    # Update existing `sudo` time stamp
    # until this script finishes
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &> /dev/null &
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Command Execution Functions                                          |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cmd_exists() {
    (( $+commands[$1] ))
}

execute() {
    local -r CMDS="$1"
    local -r MSG="${2:-$1}"
    local -r TMP_FILE="$(mktemp /tmp/XXXXX)"

    local exitCode=0
    local cmdsPID=""

    # If the current process is ended,
    # also end all its subprocesses.
    set_trap "EXIT" "kill_all_subprocesses"

    # Execute commands in background
    # Ensure we're only executing the command, not the message
    ( eval "$CMDS" ) \
        &> /dev/null \
        2> "$TMP_FILE" &

    cmdsPID=$!

    # Show a spinner if the commands
    # require more time to complete.
    show_spinner "$cmdsPID" "$CMDS" "$MSG"

    # Wait for the commands to complete.
    wait "$cmdsPID" &> /dev/null
    exitCode=$?

    print_result $exitCode "$MSG"

    if [ $exitCode -ne 0 ]; then
        print_error_stream < "$TMP_FILE"
    fi

    rm -rf "$TMP_FILE"

    return $exitCode
}

kill_all_subprocesses() {
    local i=""

    for i in $(jobs -p); do
        kill "$i"
        wait "$i" &> /dev/null
    done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | System Information Functions                                         |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

get_os() {
    local os=""
    local kernelName=""

    kernelName="$(uname -s)"

    if [ "$kernelName" = "Darwin" ]; then
        os="macos"
    elif [ "$kernelName" = "Linux" ] && [ -e "/etc/lsb-release" ]; then
        os="ubuntu"
    else
        os="$kernelName"
    fi

    printf "%s" "$os"
}

get_os_version() {
    local os=""
    local version=""

    os="$(get_os)"

    if [ "$os" = "macos" ]; then
        version="$(sw_vers -productVersion)"
    elif [ "$os" = "ubuntu" ]; then
        version="$(lsb_release -d | cut -f2 | cut -d' ' -f2)"
    fi

    printf "%s" "$version"
}

is_supported_version() {
    declare -r MINIMUM_VERSION="$2"
    declare -r SUBJECT_VERSION="$1"

    if [ "${SUBJECT_VERSION}" = "${MINIMUM_VERSION}" ]; then
        return 0
    fi

    IFS='.' read -r -a minimum_version <<< "$MINIMUM_VERSION"
    IFS='.' read -r -a subject_version <<< "$SUBJECT_VERSION"

    if [ "${#minimum_version[@]}" -ne "${#subject_version[@]}" ]; then
        return 1
    fi

    for i in "${!minimum_version[@]}"; do
        if [ "${subject_version[i]}" -lt "${minimum_version[i]}" ]; then
            return 1
        elif [ "${subject_version[i]}" -gt "${minimum_version[i]}" ]; then
            return 0
        fi
    done

    return 0
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Package Management Functions                                         |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r FORMULA="$2"
    declare -r CMD="$3"

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME ('brew' is not installed)"
        return 1
    fi

    if [ "$CMD" = "--cask" ]; then
        if brew list --cask "$FORMULA" &> /dev/null; then
            print_success "$FORMULA_READABLE_NAME"
        else
            execute "brew install --cask $FORMULA" "$FORMULA_READABLE_NAME"
        fi
    else
        if brew list "$FORMULA" &> /dev/null; then
            print_success "$FORMULA_READABLE_NAME"
    else
            execute "brew install $FORMULA" "$FORMULA_READABLE_NAME"
        fi
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | File System Functions                                                |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_directory() {
    local directory="${1}"
    
    if [[ ! -d "$directory" ]]; then
        execute "mkdir -p $directory" "Creating directory: $directory"
    else
        print_success "Directory exists: $directory"
    fi
}

extract() {
    local archive="$1"
    local outputDir="$2"

    if (( $+commands[tar] )); then
        tar -zxf "$archive" --strip-components 1 -C "$outputDir"
        return $?
    fi

    return 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Python Package Management Functions                                  |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pip_install() {
    local package="$1"
    local message="$2"
    execute "pip3 install $package" "$message"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Print Functions                                                      |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_in_green() {
    print_in_color "$1" 2
}

print_in_purple() {
    print_in_color "$1" 5
}

print_in_red() {
    print_in_color "$1" 1
}

print_in_yellow() {
    print_in_color "$1" 3
}

print_question() {
    print_in_yellow "  [?] $1"
}

print_error() {
    print_in_red "  [✖] $1 $2\n"
}

print_error_stream() {
    while read -r line; do
        print_error "↳ ERROR: $line"
    done
}

print_success() {
    print_in_green "  [✔] $1\n"
}

print_warning() {
    print_in_yellow "  [!] $1\n"
}

print_result() {
    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Process Management Functions                                         |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_trap() {
    trap -p "$1" | grep "$2" &> /dev/null \
        || trap '$2' "$1"
}

show_spinner() {
    local -r FRAMES='/-\|'

    local -r NUMBER_OR_FRAMES=${#FRAMES}
    local -r CMDS="$2"
    local -r MSG="$3"
    local -r PID="$1"

    local i=0
    local frameText=""

    # Display spinner while the commands are being executed.
    while kill -0 "$PID" &>/dev/null; do
        # Fix for zsh substring syntax
        local idx=$((i % NUMBER_OR_FRAMES))
        local frame=${FRAMES:$idx:1}
        frameText="  [$frame] $MSG"

        printf "%s" "$frameText"
        sleep 0.2
        printf "\r"
        ((i++))
    done
}
