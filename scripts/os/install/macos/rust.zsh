#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add warning function if not already defined
print_warning() {
    print_in_yellow "  [!] $1\n"
}

print_in_purple "\n   Rust Development Tools\n\n"

# Install Rust using rustup
if ! command -v rustup &> /dev/null; then
    print_in_purple "\n   Installing Rust\n\n"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y &> /dev/null
    print_result $? "Rustup"
    
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

# Source cargo environment
source "$HOME/.cargo/env"

# Update Rust
rustup update &> /dev/null
print_result $? "Rustup (update)"

# Install additional toolchains
print_in_purple "\n   Installing Rust Toolchains\n\n"

# Install nightly toolchain
if rustup toolchain list | grep -q "nightly"; then
    print_success "Nightly Toolchain (already installed)"
else
    rustup toolchain install nightly &> /dev/null
    print_result $? "Nightly Toolchain"
fi

# Install rust-src component
if rustup component list | grep -q "rust-src (installed)"; then
    print_success "Rust Source (already installed)"
else
    rustup component add rust-src &> /dev/null
    print_result $? "Rust Source"
fi

# Install rust-analyzer component
if rustup component list | grep -q "rust-analyzer (installed)"; then
    print_success "Rust Analyzer (already installed)"
else
    rustup component add rust-analyzer &> /dev/null
    print_result $? "Rust Analyzer"
fi

# Install clippy component
if rustup component list | grep -q "clippy (installed)"; then
    print_success "Clippy (already installed)"
else
    rustup component add clippy &> /dev/null
    print_result $? "Clippy"
fi

# Install rustfmt component
if rustup component list | grep -q "rustfmt (installed)"; then
    print_success "Rustfmt (already installed)"
else
    rustup component add rustfmt &> /dev/null
    print_result $? "Rustfmt"
fi

# Install cargo extensions
print_in_purple "\n   Installing Cargo Extensions\n\n"

# Build Tools
# Check if cargo-edit is already installed
if cargo install --list | grep -q "^cargo-edit "; then
    print_success "Cargo Edit (already installed)"
else
    cargo install cargo-edit &> /dev/null
    print_result $? "Cargo Edit"
fi

# Check if cargo-watch is already installed
if command -v cargo-watch &> /dev/null || cargo install --list | grep -q "^cargo-watch "; then
    print_success "Cargo Watch (already installed)"
else
    # Try installing with Homebrew first, then fall back to cargo
    brew install cargo-watch &> /dev/null
    print_result $? "Cargo Watch"
    if [ $? -ne 0 ]; then
        cargo install cargo-watch --features=notify &> /dev/null
        print_result $? "Cargo Watch"
    fi
fi

# Check if cargo-expand is already installed
if cargo install --list | grep -q "^cargo-expand "; then
    print_success "Cargo Expand (already installed)"
else
    cargo install cargo-expand &> /dev/null
    print_result $? "Cargo Expand"
fi

# Check if cargo-update is already installed
if cargo install --list | grep -q "^cargo-update "; then
    print_success "Cargo Update (already installed)"
else
    cargo install cargo-update &> /dev/null
    print_result $? "Cargo Update"
fi

# Check if cargo-audit is already installed
if cargo install --list | grep -q "^cargo-audit "; then
    print_success "Cargo Audit (already installed)"
else
    cargo install cargo-audit &> /dev/null
    print_result $? "Cargo Audit"
fi

# Check if cargo-outdated is already installed
if cargo install --list | grep -q "^cargo-outdated "; then
    print_success "Cargo Outdated (already installed)"
else
    cargo install cargo-outdated &> /dev/null
    print_result $? "Cargo Outdated"
fi

# Check if cargo-bloat is already installed
if cargo install --list | grep -q "^cargo-bloat "; then
    print_success "Cargo Bloat (already installed)"
else
    cargo install cargo-bloat &> /dev/null
    print_result $? "Cargo Bloat"
fi

# Check if flamegraph is already installed
if cargo install --list | grep -q "^flamegraph "; then
    print_success "Cargo Flamegraph (already installed)"
else
    cargo install flamegraph &> /dev/null
    print_result $? "Cargo Flamegraph"
fi

# Development Tools
# Check if cargo-modules is already installed
if cargo install --list | grep -q "^cargo-modules "; then
    print_success "Cargo Modules (already installed)"
else
    cargo install cargo-modules &> /dev/null
    print_result $? "Cargo Modules"
fi

# Check if cargo-tree is already installed
if cargo install --list | grep -q "^cargo-tree "; then
    print_success "Cargo Tree (already installed)"
else
    cargo install cargo-tree &> /dev/null
    print_result $? "Cargo Tree"
fi

# Testing Tools
# Check if cargo-tarpaulin is already installed
if cargo install --list | grep -q "^cargo-tarpaulin "; then
    print_success "Cargo Tarpaulin (already installed)"
else
    cargo install cargo-tarpaulin &> /dev/null
    print_result $? "Cargo Tarpaulin"
fi

# Check if cargo-nextest is already installed
if cargo install --list | grep -q "^cargo-nextest "; then
    print_success "Cargo Nextest (already installed)"
else
    cargo install cargo-nextest &> /dev/null
    print_result $? "Cargo Nextest"
fi

# Check if cargo-criterion is already installed
if cargo install --list | grep -q "^cargo-criterion "; then
    print_success "Cargo Criterion (already installed)"
else
    cargo install cargo-criterion &> /dev/null
    print_result $? "Cargo Criterion"
fi

# Documentation
# Check if cargo-docs is already installed
if command -v cargo-docs &> /dev/null || cargo install --list | grep -q "^cargo-docs "; then
    print_success "Cargo Docs (already installed)"
else
    # Try installing with Homebrew first, then fall back to cargo
    brew install cargo-docs &> /dev/null
    print_result $? "Cargo Docs"
    if [ $? -ne 0 ]; then
        cargo install cargo-docs &> /dev/null
        print_result $? "Cargo Docs"
    fi
fi

# Check if mdbook is already installed
if cargo install --list | grep -q "^mdbook "; then
    print_success "Mdbook (already installed)"
else
    cargo install mdbook &> /dev/null
    print_result $? "Mdbook"
fi

# Debugging and Profiling
# Check if cargo-profiler is already installed
if cargo install --list | grep -q "^cargo-profiler "; then
    print_success "Cargo Profiler (already installed)"
else
    cargo install cargo-profiler &> /dev/null
    print_result $? "Cargo Profiler"
fi

# Web Development
# Check if trunk is already installed
if cargo install --list | grep -q "^trunk "; then
    print_success "Trunk (already installed)"
else
    cargo install trunk &> /dev/null
    print_result $? "Trunk"
fi

# Check if wasm-pack is already installed
if cargo install --list | grep -q "^wasm-pack "; then
    print_success "Wasm Pack (already installed)"
else
    cargo install wasm-pack &> /dev/null
    print_result $? "Wasm Pack"
fi

# CLI Development
# Check if cargo-generate is already installed
if cargo install --list | grep -q "^cargo-generate "; then
    print_success "Cargo Generate (already installed)"
else
    cargo install cargo-generate &> /dev/null
    print_result $? "Cargo Generate"
fi

# Check if cargo-make is already installed
if cargo install --list | grep -q "^cargo-make "; then
    print_success "Cargo Make (already installed)"
else
    cargo install cargo-make &> /dev/null
    print_result $? "Cargo Make"
fi

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
        echo "Created new Rust project: $1"
    else
        echo "Please provide a project name"
    fi
}

# Rust aliases
alias cr="cargo run"
alias cb="cargo build"
alias ct="cargo test"
alias cc="cargo check"
alias cf="cargo fmt"
alias cca="cargo clippy -- -D warnings"
alias crr="cargo run --release"
alias cbr="cargo build --release"
EOL
# Install sccache if not already installed
if command -v sccache &> /dev/null; then
    print_success "sccache (already installed)"
else
    brew install sccache &> /dev/null
    print_result $? "sccache"
fi

print_in_green "\n  Rust development environment setup complete!\n"
