#!/bin/zsh
#
# Vercel Configuration
# This file contains all Vercel-related configurations
#

# Environment Variables
export VERCEL_TOKEN="${VERCEL_TOKEN:-}"
export VERCEL_ORG_ID="${VERCEL_ORG_ID:-}"
export VERCEL_PROJECT_ID="${VERCEL_PROJECT_ID:-}"
export VERCEL_TEAM_ID="${VERCEL_TEAM_ID:-}"

# Vercel Configuration Directory
export VERCEL_CONFIG_DIR="$HOME/.vercel"
export VERCEL_CONFIG_FILE="$VERCEL_CONFIG_DIR/config.json"

# Aliases
alias vercel-deploy="vercel deploy"
alias vercel-dev="vercel dev"
alias vercel-ls="vercel ls"
alias vercel-logs="vercel logs"

# Functions
vercel_setup() {
    if [[ -z "$VERCEL_TOKEN" ]]; then
        echo "Warning: VERCEL_TOKEN not set. Please set it in your environment."
        return 1
    fi
    echo "Vercel configuration is complete."
}

vercel_project_switch() {
    local project="$1"
    if [[ -z "$project" ]]; then
        echo "Usage: vercel_project_switch <project_name>"
        return 1
    fi
    export VERCEL_PROJECT_ID="$project"
    echo "Switched to Vercel project: $project"
}

# Tool-specific setup
if command -v vercel &> /dev/null; then
    # Initialize Vercel CLI if available
    vercel_setup
fi
