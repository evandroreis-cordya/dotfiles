#!/bin/zsh
#
# Azure Configuration
# This file contains all Azure-related configurations
#

# Environment Variables
export AZURE_CLIENT_ID="${AZURE_CLIENT_ID:-}"
export AZURE_CLIENT_SECRET="${AZURE_CLIENT_SECRET:-}"
export AZURE_TENANT_ID="${AZURE_TENANT_ID:-}"
export AZURE_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID:-}"
export AZURE_RESOURCE_GROUP="${AZURE_RESOURCE_GROUP:-}"

# Azure Configuration Directory
export AZURE_CONFIG_DIR="$HOME/.azure"
export AZURE_CONFIG_FILE="$AZURE_CONFIG_DIR/config"

# Aliases
alias az-login="az login"
alias az-logout="az logout"
alias az-account="az account"
alias az-group="az group"
alias az-vm="az vm"

# Functions
azure_setup() {
    if [[ -z "$AZURE_CLIENT_ID" ]]; then
        echo "Warning: Azure credentials not configured. Run 'az login' to authenticate."
        return 1
    fi
    echo "Azure configuration is complete."
}

azure_subscription_switch() {
    local subscription="$1"
    if [[ -z "$subscription" ]]; then
        echo "Usage: azure_subscription_switch <subscription_id>"
        return 1
    fi
    az account set --subscription "$subscription"
    echo "Switched to Azure subscription: $subscription"
}

# Tool-specific setup
if command -v az &> /dev/null; then
    # Initialize Azure CLI if available
    azure_setup
fi
