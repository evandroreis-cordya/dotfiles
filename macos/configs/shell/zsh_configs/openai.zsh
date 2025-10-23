#!/bin/zsh
#
# OpenAI Configuration
# This file contains all OpenAI-related configurations
#

# Environment Variables
export OPENAI_API_KEY="${OPENAI_API_KEY:-}"
export OPENAI_ORG_ID="${OPENAI_ORG_ID:-}"
export OPENAI_MODEL="${OPENAI_MODEL:-gpt-4}"
export OPENAI_TEMPERATURE="${OPENAI_TEMPERATURE:-0.7}"
export OPENAI_MAX_TOKENS="${OPENAI_MAX_TOKENS:-4096}"

# OpenAI Configuration Directory
export OPENAI_CONFIG_DIR="$HOME/.config/openai"
export OPENAI_CONFIG_FILE="$OPENAI_CONFIG_DIR/config.json"

# Aliases
alias openai-chat="openai chat"
alias openai-code="openai code"
alias openai-image="openai image"

# Functions
openai_setup() {
    if [[ -z "$OPENAI_API_KEY" ]]; then
        echo "Warning: OPENAI_API_KEY not set. Please set it in your environment."
        return 1
    fi
    echo "OpenAI API key is configured."
}

# Tool-specific setup
if command -v openai &> /dev/null; then
    # Initialize OpenAI CLI if available
    openai_setup
fi
