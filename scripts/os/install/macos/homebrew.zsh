#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

get_homebrew_git_config_file_path() {
    local path=""

    if path="$(brew --repository 2> /dev/null)/.git/config"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get config file path)"
        return 1
    fi
}

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        print_in_purple "\n   Installing Homebrew\n\n"
        
        # Install Homebrew using the official script
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ "$(uname -m)" == "arm64" ]]; then
            # Apple Silicon
            if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"; then
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
        else
            # Intel
            if ! grep -q 'eval "$(/usr/local/bin/brew shellenv)"' "$HOME/.zprofile"; then
                echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        fi
        
        print_result $? "Homebrew installation"
    else
        print_success "Homebrew is already installed"
        
        # Update Homebrew
        print_info "Updating Homebrew..."
        brew update
        print_result $? "Homebrew update"
    fi
}

configure_homebrew() {
    print_in_purple "\n   Configuring Homebrew\n\n"

    # Opt-out of Homebrew's analytics
    brew analytics off &> /dev/null

    # Note: The following taps have been deprecated as their contents
    # have been migrated to the main Homebrew repositories
    # No need to tap them explicitly anymore

    # Update Homebrew recipes
    brew update &> /dev/null

    # Upgrade any already-installed formulae
    brew upgrade &> /dev/null

    # Remove outdated versions from the cellar
    brew cleanup &> /dev/null

    print_result $? "Homebrew (configuration)"
}

setup_homebrew_environment() {
    print_in_purple "\n   Setting up Homebrew environment\n\n"

    # Create Homebrew directories if they don't exist
    local -a BREW_DIRS=(
        "/opt/homebrew/etc"
        "/opt/homebrew/var"
        "/opt/homebrew/opt"
        "/opt/homebrew/share"
    )

    for dir in $BREW_DIRS; do
        if [[ ! -d "$dir" ]]; then
            sudo mkdir -p "$dir"
            sudo chown -R "$(whoami):admin" "$dir"
        fi
    done

    # Set Homebrew environment variables
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    
    print_result $? "Homebrew (environment setup)"
}

create_homebrew_config() {
    local config_dir="$HOME/.jarvistoolset/zsh_configs"
    local config_file="$config_dir/homebrew.zsh"
    
    # Create directory if it doesn't exist
    mkdir -p "$config_dir"
    
    # Create Homebrew configuration file
    cat > "$config_file" << 'EOL'
#!/bin/zsh
#
# Homebrew configuration for zsh
# This file contains all Homebrew-related configurations
#

# Homebrew environment setup
if [[ "$(uname -m)" == "arm64" ]]; then
    # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Homebrew aliases
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewls="brew list"
alias brewi="brew install"
alias brewci="brew install --cask"
alias brewrm="brew uninstall"
alias brewsr="brew search"
alias brewinfo="brew info"
alias brewdeps="brew deps --tree --installed"
alias brewdoc="brew doctor"
alias brewout="brew outdated"
EOL
    
    print_result $? "Created Homebrew configuration file"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n >> Installing and configuring Homebrew\n\n"

    install_homebrew
    setup_homebrew_environment
    configure_homebrew
    
    # Create modular configuration
    create_homebrew_config

    # Check if oh-my-zsh.zsh is already sourcing the modular configs
    if ! grep -q "source \"\$HOME/.jarvistoolset/zsh_configs/homebrew.zsh\"" "$HOME/.zshrc"; then
        # Add a line to source the Homebrew config in .zshrc if oh-my-zsh.zsh isn't handling it
        cat >> "$HOME/.zshrc" << 'EOL'
# Load Homebrew configuration
source "$HOME/.jarvistoolset/zsh_configs/homebrew.zsh"
EOL
        print_result $? "Added Homebrew configuration to .zshrc"
    fi

    print_in_green "\n  Homebrew installed and configured!\n"
}

main
