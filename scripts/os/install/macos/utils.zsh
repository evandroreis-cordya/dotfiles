#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_cleanup() {
    # By default Homebrew does not uninstall older versions
    # of formulas so, in order to remove them, `brew cleanup`
    # needs to be used.
    #
    # https://github.com/Homebrew/brew/blob/master/docs/FAQ.md#how-do-i-uninstall-old-versions-of-a-formula

    execute "brew cleanup" "Homebrew (cleanup)"
}

brew_install() {
    local -r FORMULA_READABLE_NAME="$1"
    local -r FORMULA="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags like --cask

    # Check if Homebrew is installed
    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME (Homebrew is not installed)"
        return 1
    fi

    # Install or upgrade formula
    if brew list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME (already installed)"
    else
        if [[ -n "$INSTALL_FLAGS" ]]; then
            execute "brew install $FORMULA $INSTALL_FLAGS" "$FORMULA_READABLE_NAME"
        else
            execute "brew install $FORMULA" "$FORMULA_READABLE_NAME"
        fi
    fi
}

brew_prefix() {
    local path=""

    if path="$(brew --prefix 2> /dev/null)"; then
        printf "%s" "$path"
        return 0
    fi

    return 1
}

brew_tap() {
    brew tap "$1" &> /dev/null
}

brew_update() {
    # Initialize Homebrew directories if needed
    if ! is_dir "$(brew --repo)"; then
        execute "git clone https://github.com/Homebrew/brew $(brew --repo)" "Initialize Homebrew repository"
    fi

    execute "brew update" "Homebrew (update)"
}

brew_upgrade() {
    execute "brew upgrade" "Homebrew (upgrade)"
    execute "brew upgrade --cask" "Homebrew Casks (upgrade)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Additional utility functions for Homebrew management

brew_doctor() {
    execute "brew doctor" "Check Homebrew for issues"
}

brew_missing() {
    execute "brew missing" "Check for missing dependencies"
}

brew_autoremove() {
    execute "brew autoremove" "Remove unused dependencies"
}

brew_list_leaves() {
    # List installed formulae that are not dependencies of another installed formula
    execute "brew leaves" "List top-level formulae"
}

brew_list_casks() {
    execute "brew list --cask" "List installed casks"
}

brew_outdated() {
    execute "brew outdated" "Check for outdated formulae"
    execute "brew outdated --cask" "Check for outdated casks"
}
