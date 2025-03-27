#!/bin/zsh
#
# Rust configuration for zsh
# This file contains all Rust-related configurations
#

# Rust environment variables
export RUSTUP_HOME="$HOME/.rustup"
export CARGO_HOME="$HOME/.cargo"

# Add Cargo binaries to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Rust aliases
alias rustc-update="rustup update"
alias cargo-update="cargo install-update -a"

# Rust project creation function
new-rust() {
    if [ $# -ne 1 ]; then
        echo "Usage: new-rust <project-name>"
        return 1
    fi
    
    local project_name=$1
    
    # Create a new Rust project
    cargo new "$project_name"
    
    # Navigate to the project directory
    cd "$project_name" || return
    
    # Initialize git repository if git is available
    if command -v git >/dev/null 2>&1; then
        git init
        echo "target/" > .gitignore
        git add .
        git commit -m "Initial commit"
    fi
    
    echo "Rust project '$project_name' created successfully!"
}
