#!/bin/zsh
#==============================================================================
# CONFIGURATION LOAD ORDER
#==============================================================================
# This file defines the optimal loading sequence for all configuration files
# to avoid conflicts and ensure proper initialization.
#
# Loading Order:
# 1. This file (00_load_order.zsh) - defines the load order
# 2. ohmyzsh.zsh - Oh My Zsh framework (must load first)
# 3. exports.zsh - General environment variables
# 4. Language configurations (alphabetically, but dependencies respected)
#    - java.zsh (includes SDKMAN, Maven, Gradle)
#    - python.zsh (includes pyenv, UV)
#    - ruby.zsh (includes rbenv, bundler)
#    - rust.zsh (includes cargo)
#    - go.zsh
#    - swift.zsh
#    - kotlin.zsh (depends on java)
#    - node.zsh (includes NVM)
#    - php.zsh (includes composer)
#    - cpp.zsh
# 5. Tool configurations
#    - homebrew.zsh
#    - xcode.zsh
#    - docker.zsh
#    - gpg.zsh
#    - anthropic.zsh
#    - ipfs.zsh
# 6. aliases.zsh - General aliases (loads after language configs)
# 7. Cloud/external services
#    - gcloud.zsh
#    - conda.zsh
# 8. misc.zsh - Final initializations (WezTerm, Jina, etc.)
#
# Files are automatically loaded by .zshrc but in a specific order
# to prevent conflicts and ensure optimal performance.
#==============================================================================

# Define the load order array
typeset -a ZSH_CONFIG_LOAD_ORDER
ZSH_CONFIG_LOAD_ORDER=(
    # Framework (must be first)
    "ohmyzsh.zsh"

    # General exports
    "exports.zsh"

    # Language configurations (in dependency order)
    "java.zsh"           # Loads first as Kotlin depends on it
    "python.zsh"         # Python with pyenv and UV
    "ruby.zsh"           # Ruby with rbenv
    "rust.zsh"           # Rust with cargo
    "go.zsh"             # Go
    "swift.zsh"          # Swift
    "kotlin.zsh"         # Kotlin (depends on Java)
    "node.zsh"           # Node.js with NVM
    "php.zsh"            # PHP with Composer
    "cpp.zsh"            # C/C++ with LLVM

    # Tool configurations
    "homebrew.zsh"       # Homebrew package manager
    "xcode.zsh"          # Xcode development tools
    "docker.zsh"         # Docker and Docker Compose
    "gpg.zsh"            # GPG encryption
    "anthropic.zsh"      # Anthropic MCP server
    "ipfs.zsh"           # IPFS

    # Aliases (after all tool configs to allow overrides)
    "aliases.zsh"

    # Cloud services and external tools
    "gcloud.zsh"         # Google Cloud SDK
    "conda.zsh"          # Conda package manager

    # Miscellaneous (last)
    "misc.zsh"           # WezTerm, Jina, Kiro, etc.
)

# Known alias conflicts (for documentation and validation)
typeset -A ZSH_CONFIG_ALIAS_CONFLICTS
ZSH_CONFIG_ALIAS_CONFLICTS=(
    # Format: "alias" "owner_file:conflicting_file:resolution"
    "j"   "java.zsh:aliases.zsh:aliases uses 'jbs' instead"
    "gb"  "go.zsh:aliases.zsh:aliases uses 'gbr' (git branch) instead"
    "py"  "python.zsh:aliases.zsh:defined only in python.zsh"
    "pip" "python.zsh:aliases.zsh:defined only in python.zsh"
    "dc"  "docker.zsh:aliases.zsh:defined only in docker.zsh"
    "dps" "docker.zsh:aliases.zsh:defined only in docker.zsh"
    "di"  "docker.zsh:aliases.zsh:defined only in docker.zsh"
)

# Function to check if a config file should be loaded
should_load_config() {
    local config_file="$1"
    local config_path="$HOME/dotfiles/macos/configs/shell/zsh_configs/$config_file"

    # Skip if file doesn't exist
    if [[ ! -f "$config_path" ]]; then
        return 1
    fi

    # Skip if file is disabled (renamed with .disabled extension)
    if [[ "$config_file" == *.disabled ]]; then
        return 1
    fi

    # Skip template files, scripts, and documentation
    if [[ "$config_file" == "template.zsh" ]] || \
       [[ "$config_file" == "validate_config.zsh" ]] || \
       [[ "$config_file" == *.md ]]; then
        return 1
    fi

    return 0
}

# Function to load configurations in order
load_configs_in_order() {
    local config_dir="$HOME/dotfiles/macos/configs/shell/zsh_configs"

    # Load files in the defined order
    for config_file in "${ZSH_CONFIG_LOAD_ORDER[@]}"; do
        if should_load_config "$config_file"; then
            local config_path="$config_dir/$config_file"
            # Uncomment the next line for debugging load order
            # echo "Loading: $config_file"
            source "$config_path"
        fi
    done

    # Load any remaining .zsh files not in the load order
    # (except this file, ohmyzsh.zsh, and template.zsh)
    for config_path in "$config_dir"/*.zsh; do
        local config_file="${config_path##*/}"

        # Skip if already loaded or special file
        if [[ "$config_file" == "00_load_order.zsh" ]] || \
           [[ "$config_file" == "template.zsh" ]] || \
           [[ "${ZSH_CONFIG_LOAD_ORDER[(I)$config_file]}" -gt 0 ]]; then
            continue
        fi

        if should_load_config "$config_file"; then
            # Uncomment the next line for debugging
            # echo "Loading (additional): $config_file"
            source "$config_path"
        fi
    done
}

# Export functions for use in .zshrc
# The actual loading is done in .zshrc

