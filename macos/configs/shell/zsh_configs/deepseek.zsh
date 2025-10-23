#!/bin/zsh
#
# DeepSeek Configuration
# This file contains all DeepSeek-related configurations
#

# Environment Variables
export DEEPSEEK_API_KEY="${DEEPSEEK_API_KEY:-}"
export DEEPSEEK_MODEL="${DEEPSEEK_MODEL:-deepseek-coder}"
export DEEPSEEK_TEMPERATURE="${DEEPSEEK_TEMPERATURE:-0.7}"
export DEEPSEEK_MAX_TOKENS="${DEEPSEEK_MAX_TOKENS:-4096}"

# DeepSeek Configuration Directory
export DEEPSEEK_CONFIG_DIR="$HOME/.config/deepseek"
export DEEPSEEK_CONFIG_FILE="$DEEPSEEK_CONFIG_DIR/config.json"

# Aliases
alias deepseek-chat="deepseek chat"
alias deepseek-code="deepseek code"
alias deepseek-math="deepseek math"

# Functions
deepseek_setup() {
    if [[ -z "$DEEPSEEK_API_KEY" ]]; then
        echo "Warning: DEEPSEEK_API_KEY not set. Please set it in your environment."
        return 1
    fi
    echo "DeepSeek API key is configured."
}

# Tool-specific setup
if command -v deepseek &> /dev/null; then
    # Initialize DeepSeek CLI if available
    deepseek_setup
fi
