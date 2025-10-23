#!/bin/zsh
#
# Azure AI Configuration
# This file contains all Azure AI-related configurations
#

# Environment Variables
export AZURE_OPENAI_API_KEY="${AZURE_OPENAI_API_KEY:-}"
export AZURE_OPENAI_ENDPOINT="${AZURE_OPENAI_ENDPOINT:-}"
export AZURE_OPENAI_API_VERSION="${AZURE_OPENAI_API_VERSION:-2024-02-15-preview}"
export AZURE_OPENAI_DEPLOYMENT_NAME="${AZURE_OPENAI_DEPLOYMENT_NAME:-gpt-4}"

# Azure AI Configuration Directory
export AZURE_AI_CONFIG_DIR="$HOME/.config/azure-ai"
export AZURE_AI_CONFIG_FILE="$AZURE_AI_CONFIG_DIR/config.json"

# Aliases
alias azure-ai="az ai"
alias azure-openai="az openai"

# Functions
azure_ai_setup() {
    if [[ -z "$AZURE_OPENAI_API_KEY" ]]; then
        echo "Warning: AZURE_OPENAI_API_KEY not set. Please set it in your environment."
        return 1
    fi
    if [[ -z "$AZURE_OPENAI_ENDPOINT" ]]; then
        echo "Warning: AZURE_OPENAI_ENDPOINT not set. Please set it in your environment."
        return 1
    fi
    echo "Azure AI configuration is complete."
}

# Tool-specific setup
if command -v az &> /dev/null; then
    # Initialize Azure CLI if available
    azure_ai_setup
fi
