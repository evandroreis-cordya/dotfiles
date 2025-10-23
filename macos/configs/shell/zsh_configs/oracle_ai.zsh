#!/bin/zsh
#
# Oracle AI Configuration
# This file contains all Oracle AI-related configurations
#

# Environment Variables
export OCI_API_KEY="${OCI_API_KEY:-}"
export OCI_USER_ID="${OCI_USER_ID:-}"
export OCI_TENANCY="${OCI_TENANCY:-}"
export OCI_REGION="${OCI_REGION:-us-ashburn-1}"
export OCI_FINGERPRINT="${OCI_FINGERPRINT:-}"

# Oracle AI Configuration Directory
export ORACLE_AI_CONFIG_DIR="$HOME/.config/oracle-ai"
export ORACLE_AI_CONFIG_FILE="$ORACLE_AI_CONFIG_DIR/config.json"

# Aliases
alias oci-ai="oci ai"
alias oracle-ai="oci ai"

# Functions
oracle_ai_setup() {
    if [[ -z "$OCI_API_KEY" ]]; then
        echo "Warning: OCI_API_KEY not set. Please set it in your environment."
        return 1
    fi
    echo "Oracle AI configuration is complete."
}

# Tool-specific setup
if command -v oci &> /dev/null; then
    # Initialize Oracle CLI if available
    oracle_ai_setup
fi
