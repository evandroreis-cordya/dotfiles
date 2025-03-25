#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Homebrew Functions                                                 |
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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Command Execution Functions                                        |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

run_command() {
    local -r CMD="$1"
    local -r MSG="${2:-$1}"
    
    # Display progress indicator
    print_in_yellow "  [ ] $MSG"
    
    # Execute the command
    eval "$CMD" &> /dev/null
    local exitCode=$?
    
    # Show result
    print_result $exitCode "$MSG"
    
    return $exitCode
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Python Package Functions                                           |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pip_install() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if pip is installed
    if ! cmd_exists "pip3"; then
        print_error "$PACKAGE_READABLE_NAME (pip3 is not installed)"
        return 1
    fi

    # Check if package is already installed
    if pip3 list | grep -q "^$PACKAGE "; then
        print_success "$PACKAGE_READABLE_NAME (already installed)"
    else
        if [[ -n "$INSTALL_FLAGS" ]]; then
            execute "pip3 install $PACKAGE $INSTALL_FLAGS" "$PACKAGE_READABLE_NAME"
        else
            execute "pip3 install $PACKAGE" "$PACKAGE_READABLE_NAME"
        fi
    fi
}

pipx_install() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if pipx is installed
    if ! cmd_exists "pipx"; then
        print_error "$PACKAGE_READABLE_NAME (pipx is not installed)"
        return 1
    fi

    # Check if package is already installed
    if pipx list | grep -q "$PACKAGE"; then
        print_success "$PACKAGE_READABLE_NAME (already installed)"
    else
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] $PACKAGE_READABLE_NAME"
        if [[ -n "$INSTALL_FLAGS" ]]; then
            pipx install "$PACKAGE" $INSTALL_FLAGS &> /dev/null
        else
            pipx install "$PACKAGE" &> /dev/null
        fi
        print_result $? "$PACKAGE_READABLE_NAME"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Node.js Package Functions                                          |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

npm_install() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if npm is installed
    if ! cmd_exists "npm"; then
        print_error "$PACKAGE_READABLE_NAME (npm is not installed)"
        return 1
    fi

    # Check if package is already installed globally
    if npm list -g --depth=0 | grep -q "$PACKAGE@"; then
        print_success "$PACKAGE_READABLE_NAME (already installed)"
    else
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] $PACKAGE_READABLE_NAME"
        if [[ -n "$INSTALL_FLAGS" ]]; then
            npm install "$PACKAGE" $INSTALL_FLAGS &> /dev/null
        else
            npm install -g "$PACKAGE" &> /dev/null
        fi
        print_result $? "$PACKAGE_READABLE_NAME"
    fi
}

yarn_install() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if yarn is installed
    if ! cmd_exists "yarn"; then
        print_error "$PACKAGE_READABLE_NAME (yarn is not installed)"
        return 1
    fi

    # Check if package is already installed globally
    if yarn global list | grep -q "$PACKAGE@"; then
        print_success "$PACKAGE_READABLE_NAME (already installed)"
    else
        if [[ -n "$INSTALL_FLAGS" ]]; then
            execute "yarn global add $PACKAGE $INSTALL_FLAGS" "$PACKAGE_READABLE_NAME"
        else
            execute "yarn global add $PACKAGE" "$PACKAGE_READABLE_NAME"
        fi
    fi
}

pnpm_install() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if pnpm is installed
    if ! cmd_exists "pnpm"; then
        print_error "$PACKAGE_READABLE_NAME (pnpm is not installed)"
        return 1
    fi

    # Check if package is already installed globally
    if pnpm list -g --depth=0 | grep -q "$PACKAGE@"; then
        print_success "$PACKAGE_READABLE_NAME (already installed)"
    else
        if [[ -n "$INSTALL_FLAGS" ]]; then
            execute "pnpm add -g $PACKAGE $INSTALL_FLAGS" "$PACKAGE_READABLE_NAME"
        else
            execute "pnpm add -g $PACKAGE" "$PACKAGE_READABLE_NAME"
        fi
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Ruby Package Functions                                             |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

gem_install() {
    local -r PACKAGE_LABEL="$1"
    local -r PACKAGE_NAME="$2"
    local -r EXTRA_ARGS="${3:-}"
    
    # Check if gem is installed
    if ! cmd_exists "gem"; then
        print_error "gem is not installed. Please install Ruby first."
        return 1
    fi
    
    # Check if the package is already installed
    if gem list | grep -q "^$PACKAGE_NAME "; then
        print_success "$PACKAGE_LABEL (already installed)"
    else
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] $PACKAGE_LABEL"
        if [[ -n "$EXTRA_ARGS" ]]; then
            gem install $PACKAGE_NAME $EXTRA_ARGS &> /dev/null
        else
            gem install $PACKAGE_NAME &> /dev/null
        fi
        print_result $? "$PACKAGE_LABEL"
    fi
}

rbenv_install() {
    local -r RUBY_VERSION="$1"
    local -r SET_GLOBAL="${2:-false}"  # Whether to set as global version
    
    # Check if rbenv is installed
    if ! cmd_exists "rbenv"; then
        print_error "rbenv is not installed. Please install rbenv first."
        return 1
    fi
    
    # Initialize rbenv
    eval "$(rbenv init -)"
    
    # Check if the requested version is already installed
    if rbenv versions | grep -q "$RUBY_VERSION"; then
        print_success "Ruby $RUBY_VERSION (already installed)"
    else
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Ruby $RUBY_VERSION"
        rbenv install "$RUBY_VERSION" &> /dev/null
        print_result $? "Ruby $RUBY_VERSION"
    fi
    
    # Set as global if requested
    if [[ "$SET_GLOBAL" == "true" ]]; then
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Setting Ruby $RUBY_VERSION as global"
        rbenv global "$RUBY_VERSION" &> /dev/null
        print_result $? "Setting Ruby $RUBY_VERSION as global"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Rust Package Functions                                             |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cargo_install() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if cargo is installed
    if ! cmd_exists "cargo"; then
        print_error "$PACKAGE_READABLE_NAME (cargo is not installed)"
        return 1
    fi

    # Check if package is already installed
    if cargo install --list | grep -q "^$PACKAGE "; then
        print_success "$PACKAGE_READABLE_NAME (already installed)"
    else
        if [[ -n "$INSTALL_FLAGS" ]]; then
            execute "cargo install $PACKAGE $INSTALL_FLAGS" "$PACKAGE_READABLE_NAME"
        else
            execute "cargo install $PACKAGE" "$PACKAGE_READABLE_NAME"
        fi
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Rustup Functions                                                   |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rustup_install() {
    # Install Rust using rustup if not already installed
    if ! cmd_exists "rustup"; then
        print_in_purple "\n   Installing Rust\n\n"
        execute "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y" "Rustup"
        
        # Source cargo environment
        source "$HOME/.cargo/env"
    else
        print_success "Rustup (already installed)"
    fi
    
    # Add Rust to PATH if not already added
    if ! grep -q '$HOME/.cargo/bin' "$HOME/.zshrc"; then
        cat >> "$HOME/.zshrc" << 'EOL'

# Rust configuration
export PATH="$HOME/.cargo/bin:$PATH"
EOL
    fi
}

rustup_update() {
    # Check if rustup is installed
    if ! cmd_exists "rustup"; then
        print_error "Rustup is not installed"
        return 1
    fi
    
    # Update Rust
    execute "rustup update" "Rustup (update)"
}

rustup_toolchain_install() {
    local -r TOOLCHAIN_READABLE_NAME="$1"
    local -r TOOLCHAIN="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if rustup is installed
    if ! cmd_exists "rustup"; then
        print_error "$TOOLCHAIN_READABLE_NAME (rustup is not installed)"
        return 1
    fi

    # Install toolchain
    if rustup toolchain list | grep -q "$TOOLCHAIN"; then
        print_success "$TOOLCHAIN_READABLE_NAME (already installed)"
    else
        if [[ -n "$INSTALL_FLAGS" ]]; then
            execute "rustup toolchain install $TOOLCHAIN $INSTALL_FLAGS" "$TOOLCHAIN_READABLE_NAME"
        else
            execute "rustup toolchain install $TOOLCHAIN" "$TOOLCHAIN_READABLE_NAME"
        fi
    fi
}

rustup_component_add() {
    local -r COMPONENT_READABLE_NAME="$1"
    local -r COMPONENT="$2"
    local -r TOOLCHAIN="${3:-}"  # Optional toolchain

    # Check if rustup is installed
    if ! cmd_exists "rustup"; then
        print_error "$COMPONENT_READABLE_NAME (rustup is not installed)"
        return 1
    fi

    # Add component
    if [[ -n "$TOOLCHAIN" ]]; then
        if rustup component list --toolchain "$TOOLCHAIN" | grep -q "$COMPONENT (installed)"; then
            print_success "$COMPONENT_READABLE_NAME (already installed for $TOOLCHAIN)"
        else
            execute "rustup component add $COMPONENT --toolchain $TOOLCHAIN" "$COMPONENT_READABLE_NAME (for $TOOLCHAIN)"
        fi
    else
        if rustup component list | grep -q "$COMPONENT (installed)"; then
            print_success "$COMPONENT_READABLE_NAME (already installed)"
        else
            execute "rustup component add $COMPONENT" "$COMPONENT_READABLE_NAME"
        fi
    fi
}

rustup_target_add() {
    local -r TARGET_READABLE_NAME="$1"
    local -r TARGET="$2"
    local -r TOOLCHAIN="${3:-}"  # Optional toolchain

    # Check if rustup is installed
    if ! cmd_exists "rustup"; then
        print_error "$TARGET_READABLE_NAME (rustup is not installed)"
        return 1
    fi

    # Add target
    if [[ -n "$TOOLCHAIN" ]]; then
        if rustup target list --toolchain "$TOOLCHAIN" | grep -q "$TARGET (installed)"; then
            print_success "$TARGET_READABLE_NAME (already installed for $TOOLCHAIN)"
        else
            execute "rustup target add $TARGET --toolchain $TOOLCHAIN" "$TARGET_READABLE_NAME (for $TOOLCHAIN)"
        fi
    else
        if rustup target list | grep -q "$TARGET (installed)"; then
            print_success "$TARGET_READABLE_NAME (already installed)"
        else
            execute "rustup target add $TARGET" "$TARGET_READABLE_NAME"
        fi
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Go Package Functions                                               |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

go_install() {
    local -r PACKAGE_LABEL="$1"
    local -r PACKAGE_NAME="$2"
    local -r VERSION="${3:-latest}"
    
    # Check if go is installed
    if ! cmd_exists "go"; then
        print_error "go is not installed. Please install Go first."
        return 1
    fi
    
    # Install the package
    execute "go install $PACKAGE_NAME@$VERSION" "$PACKAGE_LABEL"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Node.js Functions                                                  |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

nvm_install() {
    local -r NVM_VERSION="${1:-v0.39.5}"  # Default to latest stable version
    
    # Check if NVM is already installed
    if [[ -d "$HOME/.nvm" ]]; then
        print_success "NVM (already installed)"
        return 0
    fi
    
    print_in_purple "\n   Installing NVM\n\n"
    
    # Use direct command execution instead of the execute function
    print_in_yellow "  [ ] NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash &> /dev/null
    print_result $? "NVM"
    
    # Add NVM to shell configuration if not already there
    if ! grep -q "NVM_DIR" "$HOME/.zshrc"; then
        cat >> "$HOME/.zshrc" << 'EOL'

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOL
    fi
    
    # Load NVM for the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

node_install() {
    local -r NODE_VERSION="${1:-lts/*}"  # Default to latest LTS version
    
    # Check if NVM is installed
    if [[ ! -d "$HOME/.nvm" ]]; then
        print_error "NVM is not installed. Please install NVM first."
        return 1
    fi
    
    # Load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Check if the requested version is already installed
    if nvm ls | grep -q "$NODE_VERSION"; then
        print_success "Node.js $NODE_VERSION (already installed)"
    else
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Node.js $NODE_VERSION"
        nvm install "$NODE_VERSION" &> /dev/null
        print_result $? "Node.js $NODE_VERSION"
    fi
    
    # Set as default if requested
    if [[ "$2" == "default" ]]; then
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Setting Node.js $NODE_VERSION as default"
        nvm alias default "$NODE_VERSION" &> /dev/null
        print_result $? "Setting Node.js $NODE_VERSION as default"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Python Functions                                                   |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pyenv_install() {
    local -r PYTHON_VERSION="$1"
    local -r SET_GLOBAL="${2:-false}"  # Whether to set as global version
    
    # Check if pyenv is installed
    if ! cmd_exists "pyenv"; then
        print_error "pyenv is not installed. Please install pyenv first."
        return 1
    fi
    
    # Set up pyenv in the current shell session if not already done
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    
    # Initialize pyenv
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    
    # Check if the requested version is already installed
    if pyenv versions | grep -q "$PYTHON_VERSION"; then
        print_success "Python $PYTHON_VERSION (already installed)"
    else
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Python $PYTHON_VERSION"
        pyenv install "$PYTHON_VERSION" &> /dev/null
        print_result $? "Python $PYTHON_VERSION"
    fi
    
    # Set as global if requested
    if [[ "$SET_GLOBAL" == "true" ]]; then
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Setting Python $PYTHON_VERSION as global"
        pyenv global "$PYTHON_VERSION" &> /dev/null
        print_result $? "Setting Python $PYTHON_VERSION as global"
    fi
}

poetry_install() {
    # Check if Poetry is already installed
    if cmd_exists "poetry"; then
        print_success "Poetry (already installed)"
    else
        execute "curl -sSL https://install.python-poetry.org | python3 -" "Poetry"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Ruby Functions                                                     |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rbenv_install() {
    local -r RUBY_VERSION="$1"
    local -r SET_GLOBAL="${2:-false}"  # Whether to set as global version
    
    # Check if rbenv is installed
    if ! cmd_exists "rbenv"; then
        print_error "rbenv is not installed. Please install rbenv first."
        return 1
    fi
    
    # Initialize rbenv
    eval "$(rbenv init -)"
    
    # Check if the requested version is already installed
    if rbenv versions | grep -q "$RUBY_VERSION"; then
        print_success "Ruby $RUBY_VERSION (already installed)"
    else
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Ruby $RUBY_VERSION"
        rbenv install "$RUBY_VERSION" &> /dev/null
        print_result $? "Ruby $RUBY_VERSION"
    fi
    
    # Set as global if requested
    if [[ "$SET_GLOBAL" == "true" ]]; then
        # Use direct command execution instead of the execute function
        print_in_yellow "  [ ] Setting Ruby $RUBY_VERSION as global"
        rbenv global "$RUBY_VERSION" &> /dev/null
        print_result $? "Setting Ruby $RUBY_VERSION as global"
    fi
}
