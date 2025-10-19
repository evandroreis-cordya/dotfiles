#!/bin/zsh
#==============================================================================
# AI CODE GENERATION TOOLS CONFIGURATION
#==============================================================================
# Configuration for AI-powered code generation tools and SDKs
# Provides environment setup for GitHub Copilot, Tabnine, CodeT5, and other code generators
#
# Dependencies: Various AI code generation tools and SDKs
#==============================================================================

# AI Code Generation configuration
export AI_CODEGEN_CONFIG_DIR="$HOME/.config/ai-codegen"
export AI_CODEGEN_CONFIG_FILE="$AI_CODEGEN_CONFIG_DIR/config.json"
export AI_CODEGEN_WORKSPACE_DIR="$HOME/.ai-codegen/workspace"
export AI_CODEGEN_MODELS_DIR="$HOME/.ai-codegen/models"

# Create AI CodeGen directories
mkdir -p "$AI_CODEGEN_CONFIG_DIR"
mkdir -p "$AI_CODEGEN_WORKSPACE_DIR"
mkdir -p "$AI_CODEGEN_MODELS_DIR"

# AI Code Generation environment variables
export AI_CODEGEN_DEFAULT_MODEL="gpt-4"
export AI_CODEGEN_DEFAULT_TEMPERATURE="0.1"
export AI_CODEGEN_DEFAULT_MAX_TOKENS="4096"
export AI_CODEGEN_DEFAULT_LANGUAGE="python"

# API Keys for various code generation services
export OPENAI_API_KEY="${OPENAI_API_KEY:-}"
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-}"
export GITHUB_TOKEN="${GITHUB_TOKEN:-}"
export TABNINE_API_KEY="${TABNINE_API_KEY:-}"

# GitHub Copilot configuration
export GITHUB_COPILOT_CONFIG_DIR="$HOME/.config/github-copilot"
export GITHUB_COPILOT_CONFIG_FILE="$GITHUB_COPILOT_CONFIG_DIR/config.json"

# Create GitHub Copilot config directory
mkdir -p "$GITHUB_COPILOT_CONFIG_DIR"

# Tabnine configuration
export TABNINE_CONFIG_DIR="$HOME/.config/tabnine"
export TABNINE_CONFIG_FILE="$TABNINE_CONFIG_DIR/config.json"

# Create Tabnine config directory
mkdir -p "$TABNINE_CONFIG_DIR"

# AI Code Generation functions
ai_codegen_init() {
    # Initialize AI code generation project
    local project_name="${1:-ai-codegen-project}"
    local project_dir="$AI_CODEGEN_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        # Create basic AI codegen structure
        cat > "codegen_config.json" << 'EOF'
{
    "models": {
        "primary": "gpt-4",
        "secondary": "claude-3",
        "code_specific": "codex"
    },
    "settings": {
        "temperature": 0.1,
        "max_tokens": 4096,
        "language": "python"
    },
    "tools": {
        "github_copilot": true,
        "tabnine": true,
        "codex": true
    }
}
EOF

        cat > "requirements.txt" << 'EOF'
openai
anthropic
github-copilot
tabnine
transformers
torch
tensorflow
EOF

        echo "AI CodeGen project '$project_name' initialized in $project_dir"
    else
        echo "Project '$project_name' already exists"
    fi
}

# GitHub Copilot functions
copilot_setup() {
    # Setup GitHub Copilot
    if [[ -n "$GITHUB_TOKEN" ]]; then
        # Configure GitHub Copilot
        cat > "$GITHUB_COPILOT_CONFIG_FILE" << EOF
{
    "github_token": "$GITHUB_TOKEN",
    "enabled": true,
    "model": "gpt-4",
    "temperature": 0.1
}
EOF
        echo "GitHub Copilot configured"
    else
        echo "GITHUB_TOKEN not set. Please set it first."
        return 1
    fi
}

copilot_status() {
    # Check GitHub Copilot status
    echo "GitHub Copilot Status:"
    echo "  Token: ${GITHUB_TOKEN:+***set***}"
    echo "  Config: $GITHUB_COPILOT_CONFIG_FILE"
    echo "  Enabled: $(jq -r '.enabled // false' "$GITHUB_COPILOT_CONFIG_FILE" 2>/dev/null || echo 'false')"
}

# Tabnine functions
tabnine_setup() {
    # Setup Tabnine
    if [[ -n "$TABNINE_API_KEY" ]]; then
        # Configure Tabnine
        cat > "$TABNINE_CONFIG_FILE" << EOF
{
    "api_key": "$TABNINE_API_KEY",
    "enabled": true,
    "model": "tabnine-pro",
    "temperature": 0.1
}
EOF
        echo "Tabnine configured"
    else
        echo "TABNINE_API_KEY not set. Please set it first."
        return 1
    fi
}

tabnine_status() {
    # Check Tabnine status
    echo "Tabnine Status:"
    echo "  API Key: ${TABNINE_API_KEY:+***set***}"
    echo "  Config: $TABNINE_CONFIG_FILE"
    echo "  Enabled: $(jq -r '.enabled // false' "$TABNINE_CONFIG_FILE" 2>/dev/null || echo 'false')"
}

# AI Code Generation utility functions
ai_generate_code() {
    # Generate code using AI
    local prompt="${1:-}"
    local language="${2:-$AI_CODEGEN_DEFAULT_LANGUAGE}"
    local model="${3:-$AI_CODEGEN_DEFAULT_MODEL}"
    
    if [[ -n "$prompt" ]]; then
        if command -v python3 &> /dev/null; then
            python3 -c "
import openai
import os
openai.api_key = os.getenv('OPENAI_API_KEY')
response = openai.ChatCompletion.create(
    model='$model',
    messages=[
        {'role': 'system', 'content': 'You are an expert $language programmer. Generate clean, efficient, and well-documented code.'},
        {'role': 'user', 'content': '$prompt'}
    ],
    temperature=$AI_CODEGEN_DEFAULT_TEMPERATURE,
    max_tokens=$AI_CODEGEN_DEFAULT_MAX_TOKENS
)
print(response.choices[0].message.content)
"
        else
            echo "Python3 not available"
            return 1
        fi
    else
        echo "Usage: ai_generate_code 'prompt' [language] [model]"
        return 1
    fi
}

ai_explain_code() {
    # Explain code using AI
    local code="${1:-}"
    local language="${2:-$AI_CODEGEN_DEFAULT_LANGUAGE}"
    
    if [[ -n "$code" ]]; then
        ai_generate_code "Explain this $language code: $code" "$language"
    else
        echo "Usage: ai_explain_code 'code' [language]"
        return 1
    fi
}

ai_refactor_code() {
    # Refactor code using AI
    local code="${1:-}"
    local language="${2:-$AI_CODEGEN_DEFAULT_LANGUAGE}"
    
    if [[ -n "$code" ]]; then
        ai_generate_code "Refactor and improve this $language code: $code" "$language"
    else
        echo "Usage: ai_refactor_code 'code' [language]"
        return 1
    fi
}

ai_generate_tests() {
    # Generate tests for code using AI
    local code="${1:-}"
    local language="${2:-$AI_CODEGEN_DEFAULT_LANGUAGE}"
    local test_framework="${3:-}"
    
    if [[ -n "$code" ]]; then
        local prompt="Generate comprehensive unit tests for this $language code: $code"
        if [[ -n "$test_framework" ]]; then
            prompt="Generate comprehensive unit tests using $test_framework for this $language code: $code"
        fi
        ai_generate_code "$prompt" "$language"
    else
        echo "Usage: ai_generate_tests 'code' [language] [test_framework]"
        return 1
    fi
}

# AI Code Generation aliases
alias aigen='ai_generate_code'
alias aiexp='ai_explain_code'
alias airef='ai_refactor_code'
alias aitest='ai_generate_tests'

# AI Code Generation project management
ai_codegen_list_projects() {
    # List AI codegen projects
    ls -la "$AI_CODEGEN_WORKSPACE_DIR" 2>/dev/null | grep -v "^total" | awk '{print $9}' | grep -v "^\.$\|^\.\.$"
}

ai_codegen_activate_project() {
    # Activate AI codegen project
    local project_name="${1:-}"
    
    if [[ -n "$project_name" ]]; then
        local project_dir="$AI_CODEGEN_WORKSPACE_DIR/$project_name"
        if [[ -d "$project_dir" ]]; then
            cd "$project_dir"
            echo "Activated AI CodeGen project: $project_name"
        else
            echo "Project '$project_name' not found"
            return 1
        fi
    else
        echo "Usage: ai_codegen_activate_project 'project_name'"
        return 1
    fi
}

# AI Code Generation templates
ai_codegen_template_python() {
    # Create Python AI codegen template
    ai_codegen_init "python-ai-project"
    cd "$AI_CODEGEN_WORKSPACE_DIR/python-ai-project"
    
    cat > "main.py" << 'EOF'
"""
AI Code Generation Template for Python
"""
import openai
import os

def generate_python_code(prompt: str, temperature: float = 0.1) -> str:
    """Generate Python code using OpenAI API"""
    openai.api_key = os.getenv('OPENAI_API_KEY')
    
    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are an expert Python programmer. Generate clean, efficient, and well-documented code."},
            {"role": "user", "content": prompt}
        ],
        temperature=temperature,
        max_tokens=4096
    )
    
    return response.choices[0].message.content

if __name__ == "__main__":
    prompt = input("Enter your coding prompt: ")
    code = generate_python_code(prompt)
    print("\nGenerated Code:")
    print(code)
EOF

    cat > "test_main.py" << 'EOF'
"""
Tests for AI Code Generation Template
"""
import unittest
from main import generate_python_code

class TestAICodeGeneration(unittest.TestCase):
    def test_generate_python_code(self):
        # Test basic code generation
        prompt = "Create a function that calculates fibonacci numbers"
        # Note: This would require API key in actual test
        # code = generate_python_code(prompt)
        # self.assertIsInstance(code, str)
        # self.assertIn("def fibonacci", code)
        pass

if __name__ == "__main__":
    unittest.main()
EOF
    
    echo "Python AI CodeGen template created"
}

ai_codegen_template_js() {
    # Create JavaScript AI codegen template
    ai_codegen_init "javascript-ai-project"
    cd "$AI_CODEGEN_WORKSPACE_DIR/javascript-ai-project"
    
    cat > "main.js" << 'EOF'
/**
 * AI Code Generation Template for JavaScript
 */
const OpenAI = require('openai');

const openai = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
});

async function generateJavaScriptCode(prompt, temperature = 0.1) {
    try {
        const response = await openai.chat.completions.create({
            model: "gpt-4",
            messages: [
                { role: "system", content: "You are an expert JavaScript programmer. Generate clean, efficient, and well-documented code." },
                { role: "user", content: prompt }
            ],
            temperature: temperature,
            max_tokens: 4096
        });
        
        return response.choices[0].message.content;
    } catch (error) {
        console.error('Error generating code:', error);
        throw error;
    }
}

// Example usage
if (require.main === module) {
    const prompt = process.argv[2] || "Create a function that calculates fibonacci numbers";
    generateJavaScriptCode(prompt)
        .then(code => {
            console.log("\nGenerated Code:");
            console.log(code);
        })
        .catch(error => {
            console.error("Error:", error.message);
        });
}

module.exports = { generateJavaScriptCode };
EOF

    cat > "package.json" << 'EOF'
{
    "name": "javascript-ai-codegen",
    "version": "1.0.0",
    "description": "AI Code Generation Template for JavaScript",
    "main": "main.js",
    "scripts": {
        "start": "node main.js",
        "test": "jest"
    },
    "dependencies": {
        "openai": "^4.0.0"
    },
    "devDependencies": {
        "jest": "^29.0.0"
    }
}
EOF
    
    echo "JavaScript AI CodeGen template created"
}

# AI Code Generation status and information
ai_codegen_status() {
    # Show AI CodeGen configuration status
    echo "AI Code Generation Configuration:"
    echo "  Config Dir: $AI_CODEGEN_CONFIG_DIR"
    echo "  Workspace Dir: $AI_CODEGEN_WORKSPACE_DIR"
    echo "  Models Dir: $AI_CODEGEN_MODELS_DIR"
    echo "  Default Model: $AI_CODEGEN_DEFAULT_MODEL"
    echo "  Default Temperature: $AI_CODEGEN_DEFAULT_TEMPERATURE"
    echo "  Default Language: $AI_CODEGEN_DEFAULT_LANGUAGE"
    echo "  OpenAI API Key: ${OPENAI_API_KEY:+***set***}"
    echo "  Anthropic API Key: ${ANTHROPIC_API_KEY:+***set***}"
    echo "  GitHub Token: ${GITHUB_TOKEN:+***set***}"
    echo "  Tabnine API Key: ${TABNINE_API_KEY:+***set***}"
}

# AI Code Generation installation check
ai_codegen_install_check() {
    # Check if AI codegen tools are properly installed
    local missing=()
    
    if ! command -v python3 &> /dev/null; then
        missing+=("python3")
    fi
    
    if ! python3 -c "import openai" 2>/dev/null; then
        missing+=("openai")
    fi
    
    if ! python3 -c "import anthropic" 2>/dev/null; then
        missing+=("anthropic")
    fi
    
    if [[ ${#missing[@]} -eq 0 ]]; then
        echo "All AI CodeGen dependencies are installed"
        return 0
    else
        echo "Missing dependencies: ${missing[*]}"
        return 1
    fi
}

# AI Code Generation configuration validation
if [[ -n "$OPENAI_API_KEY" ]] || [[ -n "$ANTHROPIC_API_KEY" ]]; then
    export AI_CODEGEN_CONFIGURED=true
else
    export AI_CODEGEN_CONFIGURED=false
fi

# AI Code Generation integration complete
if [[ "$AI_CODEGEN_CONFIGURED" == "true" ]]; then
    export AI_CODEGEN_INTEGRATION="active"
else
    export AI_CODEGEN_INTEGRATION="limited"
fi
