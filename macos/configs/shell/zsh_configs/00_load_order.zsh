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
# 6. AI and Terminal configurations (in dependency order)
#    - wezterm.zsh (terminal setup)
#    - gemini.zsh (core AI foundation)
#    - ai_codegen.zsh (AI code generation)
#    - crewai.zsh (autonomous agents)
#    - agentic_ai.zsh (agentic AI frameworks)
#    - nvidia_ai.zsh (NVIDIA AI tools)
#    - nvidia_nemo.zsh (NVIDIA NeMO framework)
# 7. aliases.zsh - General aliases (loads after language configs)
# 8. Cloud/external services
#    - gcloud.zsh
#    - conda.zsh
# 9. misc.zsh - Final initializations (Jina, etc.)
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
    "cursor.zsh"         # Cursor IDE configuration
    "vscode.zsh"         # VS Code configuration
    "jetbrains.zsh"      # JetBrains IDEs configuration
    "neovim.zsh"         # Neovim configuration
    "gpg.zsh"            # GPG encryption
    "anthropic.zsh"      # Anthropic MCP server
    "ipfs.zsh"           # IPFS

    # AI and Terminal configurations (in dependency order)
    "wezterm.zsh"        # WezTerm terminal configuration (loads early for terminal setup)
    "gemini.zsh"         # Google Gemini AI tools (core AI foundation)
    "openai.zsh"         # OpenAI tools
    "azure_ai.zsh"       # Azure AI tools
    "deepseek.zsh"       # DeepSeek AI tools
    "cerebras.zsh"       # Cerebras AI tools
    "grok.zsh"           # Grok AI tools
    "oracle_ai.zsh"      # Oracle AI tools
    "meta_ai.zsh"        # Meta AI tools
    "aws.zsh"            # AWS cloud tools
    "azure.zsh"          # Azure cloud tools
    "vercel.zsh"         # Vercel tools
    "nvidia_cloud.zsh"   # NVIDIA cloud tools
    "ai_codegen.zsh"     # AI code generation tools (depends on core AI tools)
    "crewai.zsh"         # CrewAI autonomous agents (depends on AI code generation)
    "agentic_ai.zsh"     # Agentic AI frameworks (depends on autonomous agents)
    "nvidia_ai.zsh"      # NVIDIA AI development tools (depends on CUDA)
    "nvidia_nemo.zsh"    # NVIDIA NeMO framework (depends on NVIDIA AI tools)

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
    # AI tool aliases (defined only in respective AI config files)
    "gai" "gemini.zsh:defined only in gemini.zsh"
    "gcode" "gemini.zsh:defined only in gemini.zsh"
    "gexp" "gemini.zsh:defined only in gemini.zsh"
    "gref" "gemini.zsh:defined only in gemini.zsh"
    "aigen" "ai_codegen.zsh:defined only in ai_codegen.zsh"
    "aiexp" "ai_codegen.zsh:defined only in ai_codegen.zsh"
    "airef" "ai_codegen.zsh:defined only in ai_codegen.zsh"
    "aitest" "ai_codegen.zsh:defined only in ai_codegen.zsh"
    "cai" "crewai.zsh:defined only in crewai.zsh"
    "cagent" "crewai.zsh:defined only in crewai.zsh"
    "ctask" "crewai.zsh:defined only in crewai.zsh"
    "aai" "agentic_ai.zsh:defined only in agentic_ai.zsh"
    "aagent" "agentic_ai.zsh:defined only in agentic_ai.zsh"
    "aworkflow" "agentic_ai.zsh:defined only in agentic_ai.zsh"
    "nemo" "nvidia_nemo.zsh:defined only in nvidia_nemo.zsh"
    "nvai" "nvidia_ai.zsh:defined only in nvidia_ai.zsh"
    "wt" "wezterm.zsh:defined only in wezterm.zsh"
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

