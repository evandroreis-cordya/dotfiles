#!/bin/zsh
#
# Meta AI Configuration
# This file contains all Meta AI-related configurations
#

# Environment Variables
export META_API_KEY="${META_API_KEY:-}"
export META_MODEL="${META_MODEL:-llama-2}"
export META_TEMPERATURE="${META_TEMPERATURE:-0.7}"
export META_MAX_TOKENS="${META_MAX_TOKENS:-4096}"

# Meta AI Configuration Directory
export META_AI_CONFIG_DIR="$HOME/.config/meta-ai"
export META_AI_CONFIG_FILE="$META_AI_CONFIG_DIR/config.json"

# PyTorch Configuration
export PYTORCH_CUDA_ALLOC_CONF="${PYTORCH_CUDA_ALLOC_CONF:-max_split_size_mb:128}"

# Aliases
alias meta-ai="meta ai"
alias llama-chat="llama chat"
alias audiocraft="audiocraft"

# Functions
meta_ai_setup() {
    if [[ -z "$META_API_KEY" ]]; then
        echo "Warning: META_API_KEY not set. Please set it in your environment."
        return 1
    fi
    echo "Meta AI API key is configured."
}

# Tool-specific setup
if command -v meta &> /dev/null; then
    # Initialize Meta AI CLI if available
    meta_ai_setup
fi
