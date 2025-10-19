#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

print_in_purple "
   AI Code Generation Tools and SDKs

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# GitHub Copilot CLI Tools
execute "pip3 install github-copilot-cli" \
    "Installing GitHub Copilot CLI"

execute "npm install -g @githubnext/github-copilot-cli" \
    "Installing GitHub Copilot CLI via npm"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Tabnine CLI Tools
execute "pip3 install tabnine" \
    "Installing Tabnine CLI"

execute "npm install -g tabnine" \
    "Installing Tabnine CLI via npm"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# CodeT5 and CodeBERT Models
execute "pip3 install transformers" \
    "Installing Transformers library for CodeT5 and CodeBERT"

execute "pip3 install torch" \
    "Installing PyTorch for model inference"

execute "pip3 install sentencepiece" \
    "Installing SentencePiece for tokenization"

execute "pip3 install tokenizers" \
    "Installing Tokenizers library"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Generation Models and Libraries
execute "pip3 install codex" \
    "Installing Codex API client"

execute "pip3 install openai" \
    "Installing OpenAI API client"

execute "pip3 install anthropic" \
    "Installing Anthropic API client"

execute "pip3 install google-generativeai" \
    "Installing Google Generative AI for code generation"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Analysis and Understanding Tools
execute "pip3 install tree-sitter" \
    "Installing Tree-sitter for code parsing"

execute "pip3 install tree-sitter-python" \
    "Installing Tree-sitter Python parser"

execute "pip3 install tree-sitter-javascript" \
    "Installing Tree-sitter JavaScript parser"

execute "pip3 install tree-sitter-java" \
    "Installing Tree-sitter Java parser"

execute "pip3 install tree-sitter-cpp" \
    "Installing Tree-sitter C++ parser"

execute "pip3 install tree-sitter-go" \
    "Installing Tree-sitter Go parser"

execute "pip3 install tree-sitter-rust" \
    "Installing Tree-sitter Rust parser"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Quality and Analysis Tools
execute "pip3 install ast-grep" \
    "Installing AST-grep for code analysis"

execute "pip3 install semgrep" \
    "Installing Semgrep for static analysis"

execute "pip3 install bandit" \
    "Installing Bandit for Python security analysis"

execute "pip3 install pylint" \
    "Installing Pylint for Python code analysis"

execute "pip3 install black" \
    "Installing Black for Python code formatting"

execute "pip3 install isort" \
    "Installing isort for Python import sorting"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Generation Frameworks
execute "pip3 install langchain" \
    "Installing LangChain for AI applications"

execute "pip3 install langchain-community" \
    "Installing LangChain Community tools"

execute "pip3 install langchain-openai" \
    "Installing LangChain OpenAI integration"

execute "pip3 install langchain-anthropic" \
    "Installing LangChain Anthropic integration"

execute "pip3 install langchain-google-genai" \
    "Installing LangChain Google Generative AI integration"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Generation Utilities
execute "pip3 install jinja2" \
    "Installing Jinja2 for template generation"

execute "pip3 install cookiecutter" \
    "Installing Cookiecutter for project templates"

execute "pip3 install copier" \
    "Installing Copier for project generation"

execute "pip3 install yeoman" \
    "Installing Yeoman for scaffolding"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Documentation Generation
execute "pip3 install sphinx" \
    "Installing Sphinx for documentation generation"

execute "pip3 install mkdocs" \
    "Installing MkDocs for documentation"

execute "pip3 install pydoc" \
    "Installing PyDoc for Python documentation"

execute "pip3 install docstring-generator" \
    "Installing Docstring Generator"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Testing Generation
execute "pip3 install pytest" \
    "Installing Pytest for test generation"

execute "pip3 install hypothesis" \
    "Installing Hypothesis for property-based testing"

execute "pip3 install faker" \
    "Installing Faker for test data generation"

execute "pip3 install factory-boy" \
    "Installing Factory Boy for test fixtures"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Refactoring Tools
execute "pip3 install rope" \
    "Installing Rope for Python refactoring"

execute "pip3 install autoflake" \
    "Installing Autoflake for import cleanup"

execute "pip3 install autoimport" \
    "Installing Autoimport for import management"

execute "pip3 install pyupgrade" \
    "Installing PyUpgrade for Python syntax upgrades"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Search and Indexing
execute "pip3 install ripgrep" \
    "Installing Ripgrep for fast code search"

execute "pip3 install ag" \
    "Installing The Silver Searcher"

execute "pip3 install ctags" \
    "Installing Ctags for code indexing"

execute "pip3 install universal-ctags" \
    "Installing Universal Ctags"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Metrics and Analysis
execute "pip3 install radon" \
    "Installing Radon for code metrics"

execute "pip3 install xenon" \
    "Installing Xenon for code complexity"

execute "pip3 install vulture" \
    "Installing Vulture for dead code detection"

execute "pip3 install pyflakes" \
    "Installing Pyflakes for syntax checking"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Generation AI Models
execute "pip3 install huggingface-hub" \
    "Installing Hugging Face Hub for model access"

execute "pip3 install datasets" \
    "Installing Datasets library"

execute "pip3 install accelerate" \
    "Installing Accelerate for model optimization"

execute "pip3 install bitsandbytes" \
    "Installing BitsAndBytes for quantization"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Code Generation Configuration Setup
AI_CODEGEN_CONFIG_DIR="$HOME/.config/ai-codegen"
AI_CODEGEN_CONFIG_FILE="$AI_CODEGEN_CONFIG_DIR/config.json"

# Create AI CodeGen config directory
if [[ ! -d "$AI_CODEGEN_CONFIG_DIR" ]]; then
    mkdir -p "$AI_CODEGEN_CONFIG_DIR"
    print_success "Created AI CodeGen config directory: $AI_CODEGEN_CONFIG_DIR"
fi

# Create AI CodeGen configuration file
if [[ ! -f "$AI_CODEGEN_CONFIG_FILE" ]]; then
    cat > "$AI_CODEGEN_CONFIG_FILE" << 'EOF'
{
    "models": {
        "primary": "gpt-4",
        "secondary": "claude-3",
        "code_specific": "codex",
        "local": "codet5-base"
    },
    "settings": {
        "temperature": 0.1,
        "max_tokens": 4096,
        "language": "python",
        "framework": "pytest"
    },
    "tools": {
        "github_copilot": {
            "enabled": true,
            "model": "gpt-4",
            "temperature": 0.1
        },
        "tabnine": {
            "enabled": true,
            "model": "tabnine-pro",
            "temperature": 0.1
        },
        "codet5": {
            "enabled": true,
            "model": "Salesforce/codet5-base",
            "temperature": 0.1
        },
        "codebert": {
            "enabled": true,
            "model": "microsoft/codebert-base",
            "temperature": 0.1
        }
    },
    "code_analysis": {
        "enabled": true,
        "tools": ["pylint", "black", "isort", "bandit"],
        "auto_fix": true
    },
    "documentation": {
        "enabled": true,
        "format": "google",
        "auto_generate": true
    },
    "testing": {
        "enabled": true,
        "framework": "pytest",
        "auto_generate": true,
        "coverage": true
    }
}
EOF
    
    print_success "Created AI CodeGen configuration file: $AI_CODEGEN_CONFIG_FILE"
else
    print_success "AI CodeGen configuration file already exists: $AI_CODEGEN_CONFIG_FILE"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# AI Code Generation CLI Tools
AI_CODEGEN_CLI_DIR="$HOME/.local/bin"

# Create local bin directory if it doesn't exist
if [[ ! -d "$AI_CODEGEN_CLI_DIR" ]]; then
    mkdir -p "$AI_CODEGEN_CLI_DIR"
    print_success "Created local bin directory: $AI_CODEGEN_CLI_DIR"
fi

# Create AI CodeGen CLI helper script
cat > "$AI_CODEGEN_CLI_DIR/ai-codegen" << 'EOF'
#!/usr/bin/env python3
"""
AI Code Generation CLI Tool
Provides command-line interface for AI-powered code generation
"""

import argparse
import json
import os
import sys
from pathlib import Path

try:
    import openai
    import anthropic
    import google.generativeai as genai
    from transformers import AutoTokenizer, AutoModelForCausalLM
except ImportError as e:
    print(f"Error: Missing dependency - {e}")
    print("Run: pip install openai anthropic google-generativeai transformers")
    sys.exit(1)

def load_config():
    """Load AI CodeGen configuration"""
    config_file = Path.home() / ".config" / "ai-codegen" / "config.json"
    if config_file.exists():
        with open(config_file, 'r') as f:
            return json.load(f)
    return {}

def setup_openai():
    """Setup OpenAI client"""
    api_key = os.getenv('OPENAI_API_KEY')
    if not api_key:
        print("Error: OPENAI_API_KEY not set")
        return None
    
    openai.api_key = api_key
    return openai

def setup_anthropic():
    """Setup Anthropic client"""
    api_key = os.getenv('ANTHROPIC_API_KEY')
    if not api_key:
        print("Error: ANTHROPIC_API_KEY not set")
        return None
    
    return anthropic.Anthropic(api_key=api_key)

def setup_gemini():
    """Setup Gemini client"""
    api_key = os.getenv('GEMINI_API_KEY') or os.getenv('GOOGLE_API_KEY')
    if not api_key:
        print("Error: GEMINI_API_KEY or GOOGLE_API_KEY not set")
        return None
    
    genai.configure(api_key=api_key)
    return genai

def generate_code_openai(prompt, language="python", model="gpt-4", temperature=0.1):
    """Generate code using OpenAI"""
    client = setup_openai()
    if not client:
        return None
    
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": f"You are an expert {language} programmer. Generate clean, efficient, and well-documented code."},
            {"role": "user", "content": prompt}
        ],
        temperature=temperature,
        max_tokens=4096
    )
    
    return response.choices[0].message.content

def generate_code_anthropic(prompt, language="python", model="claude-3-sonnet-20240229", temperature=0.1):
    """Generate code using Anthropic"""
    client = setup_anthropic()
    if not client:
        return None
    
    response = client.messages.create(
        model=model,
        max_tokens=4096,
        temperature=temperature,
        messages=[
            {"role": "user", "content": f"Generate {language} code for: {prompt}"}
        ]
    )
    
    return response.content[0].text

def generate_code_gemini(prompt, language="python", model="gemini-pro", temperature=0.1):
    """Generate code using Gemini"""
    genai_client = setup_gemini()
    if not genai_client:
        return None
    
    model_instance = genai_client.GenerativeModel(model)
    response = model_instance.generate_content(
        f"Generate {language} code for: {prompt}",
        generation_config=genai_client.types.GenerationConfig(
            temperature=temperature,
            max_output_tokens=4096,
        )
    )
    
    return response.text

def generate_tests(code, language="python", framework="pytest"):
    """Generate tests for code"""
    prompt = f"Generate comprehensive {framework} tests for this {language} code:\n\n{code}"
    
    # Try different providers
    for provider, func in [
        ("OpenAI", lambda: generate_code_openai(prompt, language)),
        ("Anthropic", lambda: generate_code_anthropic(prompt, language)),
        ("Gemini", lambda: generate_code_gemini(prompt, language))
    ]:
        try:
            result = func()
            if result:
                return result
        except Exception as e:
            print(f"Error with {provider}: {e}")
            continue
    
    return "Error: Could not generate tests with any provider"

def explain_code(code, language="python"):
    """Explain code"""
    prompt = f"Explain this {language} code in detail:\n\n{code}"
    
    # Try different providers
    for provider, func in [
        ("OpenAI", lambda: generate_code_openai(prompt, language)),
        ("Anthropic", lambda: generate_code_anthropic(prompt, language)),
        ("Gemini", lambda: generate_code_gemini(prompt, language))
    ]:
        try:
            result = func()
            if result:
                return result
        except Exception as e:
            print(f"Error with {provider}: {e}")
            continue
    
    return "Error: Could not explain code with any provider"

def refactor_code(code, language="python", improvement="optimize performance"):
    """Refactor code"""
    prompt = f"Refactor this {language} code to {improvement}:\n\n{code}"
    
    # Try different providers
    for provider, func in [
        ("OpenAI", lambda: generate_code_openai(prompt, language)),
        ("Anthropic", lambda: generate_code_anthropic(prompt, language)),
        ("Gemini", lambda: generate_code_gemini(prompt, language))
    ]:
        try:
            result = func()
            if result:
                return result
        except Exception as e:
            print(f"Error with {provider}: {e}")
            continue
    
    return "Error: Could not refactor code with any provider"

def main():
    parser = argparse.ArgumentParser(description='AI Code Generation CLI')
    parser.add_argument('command', choices=['generate', 'test', 'explain', 'refactor'], help='Command to execute')
    parser.add_argument('input', help='Input prompt or code')
    parser.add_argument('--language', default='python', help='Programming language')
    parser.add_argument('--model', help='AI model to use')
    parser.add_argument('--temperature', type=float, default=0.1, help='Temperature for generation')
    parser.add_argument('--framework', default='pytest', help='Testing framework for test generation')
    parser.add_argument('--improvement', default='optimize performance', help='Improvement type for refactoring')
    parser.add_argument('--output', help='Output file path')
    
    args = parser.parse_args()
    
    config = load_config()
    
    if args.command == 'generate':
        result = generate_code_openai(args.input, args.language, args.model or config.get('models', {}).get('primary', 'gpt-4'), args.temperature)
    elif args.command == 'test':
        result = generate_tests(args.input, args.language, args.framework)
    elif args.command == 'explain':
        result = explain_code(args.input, args.language)
    elif args.command == 'refactor':
        result = refactor_code(args.input, args.language, args.improvement)
    
    if result:
        if args.output:
            with open(args.output, 'w') as f:
                f.write(result)
            print(f"Output written to {args.output}")
        else:
            print(result)
    else:
        print("Error: Could not generate output")
        sys.exit(1)

if __name__ == '__main__':
    main()
EOF

chmod +x "$AI_CODEGEN_CLI_DIR/ai-codegen"
print_success "Created AI CodeGen CLI helper script"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# AI Code Generation Project Templates
AI_CODEGEN_TEMPLATES_DIR="$AI_CODEGEN_CONFIG_DIR/templates"

if [[ ! -d "$AI_CODEGEN_TEMPLATES_DIR" ]]; then
    mkdir -p "$AI_CODEGEN_TEMPLATES_DIR"
    print_success "Created AI CodeGen templates directory: $AI_CODEGEN_TEMPLATES_DIR"
fi

# Create Python AI CodeGen template
cat > "$AI_CODEGEN_TEMPLATES_DIR/python_ai_project.py" << 'EOF'
#!/usr/bin/env python3
"""
Python AI Code Generation Project Template
A template for creating AI-powered Python applications
"""

import json
import os
from pathlib import Path

try:
    import openai
    import anthropic
    import google.generativeai as genai
except ImportError:
    print("Error: Missing AI dependencies. Run: pip install openai anthropic google-generativeai")
    exit(1)

class AICodeGenerator:
    def __init__(self, config_file=None):
        """Initialize AI Code Generator"""
        self.config_file = config_file or Path.home() / ".config" / "ai-codegen" / "config.json"
        self.config = self.load_config()
    
    def load_config(self):
        """Load configuration from file"""
        if self.config_file.exists():
            with open(self.config_file, 'r') as f:
                return json.load(f)
        return {}
    
    def generate_function(self, description, language="python"):
        """Generate a function from description"""
        prompt = f"Generate a {language} function for: {description}"
        return self._call_ai(prompt, language)
    
    def generate_class(self, description, language="python"):
        """Generate a class from description"""
        prompt = f"Generate a {language} class for: {description}"
        return self._call_ai(prompt, language)
    
    def generate_tests(self, code, framework="pytest"):
        """Generate tests for code"""
        prompt = f"Generate comprehensive {framework} tests for this code:\n\n{code}"
        return self._call_ai(prompt, "python")
    
    def explain_code(self, code):
        """Explain code"""
        prompt = f"Explain this code in detail:\n\n{code}"
        return self._call_ai(prompt, "markdown")
    
    def refactor_code(self, code, improvement="optimize performance"):
        """Refactor code"""
        prompt = f"Refactor this code to {improvement}:\n\n{code}"
        return self._call_ai(prompt, "python")
    
    def _call_ai(self, prompt, language="python"):
        """Call AI service to generate content"""
        # Try OpenAI first
        try:
            return self._call_openai(prompt, language)
        except Exception as e:
            print(f"OpenAI error: {e}")
        
        # Try Anthropic
        try:
            return self._call_anthropic(prompt, language)
        except Exception as e:
            print(f"Anthropic error: {e}")
        
        # Try Gemini
        try:
            return self._call_gemini(prompt, language)
        except Exception as e:
            print(f"Gemini error: {e}")
        
        return "Error: Could not generate content with any AI service"
    
    def _call_openai(self, prompt, language):
        """Call OpenAI API"""
        if not os.getenv('OPENAI_API_KEY'):
            raise Exception("OPENAI_API_KEY not set")
        
        openai.api_key = os.getenv('OPENAI_API_KEY')
        
        response = openai.chat.completions.create(
            model=self.config.get('models', {}).get('primary', 'gpt-4'),
            messages=[
                {"role": "system", "content": f"You are an expert {language} programmer."},
                {"role": "user", "content": prompt}
            ],
            temperature=self.config.get('settings', {}).get('temperature', 0.1),
            max_tokens=self.config.get('settings', {}).get('max_tokens', 4096)
        )
        
        return response.choices[0].message.content
    
    def _call_anthropic(self, prompt, language):
        """Call Anthropic API"""
        if not os.getenv('ANTHROPIC_API_KEY'):
            raise Exception("ANTHROPIC_API_KEY not set")
        
        client = anthropic.Anthropic(api_key=os.getenv('ANTHROPIC_API_KEY'))
        
        response = client.messages.create(
            model=self.config.get('models', {}).get('secondary', 'claude-3-sonnet-20240229'),
            max_tokens=self.config.get('settings', {}).get('max_tokens', 4096),
            temperature=self.config.get('settings', {}).get('temperature', 0.1),
            messages=[
                {"role": "user", "content": prompt}
            ]
        )
        
        return response.content[0].text
    
    def _call_gemini(self, prompt, language):
        """Call Gemini API"""
        api_key = os.getenv('GEMINI_API_KEY') or os.getenv('GOOGLE_API_KEY')
        if not api_key:
            raise Exception("GEMINI_API_KEY or GOOGLE_API_KEY not set")
        
        genai.configure(api_key=api_key)
        
        model = genai.GenerativeModel('gemini-pro')
        response = model.generate_content(
            prompt,
            generation_config=genai.types.GenerationConfig(
                temperature=self.config.get('settings', {}).get('temperature', 0.1),
                max_output_tokens=self.config.get('settings', {}).get('max_tokens', 4096),
            )
        )
        
        return response.text

# Example usage
if __name__ == '__main__':
    generator = AICodeGenerator()
    
    # Generate a function
    function_code = generator.generate_function("A function that calculates fibonacci numbers")
    print("Generated function:")
    print(function_code)
    
    # Generate tests
    test_code = generator.generate_tests(function_code)
    print("\nGenerated tests:")
    print(test_code)
    
    # Explain code
    explanation = generator.explain_code(function_code)
    print("\nCode explanation:")
    print(explanation)
EOF

print_success "Created Python AI CodeGen project template"

# Create JavaScript AI CodeGen template
cat > "$AI_CODEGEN_TEMPLATES_DIR/javascript_ai_project.js" << 'EOF'
#!/usr/bin/env node
/**
 * JavaScript AI Code Generation Project Template
 * A template for creating AI-powered JavaScript applications
 */

const fs = require('fs');
const path = require('path');

class AICodeGenerator {
    constructor(configFile = null) {
        this.configFile = configFile || path.join(require('os').homedir(), '.config', 'ai-codegen', 'config.json');
        this.config = this.loadConfig();
    }
    
    loadConfig() {
        try {
            if (fs.existsSync(this.configFile)) {
                return JSON.parse(fs.readFileSync(this.configFile, 'utf8'));
            }
        } catch (error) {
            console.error('Error loading config:', error);
        }
        return {};
    }
    
    async generateFunction(description, language = 'javascript') {
        const prompt = `Generate a ${language} function for: ${description}`;
        return await this.callAI(prompt, language);
    }
    
    async generateClass(description, language = 'javascript') {
        const prompt = `Generate a ${language} class for: ${description}`;
        return await this.callAI(prompt, language);
    }
    
    async generateTests(code, framework = 'jest') {
        const prompt = `Generate comprehensive ${framework} tests for this code:\n\n${code}`;
        return await this.callAI(prompt, 'javascript');
    }
    
    async explainCode(code) {
        const prompt = `Explain this code in detail:\n\n${code}`;
        return await this.callAI(prompt, 'markdown');
    }
    
    async refactorCode(code, improvement = 'optimize performance') {
        const prompt = `Refactor this code to ${improvement}:\n\n${code}`;
        return await this.callAI(prompt, 'javascript');
    }
    
    async callAI(prompt, language = 'javascript') {
        // Try OpenAI first
        try {
            return await this.callOpenAI(prompt, language);
        } catch (error) {
            console.error('OpenAI error:', error.message);
        }
        
        // Try Anthropic
        try {
            return await this.callAnthropic(prompt, language);
        } catch (error) {
            console.error('Anthropic error:', error.message);
        }
        
        return 'Error: Could not generate content with any AI service';
    }
    
    async callOpenAI(prompt, language) {
        const { Configuration, OpenAIApi } = require('openai');
        
        if (!process.env.OPENAI_API_KEY) {
            throw new Error('OPENAI_API_KEY not set');
        }
        
        const configuration = new Configuration({
            apiKey: process.env.OPENAI_API_KEY,
        });
        
        const openai = new OpenAIApi(configuration);
        
        const response = await openai.createChatCompletion({
            model: this.config.models?.primary || 'gpt-4',
            messages: [
                { role: 'system', content: `You are an expert ${language} programmer.` },
                { role: 'user', content: prompt }
            ],
            temperature: this.config.settings?.temperature || 0.1,
            max_tokens: this.config.settings?.max_tokens || 4096,
        });
        
        return response.data.choices[0].message.content;
    }
    
    async callAnthropic(prompt, language) {
        const { Anthropic } = require('@anthropic-ai/sdk');
        
        if (!process.env.ANTHROPIC_API_KEY) {
            throw new Error('ANTHROPIC_API_KEY not set');
        }
        
        const anthropic = new Anthropic({
            apiKey: process.env.ANTHROPIC_API_KEY,
        });
        
        const response = await anthropic.messages.create({
            model: this.config.models?.secondary || 'claude-3-sonnet-20240229',
            max_tokens: this.config.settings?.max_tokens || 4096,
            temperature: this.config.settings?.temperature || 0.1,
            messages: [
                { role: 'user', content: prompt }
            ],
        });
        
        return response.content[0].text;
    }
}

// Example usage
async function main() {
    const generator = new AICodeGenerator();
    
    try {
        // Generate a function
        const functionCode = await generator.generateFunction('A function that calculates fibonacci numbers');
        console.log('Generated function:');
        console.log(functionCode);
        
        // Generate tests
        const testCode = await generator.generateTests(functionCode);
        console.log('\nGenerated tests:');
        console.log(testCode);
        
        // Explain code
        const explanation = await generator.explainCode(functionCode);
        console.log('\nCode explanation:');
        console.log(explanation);
    } catch (error) {
        console.error('Error:', error.message);
    }
}

if (require.main === module) {
    main();
}

module.exports = AICodeGenerator;
EOF

print_success "Created JavaScript AI CodeGen project template"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set environment variables
export AI_CODEGEN_CONFIG_DIR="$AI_CODEGEN_CONFIG_DIR"
export AI_CODEGEN_CONFIG_FILE="$AI_CODEGEN_CONFIG_FILE"
export AI_CODEGEN_CLI_DIR="$AI_CODEGEN_CLI_DIR"
export AI_CODEGEN_TEMPLATES_DIR="$AI_CODEGEN_TEMPLATES_DIR"

# Add environment variables to shell profile
SHELL_PROFILE="$HOME/.zshrc"
if [[ -f "$SHELL_PROFILE" ]]; then
    if ! grep -q "AI_CODEGEN_CONFIG_DIR" "$SHELL_PROFILE"; then
        echo "" >> "$SHELL_PROFILE"
        echo "# AI Code Generation configuration" >> "$SHELL_PROFILE"
        echo "export AI_CODEGEN_CONFIG_DIR=\"$AI_CODEGEN_CONFIG_DIR\"" >> "$SHELL_PROFILE"
        echo "export AI_CODEGEN_CONFIG_FILE=\"$AI_CODEGEN_CONFIG_FILE\"" >> "$SHELL_PROFILE"
        echo "export AI_CODEGEN_CLI_DIR=\"$AI_CODEGEN_CLI_DIR\"" >> "$SHELL_PROFILE"
        echo "export AI_CODEGEN_TEMPLATES_DIR=\"$AI_CODEGEN_TEMPLATES_DIR\"" >> "$SHELL_PROFILE"
        print_success "Added AI CodeGen environment variables to $SHELL_PROFILE"
    else
        print_success "AI CodeGen environment variables already present in $SHELL_PROFILE"
    fi
fi

print_success "AI Code Generation tools and SDKs installation completed!"
print_in_green "
   AI Code Generation tools and SDKs are now installed with:
   - GitHub Copilot CLI and integration tools
   - Tabnine CLI and code completion
   - CodeT5 and CodeBERT models for code understanding
   - OpenAI, Anthropic, and Gemini API clients
   - Code analysis and quality tools (Tree-sitter, Semgrep, Bandit)
   - Code generation frameworks (LangChain, Jinja2, Cookiecutter)
   - Documentation generation tools (Sphinx, MkDocs)
   - Testing generation tools (Pytest, Hypothesis, Faker)
   - Code refactoring tools (Rope, Autoflake, PyUpgrade)
   - Code search and indexing tools (Ripgrep, Ctags)
   - Code metrics and analysis tools (Radon, Xenon, Vulture)
   - Hugging Face models and datasets
   - Comprehensive CLI tools and project templates

   Configuration directory: $AI_CODEGEN_CONFIG_DIR
   CLI tools directory: $AI_CODEGEN_CLI_DIR
   Project templates directory: $AI_CODEGEN_TEMPLATES_DIR

   To get started:
   1. Set your API keys (OPENAI_API_KEY, ANTHROPIC_API_KEY, GEMINI_API_KEY)
   2. Use the ai-codegen CLI tool for command-line code generation
   3. Import the project templates for Python/JavaScript applications

"
