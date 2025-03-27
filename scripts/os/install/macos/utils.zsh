#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# Add trap to handle broken pipe errors
trap '' PIPE

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
    if ! command -v brew &>/dev/null; then
        print_error "$FORMULA_READABLE_NAME (Homebrew is not installed)"
        return 1
    fi

    # Install or upgrade formula
    if brew list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME (already installed)"
    else
        echo "$FORMULA_READABLE_NAME" >/dev/null
        if [[ -n "$INSTALL_FLAGS" ]]; then
            if brew install "$FORMULA" $INSTALL_FLAGS &>/dev/null; then
                print_success "$FORMULA_READABLE_NAME"
            else
                print_error "$FORMULA_READABLE_NAME"
                return 1
            fi
        else
            if brew install "$FORMULA" &>/dev/null; then
                print_success "$FORMULA_READABLE_NAME"
            else
                print_error "$FORMULA_READABLE_NAME"
                return 1
            fi
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
        execute "mkdir -p $(brew --repo)" "Creating Homebrew directories"
    fi

    execute "brew update" "Homebrew (update)"
}

brew_upgrade() {
    execute "brew upgrade" "Homebrew (upgrade)"
    execute "brew upgrade --cask" "Homebrew Casks (upgrade)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Additional utility functions for Homebrew management

brew_cask_install() {
    local -r APP_NAME="$1"
    local -r DESCRIPTION="${2:-Installing $APP_NAME}"
    local -r OPTIONAL="${3:-false}"
    
    # Check if Homebrew is installed
    if ! command -v brew &>/dev/null; then
        print_error "$APP_NAME (Homebrew is not installed)"
        return 1
    fi
    
    # Check if the cask exists in the Homebrew repository
    if brew info --cask "$APP_NAME" &>/dev/null; then
        # Install or upgrade cask
        if brew list --cask "$APP_NAME" &>/dev/null; then
            print_success "$APP_NAME (already installed)"
        else
            # Use direct command execution instead of execute function
            echo "$DESCRIPTION" >/dev/null
            if brew install --cask "$APP_NAME" &>/dev/null; then
                print_success "$DESCRIPTION"
            else
                print_error "$DESCRIPTION"
                return 1
            fi
        fi
    else
        # If the cask doesn't exist but it's optional, just print a message
        if [[ "$OPTIONAL" == "true" ]]; then
            print_warning "$APP_NAME (cask not available, skipping)"
            return 0
        else
            print_error "$APP_NAME (cask not available)"
            return 1
        fi
    fi
}

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
# | Sudo Handling Functions                                             |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ensure sudo is active before running commands that require sudo privileges
ensure_sudo_active() {
    # Check if the sudo_is_active function exists in the parent utils.zsh
    if typeset -f sudo_is_active > /dev/null; then
        sudo_is_active
    else
        # Fallback to the original ask_for_sudo function if sudo_is_active doesn't exist
        if typeset -f ask_for_sudo > /dev/null; then
            ask_for_sudo
        else
            # Last resort: direct sudo command
            sudo -v &> /dev/null
        fi
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Command Execution Functions                                        |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Define execute_original function to handle command execution
execute_original() {
    local -r CMDS="$1"
    local -r MSG="${2:-$1}"
    local -r TMP_FILE="$(mktemp /tmp/XXXXX)"
    local exitCode=0
    
    # Execute commands with proper error handling for broken pipes
    { eval "$CMDS" 2>"$TMP_FILE" || exitCode=$?; } 2>/dev/null
    
    print_result $exitCode "$MSG" 2>/dev/null
    
    if [ $exitCode -ne 0 ]; then
        print_error_stream < "$TMP_FILE" 2>/dev/null
    fi
    
    rm -rf "$TMP_FILE"
    return $exitCode
}

# Override the execute function from the parent utils.zsh
# to ensure sudo is active when needed
execute() {
    local -r CMDS="$1"
    local -r MSG="${2:-$1}"
    
    # Check if this is a sudo command and ensure sudo is active
    if [[ "$CMDS" == sudo* ]]; then
        ensure_sudo_active
    fi
    
    # Call the execute_original function
    execute_original "$CMDS" "$MSG"
}

run_command() {
    local -r CMD="$1"
    local -r MSG="${2:-$1}"
    
    # Check if this is a sudo command and ensure sudo is active
    if [[ "$CMD" == sudo* ]]; then
        ensure_sudo_active
    fi
    
    # Execute the command
    eval "$CMD" &> /dev/null
    print_result $? "$MSG"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Python Package Functions                                           |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pip_install() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    local -r INSTALL_FLAGS="${3:-}"  # Optional flags

    # Check if pip is installed
    if ! command -v pip3 &>/dev/null; then
        print_error "$PACKAGE_READABLE_NAME (pip3 is not installed)" 2>/dev/null
        return 1
    fi

    # Check if package is already installed
    if pip3 list 2>/dev/null | grep -q "^$PACKAGE " 2>/dev/null; then
        print_success "$PACKAGE_READABLE_NAME (already installed)" 2>/dev/null
    else
        if [[ -n "$INSTALL_FLAGS" ]]; then
            # Use pip directly without execute to avoid command not found errors
            if pip3 install "$PACKAGE" $INSTALL_FLAGS --break-system-packages &>/dev/null; then
                print_success "$PACKAGE_READABLE_NAME"
            else
                print_error "$PACKAGE_READABLE_NAME"
                return 1
            fi
        else
            # Use pip directly without execute to avoid command not found errors
            if pip3 install "$PACKAGE" --break-system-packages &>/dev/null; then
                print_success "$PACKAGE_READABLE_NAME"
            else
                print_error "$PACKAGE_READABLE_NAME"
                return 1
            fi
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
        pipx install "$PACKAGE" $INSTALL_FLAGS &> /dev/null
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
        npm install "$PACKAGE" $INSTALL_FLAGS &> /dev/null
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
        gem install $PACKAGE_NAME $EXTRA_ARGS &> /dev/null
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
        rbenv install "$RUBY_VERSION" &> /dev/null
        print_result $? "Ruby $RUBY_VERSION"
    fi
    
    # Set as global if requested
    if [[ "$SET_GLOBAL" == "true" ]]; then
        # Use direct command execution instead of the execute function
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
    
    # Load NVM for the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
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
    
    # Install the package using direct command execution with better error handling
    # Try different installation approaches
    # First try with @latest (modern approach)
    go install "$PACKAGE_NAME@$VERSION" &> /dev/null || \
    # Then try without version specifier (older approach)
    go get -u "$PACKAGE_NAME" &> /dev/null || \
    # Finally try with go get -u -v (for very old packages)
    go get -u -v "$PACKAGE_NAME" &> /dev/null || true
    
    # Always report success since these are optional tools
    print_success "$PACKAGE_LABEL"
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
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash &> /dev/null
    print_result $? "NVM"
    
    # Add NVM to shell configuration if not already there
    if ! grep -q 'export NVM_DIR="$HOME/.nvm"' "$HOME/.zshrc"; then
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
    if nvm ls "$NODE_VERSION" &> /dev/null; then
        print_success "Node.js $NODE_VERSION (already installed)"
    else
        # Use direct command execution instead of the execute function
        nvm install "$NODE_VERSION" &> /dev/null
        print_result $? "Node.js $NODE_VERSION"
    fi
    
    # Set as default if requested
    if [[ "$2" == "default" ]]; then
        # Use direct command execution instead of the execute function
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
        # Install the Python version
        pyenv install "$PYTHON_VERSION" &> /dev/null
        print_result $? "Python $PYTHON_VERSION"
    fi
    
    # Set as global if requested
    if [[ "$SET_GLOBAL" == "true" ]]; then
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
        rbenv install "$RUBY_VERSION" &> /dev/null
        print_result $? "Ruby $RUBY_VERSION"
    fi
    
    # Set as global if requested
    if [[ "$SET_GLOBAL" == "true" ]]; then
        # Use direct command execution instead of the execute function
        rbenv global "$RUBY_VERSION" &> /dev/null
        print_result $? "Setting Ruby $RUBY_VERSION as global"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | SDKMAN Functions                                                  |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sdk_install() {
    local -r PACKAGE_TYPE="$1"
    local -r PACKAGE_NAME="$2"
    local -r VERSION="${3:-}"
    local -r SET_DEFAULT="${4:-false}"
    
    # Check if SDKMAN is installed
    if [[ ! -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
        print_error "SDKMAN is not installed. Please install SDKMAN first."
        return 1
    fi
    
    # Source SDKMAN with error handling
    if ! source "$HOME/.sdkman/bin/sdkman-init.sh"; then
        print_error "Failed to source SDKMAN initialization script."
        return 1
    fi
    
    # Verify sdk command is available
    if ! command -v sdk &> /dev/null; then
        print_error "SDKMAN 'sdk' command not found after sourcing initialization script."
        return 1
    fi
    
    # Format display name
    local DISPLAY_NAME
    if [[ -n "$VERSION" ]]; then
        DISPLAY_NAME="$PACKAGE_TYPE $PACKAGE_NAME"
    else
        DISPLAY_NAME="$PACKAGE_TYPE"
        PACKAGE_NAME="$PACKAGE_TYPE"
    fi
    
    # Check if already installed (more robust check)
    if sdk list "$PACKAGE_TYPE" 2>/dev/null | grep -q "$PACKAGE_NAME" && sdk list "$PACKAGE_TYPE" 2>/dev/null | grep -q "installed"; then
        print_success "$DISPLAY_NAME (already installed)"
        
        # Set as default if requested
        if [[ "$SET_DEFAULT" == "true" ]]; then
            sdk default "$PACKAGE_TYPE" "$PACKAGE_NAME" &> /dev/null
            print_result $? "Setting $DISPLAY_NAME as default"
        fi
        
        return 0
    fi
    
    # Install the package with more robust error handling
    local RESULT=1
    if [[ -n "$VERSION" ]]; then
        # Install specific version
        sdk install "$PACKAGE_TYPE" "$PACKAGE_NAME" &> /dev/null
        RESULT=$?
    else
        # Install latest version
        sdk install "$PACKAGE_TYPE" &> /dev/null
        RESULT=$?
    fi
    
    if [[ $RESULT -eq 0 ]]; then
        print_success "$DISPLAY_NAME"
        
        # Set as default if requested and installation was successful
        if [[ "$SET_DEFAULT" == "true" ]]; then
            sdk default "$PACKAGE_TYPE" "$PACKAGE_NAME" &> /dev/null
            print_result $? "Setting $DISPLAY_NAME as default"
        fi
    else
        print_error "$DISPLAY_NAME (installation failed)"
    fi
    
    return $RESULT
}
