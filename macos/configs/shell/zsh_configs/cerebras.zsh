#!/bin/zsh
#
# Cerebras Configuration
# This file contains all Cerebras-related configurations
#

# Environment Variables
export CEREBRAS_API_KEY="${CEREBRAS_API_KEY:-}"
export CEREBRAS_MODEL="${CEREBRAS_MODEL:-cerebras-gpt}"
export CEREBRAS_TEMPERATURE="${CEREBRAS_TEMPERATURE:-0.7}"
export CEREBRAS_MAX_TOKENS="${CEREBRAS_MAX_TOKENS:-4096}"

# Cerebras Configuration Directory
export CEREBRAS_CONFIG_DIR="$HOME/.config/cerebras"
export CEREBRAS_CONFIG_FILE="$CEREBRAS_CONFIG_DIR/config.json"

# Aliases
alias cerebras-chat="cerebras chat"
alias cerebras-code="cerebras code"
alias cerebras-train="cerebras train"

# Functions
cerebras_setup() {
    if [[ -z "$CEREBRAS_API_KEY" ]]; then
        echo "Warning: CEREBRAS_API_KEY not set. Please set it in your environment."
        return 1
    fi
    echo "Cerebras API key is configured."
}

# Tool-specific setup
if command -v cerebras &> /dev/null; then
    # Initialize Cerebras CLI if available
    cerebras_setup
fi
