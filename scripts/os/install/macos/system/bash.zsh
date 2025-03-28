#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

change_default_shell() {
    local -r LOCAL_SHELL_CONFIG_FILE="$HOME/.zshrc.local"
    local configs=""
    local pathConfig=""
    local newShellPath=""
    local brewPrefix=""

    # Try to get the path of the Zsh version installed through Homebrew
    brewPrefix="$(brew --prefix)" \
        || return 1

    pathConfig="PATH=\"$brewPrefix/bin:\$PATH\""
    configs="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

$pathConfig

export SHELL=\"$brewPrefix/bin/zsh\"
"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the Homebrew directory to the list of
    # paths that will be searched for executables.

    if ! grep -q "$pathConfig" "$LOCAL_SHELL_CONFIG_FILE" 2> /dev/null; then
        execute \
            "printf '%s' '$configs' >> $LOCAL_SHELL_CONFIG_FILE" \
            "zsh (update $LOCAL_SHELL_CONFIG_FILE)"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the latest version of Zsh.

    brew_install "zsh" \
        || return 1

    newShellPath="$brewPrefix/bin/zsh"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the newly installed Zsh
    # to the list of login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for their own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if ! grep -q "$newShellPath" /etc/shells; then
        execute \
            "printf '%s\n' '$newShellPath' | sudo tee -a /etc/shells" \
            "Zsh (add shell to /etc/shells)"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set Zsh as the default shell.

    chsh -s "$newShellPath" &> /dev/null
    print_result $? "Zsh (set as default shell)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n   Shell\n\n"

    # Check if Java is installed, and install it if needed
    if ! command -v java &> /dev/null; then
        print_in_purple "\n   Installing Java Runtime (required dependency)\n\n"
        brew install --cask temurin &> /dev/null
        print_result $? "Java Runtime"
    fi

    brew_install "zsh"
    brew_install "zsh-completions"
    brew_install "zsh-syntax-highlighting"
    brew_install "zsh-autosuggestions"
    
    change_default_shell
}

main
