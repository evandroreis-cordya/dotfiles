#!/bin/zsh
#==============================================================================
# GOOGLE GEMINI AI CONFIGURATION
#==============================================================================
# Configuration for Google Gemini AI tools and services
# Provides environment setup for Gemini CLI, API access, and development tools
#
# Dependencies: google-generativeai, google-ai-generativelanguage
#==============================================================================

# Google Gemini API configuration
export GEMINI_API_KEY="${GEMINI_API_KEY:-}"
export GOOGLE_API_KEY="${GOOGLE_API_KEY:-$GEMINI_API_KEY}"
export GEMINI_PROJECT_ID="${GEMINI_PROJECT_ID:-}"
export GEMINI_MODEL="${GEMINI_MODEL:-gemini-pro}"

# Gemini CLI configuration
export GEMINI_CLI_CONFIG_DIR="$HOME/.config/gemini"
export GEMINI_CLI_CONFIG_FILE="$GEMINI_CLI_CONFIG_DIR/config.json"

# Create Gemini config directory if it doesn't exist
if [[ ! -d "$GEMINI_CLI_CONFIG_DIR" ]]; then
    mkdir -p "$GEMINI_CLI_CONFIG_DIR"
fi

# Gemini environment variables
export GEMINI_DEFAULT_MODEL="gemini-pro"
export GEMINI_DEFAULT_TEMPERATURE="0.7"
export GEMINI_DEFAULT_MAX_TOKENS="2048"
export GEMINI_DEFAULT_TOP_P="0.9"
export GEMINI_DEFAULT_TOP_K="40"

# Gemini CLI functions
gemini_chat() {
    # Interactive chat with Gemini
    local prompt="${1:-}"
    if [[ -n "$prompt" ]]; then
        if command -v gemini-cli &> /dev/null; then
            gemini-cli chat "$prompt"
        elif command -v python3 &> /dev/null; then
            python3 -c "
import google.generativeai as genai
import os
genai.configure(api_key=os.getenv('GEMINI_API_KEY'))
model = genai.GenerativeModel('$GEMINI_DEFAULT_MODEL')
response = model.generate_content('$prompt')
print(response.text)
"
        else
            echo "Gemini CLI or Python3 not available"
            return 1
        fi
    else
        echo "Usage: gemini_chat 'your prompt here'"
        return 1
    fi
}

gemini_code() {
    # Generate code with Gemini
    local prompt="${1:-}"
    local language="${2:-python}"
    if [[ -n "$prompt" ]]; then
        local full_prompt="Generate $language code for: $prompt"
        gemini_chat "$full_prompt"
    else
        echo "Usage: gemini_code 'description' [language]"
        return 1
    fi
}

gemini_explain() {
    # Explain code or concepts with Gemini
    local input="${1:-}"
    if [[ -n "$input" ]]; then
        local prompt="Explain the following: $input"
        gemini_chat "$prompt"
    else
        echo "Usage: gemini_explain 'code or concept'"
        return 1
    fi
}

gemini_refactor() {
    # Refactor code with Gemini
    local code="${1:-}"
    if [[ -n "$code" ]]; then
        local prompt="Refactor and improve this code: $code"
        gemini_chat "$prompt"
    else
        echo "Usage: gemini_refactor 'code'"
        return 1
    fi
}

# Gemini aliases
alias gai='gemini_chat'
alias gcode='gemini_code'
alias gexp='gemini_explain'
alias gref='gemini_refactor'

# Gemini configuration functions
gemini_set_api_key() {
    # Set Gemini API key
    local api_key="${1:-}"
    if [[ -n "$api_key" ]]; then
        export GEMINI_API_KEY="$api_key"
        export GOOGLE_API_KEY="$api_key"
        echo "Gemini API key set"
        
        # Save to config file
        if [[ -f "$GEMINI_CLI_CONFIG_FILE" ]]; then
            # Update existing config
            jq --arg key "$api_key" '.api_key = $key' "$GEMINI_CLI_CONFIG_FILE" > "$GEMINI_CLI_CONFIG_FILE.tmp" && mv "$GEMINI_CLI_CONFIG_FILE.tmp" "$GEMINI_CLI_CONFIG_FILE"
        else
            # Create new config
            echo "{\"api_key\": \"$api_key\", \"model\": \"$GEMINI_DEFAULT_MODEL\", \"temperature\": $GEMINI_DEFAULT_TEMPERATURE}" > "$GEMINI_CLI_CONFIG_FILE"
        fi
    else
        echo "Usage: gemini_set_api_key 'your-api-key'"
        return 1
    fi
}

gemini_set_model() {
    # Set default Gemini model
    local model="${1:-gemini-pro}"
    export GEMINI_DEFAULT_MODEL="$model"
    export GEMINI_MODEL="$model"
    echo "Default Gemini model set to: $model"
    
    # Update config file
    if [[ -f "$GEMINI_CLI_CONFIG_FILE" ]]; then
        jq --arg model "$model" '.model = $model' "$GEMINI_CLI_CONFIG_FILE" > "$GEMINI_CLI_CONFIG_FILE.tmp" && mv "$GEMINI_CLI_CONFIG_FILE.tmp" "$GEMINI_CLI_CONFIG_FILE"
    fi
}

gemini_set_temperature() {
    # Set default temperature
    local temp="${1:-0.7}"
    export GEMINI_DEFAULT_TEMPERATURE="$temp"
    echo "Default temperature set to: $temp"
    
    # Update config file
    if [[ -f "$GEMINI_CLI_CONFIG_FILE" ]]; then
        jq --argjson temp "$temp" '.temperature = $temp' "$GEMINI_CLI_CONFIG_FILE" > "$GEMINI_CLI_CONFIG_FILE.tmp" && mv "$GEMINI_CLI_CONFIG_FILE.tmp" "$GEMINI_CLI_CONFIG_FILE"
    fi
}

# Gemini status and information
gemini_status() {
    # Show Gemini configuration status
    echo "Gemini Configuration:"
    echo "  API Key: ${GEMINI_API_KEY:+***set***}"
    echo "  Model: $GEMINI_DEFAULT_MODEL"
    echo "  Temperature: $GEMINI_DEFAULT_TEMPERATURE"
    echo "  Max Tokens: $GEMINI_DEFAULT_MAX_TOKENS"
    echo "  Config File: $GEMINI_CLI_CONFIG_FILE"
    echo "  Project ID: ${GEMINI_PROJECT_ID:-not set}"
}

gemini_models() {
    # List available Gemini models
    if command -v python3 &> /dev/null && [[ -n "$GEMINI_API_KEY" ]]; then
        python3 -c "
import google.generativeai as genai
import os
genai.configure(api_key=os.getenv('GEMINI_API_KEY'))
for model in genai.list_models():
    if 'generateContent' in model.supported_generation_methods:
        print(f'{model.name}: {model.display_name}')
"
    else
        echo "Python3 or API key not available"
    fi
}

# Gemini development helpers
gemini_test() {
    # Test Gemini API connection
    if [[ -z "$GEMINI_API_KEY" ]]; then
        echo "Error: GEMINI_API_KEY not set"
        return 1
    fi
    
    echo "Testing Gemini API connection..."
    gemini_chat "Hello, this is a test message."
}

gemini_install_check() {
    # Check if Gemini tools are properly installed
    local missing=()
    
    if ! command -v python3 &> /dev/null; then
        missing+=("python3")
    fi
    
    if ! python3 -c "import google.generativeai" 2>/dev/null; then
        missing+=("google-generativeai")
    fi
    
    if [[ ${#missing[@]} -eq 0 ]]; then
        echo "All Gemini dependencies are installed"
        return 0
    else
        echo "Missing dependencies: ${missing[*]}"
        return 1
    fi
}

# Gemini file operations
gemini_from_file() {
    # Process file content with Gemini
    local file="${1:-}"
    local prompt="${2:-Explain this content:}"
    
    if [[ -f "$file" ]]; then
        local content=$(cat "$file")
        gemini_chat "$prompt $content"
    else
        echo "Usage: gemini_from_file 'filename' ['custom prompt']"
        return 1
    fi
}

gemini_to_file() {
    # Generate content and save to file
    local prompt="${1:-}"
    local filename="${2:-output.txt}"
    
    if [[ -n "$prompt" ]]; then
        gemini_chat "$prompt" > "$filename"
        echo "Output saved to: $filename"
    else
        echo "Usage: gemini_to_file 'prompt' 'filename'"
        return 1
    fi
}

# Gemini integration with development tools
gemini_git_commit() {
    # Generate git commit message with Gemini
    local changes="${1:-$(git diff --name-only)}"
    if [[ -n "$changes" ]]; then
        local prompt="Generate a concise git commit message for these changes: $changes"
        gemini_chat "$prompt"
    else
        echo "No changes detected"
        return 1
    fi
}

gemini_readme() {
    # Generate README with Gemini
    local project_name="${1:-$(basename $(pwd))}"
    local prompt="Generate a comprehensive README.md for a project called '$project_name'"
    gemini_to_file "$prompt" "README.md"
}

# Gemini configuration validation
if [[ -n "$GEMINI_API_KEY" ]]; then
    export GEMINI_CONFIGURED=true
else
    export GEMINI_CONFIGURED=false
fi

# Gemini integration complete
if [[ "$GEMINI_CONFIGURED" == "true" ]]; then
    export GEMINI_INTEGRATION="active"
else
    export GEMINI_INTEGRATION="limited"
fi
