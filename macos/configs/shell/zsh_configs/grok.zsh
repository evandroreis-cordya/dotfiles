#!/bin/zsh
#
# Grok Configuration
# This file contains all Grok-related configurations
#

# Environment Variables
export GROK_API_KEY="${GROK_API_KEY:-}"
export GROK_MODEL="${GROK_MODEL:-grok-beta}"
export GROK_TEMPERATURE="${GROK_TEMPERATURE:-0.7}"
export GROK_MAX_TOKENS="${GROK_MAX_TOKENS:-4096}"

# Grok Configuration Directory
export GROK_CONFIG_DIR="$HOME/.config/grok"
export GROK_CONFIG_FILE="$GROK_CONFIG_DIR/config.json"

# Aliases
alias grok-chat="grok chat"
alias grok-x="grok x"
alias grok-social="grok social"

# Functions
grok_setup() {
    if [[ -z "$GROK_API_KEY" ]]; then
        echo "Warning: GROK_API_KEY not set. Please set it in your environment."
        return 1
    fi
    echo "Grok API key is configured."
}

# Tool-specific setup
if command -v grok &> /dev/null; then
    # Initialize Grok CLI if available
    grok_setup
fi
