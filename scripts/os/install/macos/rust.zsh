#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Rust Development Tools\n\n"

# Install Rust using rustup
rustup_install

# Source cargo environment
source "$HOME/.cargo/env"

# Update Rust
rustup_update

# Install additional toolchains
print_in_purple "\n   Installing Rust Toolchains\n\n"
rustup_toolchain_install "Nightly Toolchain" "nightly"
rustup_component_add "Rust Source" "rust-src"
rustup_component_add "Rust Analyzer" "rust-analyzer"
rustup_component_add "Clippy" "clippy"
rustup_component_add "Rustfmt" "rustfmt"

# Install cargo extensions
print_in_purple "\n   Installing Cargo Extensions\n\n"

# Build Tools
cargo_install "Cargo Edit" "cargo-edit"
cargo_install "Cargo Watch" "cargo-watch"
cargo_install "Cargo Expand" "cargo-expand"
cargo_install "Cargo Update" "cargo-update"
cargo_install "Cargo Audit" "cargo-audit"
cargo_install "Cargo Outdated" "cargo-outdated"
cargo_install "Cargo Bloat" "cargo-bloat"
cargo_install "Cargo Flamegraph" "flamegraph"

# Development Tools
cargo_install "Cargo Modules" "cargo-modules"
cargo_install "Cargo Tree" "cargo-tree"

# Testing Tools
cargo_install "Cargo Tarpaulin" "cargo-tarpaulin"
cargo_install "Cargo Nextest" "cargo-nextest"
cargo_install "Cargo Criterion" "cargo-criterion"

# Documentation
cargo_install "Cargo Doc" "cargo-doc"
cargo_install "Mdbook" "mdbook"

# Debugging and Profiling
cargo_install "Cargo Profiler" "cargo-profiler"

# Web Development
cargo_install "Trunk" "trunk"
cargo_install "Wasm Pack" "wasm-pack"

# CLI Development
cargo_install "Cargo Generate" "cargo-generate"
cargo_install "Cargo Make" "cargo-make"

# Optional Development Tools
# Uncomment if needed
# cargo_install "Cargo Deny" "cargo-deny"
# cargo_install "Cargo Udeps" "cargo-udeps"
# cargo_install "Cargo Limit" "cargo-limit"

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
