#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Rust Development Tools\n\n"

# Install Rust using rustup
if ! command -v rustup &> /dev/null; then
    print_in_purple "\n   Installing Rust\n\n"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Add Rust to PATH
if ! grep -q '$HOME/.cargo/bin' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# Rust configuration
export PATH="$HOME/.cargo/bin:$PATH"
EOL
fi

# Source cargo environment
source "$HOME/.cargo/env"

# Update Rust
print_in_purple "\n   Updating Rust\n\n"
rustup update

# Install additional toolchains
print_in_purple "\n   Installing Rust Toolchains\n\n"
rustup toolchain install nightly
rustup component add rust-src
rustup component add rust-analyzer
rustup component add clippy
rustup component add rustfmt

# Install cargo extensions
print_in_purple "\n   Installing Cargo Extensions\n\n"

# Build Tools
cargo install cargo-edit     # Add/remove dependencies
cargo install cargo-watch   # Watch for changes
cargo install cargo-update # Update dependencies
cargo install cargo-audit # Security audit

# Development Tools
cargo install cargo-expand    # Show expanded macros
cargo install cargo-modules  # Show module structure
cargo install cargo-tree    # Dependency tree
cargo install cargo-outdated # Find outdated dependencies

# Testing Tools
cargo install cargo-tarpaulin  # Code coverage
cargo install cargo-nextest   # Fast test runner
cargo install cargo-criterion # Benchmarking

# Documentation
cargo install cargo-doc
cargo install mdbook      # Documentation generator

# Debugging and Profiling
cargo install cargo-flamegraph # Performance profiling
cargo install cargo-profiler  # CPU profiling

# Web Development
cargo install trunk       # WASM bundler
cargo install wasm-pack  # WebAssembly

# CLI Development
cargo install cargo-generate # Project templates
cargo install cargo-make    # Task runner

# Optional Development Tools
# Uncomment if needed
# cargo install cargo-bloat    # Binary size analysis
# cargo install cargo-deny    # License checking
# cargo install cargo-udeps  # Find unused dependencies
# cargo install cargo-limit # Limit build resources

# Configure Rust
mkdir -p "$HOME/.cargo"
cat > "$HOME/.cargo/config.toml" << 'EOL'
[build]
rustc-wrapper = "sccache"  # Speed up compilation

[target.x86_64-apple-darwin]
rustflags = ["-C", "link-arg=-undefined", "-C", "link-arg=dynamic_lookup"]

[profile.dev]
opt-level = 0
debug = true

[profile.release]
opt-level = 3
debug = false
lto = true
codegen-units = 1
panic = 'abort'

[alias]
b = "build"
c = "check"
t = "test"
r = "run"
rr = "run --release"
EOL

# Add Rust helper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

# Rust development functions
new-rust() {
    if [[ -n "$1" ]]; then
        cargo new "$1"
        cd "$1"
        cargo add tokio serde serde_json anyhow thiserror
        cargo add --dev pretty_assertions
        git init
        git add .
        git commit -m "Initial commit"
    else
        echo "Please provide a project name"
    fi
}

# Cargo aliases
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cc="cargo check"
alias cf="cargo fmt"
alias cn="cargo new"
alias ca="cargo add"
EOL

print_result $? "Rust development environment"

# Install additional dependencies
brew_install "sccache" "sccache"  # Compilation cache
