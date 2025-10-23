#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

print_in_purple "
   Gemini CLI and Google AI Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Core Google Generative AI SDK
execute "pip3 install google-generativeai" \
    "Installing Google Generative AI SDK"

execute "pip3 install google-ai-generativelanguage" \
    "Installing Google AI Generative Language SDK"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Studio and Development Tools
execute "pip3 install google-ai-studio" \
    "Installing Google AI Studio"

execute "pip3 install google-ai-studio-client" \
    "Installing Google AI Studio Client"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google Cloud AI Platform
execute "pip3 install google-cloud-aiplatform" \
    "Installing Google Cloud AI Platform"

execute "pip3 install google-cloud-aiplatform[pipelines]" \
    "Installing Vertex AI Pipelines"

execute "pip3 install google-cloud-aiplatform[tensorboard]" \
    "Installing Vertex AI TensorBoard"

execute "pip3 install google-cloud-aiplatform[feature-store]" \
    "Installing Vertex AI Feature Store"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google Cloud AI Services
execute "pip3 install google-cloud-vision" \
    "Installing Google Cloud Vision API"

execute "pip3 install google-cloud-speech" \
    "Installing Google Cloud Speech API"

execute "pip3 install google-cloud-translate" \
    "Installing Google Cloud Translation API"

execute "pip3 install google-cloud-language" \
    "Installing Google Cloud Natural Language API"

execute "pip3 install google-cloud-videointelligence" \
    "Installing Google Cloud Video Intelligence API"

execute "pip3 install google-cloud-texttospeech" \
    "Installing Google Cloud Text-to-Speech API"

execute "pip3 install google-cloud-documentai" \
    "Installing Google Cloud Document AI API"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Research Tools
execute "pip3 install jax" \
    "Installing JAX for high-performance ML research"

execute "pip3 install jaxlib" \
    "Installing JAX library"

execute "pip3 install flax" \
    "Installing Flax neural network library"

execute "pip3 install trax" \
    "Installing Trax deep learning library"

execute "pip3 install tensorflow" \
    "Installing TensorFlow"

execute "pip3 install tensorflow-hub" \
    "Installing TensorFlow Hub"

execute "pip3 install tensorflow-text" \
    "Installing TensorFlow Text"

execute "pip3 install tensorflow-datasets" \
    "Installing TensorFlow Datasets"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google ML Tools
execute "pip3 install google-cloud-ml-engine" \
    "Installing Google ML Engine"

execute "pip3 install google-cloud-automl" \
    "Installing Google AutoML"

execute "pip3 install google-cloud-notebooks" \
    "Installing Google Cloud Notebooks"

execute "pip3 install google-cloud-aiplatform[notebooks]" \
    "Installing Vertex AI Workbench"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Ethics and Model Analysis
execute "pip3 install tensorflow-model-remediation" \
    "Installing TensorFlow Model Remediation"

execute "pip3 install tensorflow-privacy" \
    "Installing TensorFlow Privacy"

execute "pip3 install tensorflow-model-analysis" \
    "Installing TensorFlow Model Analysis"

execute "pip3 install tensorflow-fairness-indicators" \
    "Installing TensorFlow Fairness Indicators"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI CLI Tools
execute "pip3 install google-cloud-cli" \
    "Installing Google Cloud CLI"

execute "pip3 install gcloud" \
    "Installing gcloud CLI"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Gemini CLI Tools and Utilities
execute "pip3 install gemini-cli" \
    "Installing Gemini CLI tools"

execute "pip3 install google-generativeai[cli]" \
    "Installing Gemini CLI utilities"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Development Tools
execute "pip3 install google-cloud-build" \
    "Installing Google Cloud Build"

execute "pip3 install google-cloud-deploy" \
    "Installing Google Cloud Deploy"

execute "pip3 install google-cloud-run" \
    "Installing Google Cloud Run"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Monitoring and Logging
execute "pip3 install google-cloud-monitoring" \
    "Installing Google Cloud Monitoring"

execute "pip3 install google-cloud-logging" \
    "Installing Google Cloud Logging"

execute "pip3 install google-cloud-trace" \
    "Installing Google Cloud Trace"

execute "pip3 install google-cloud-profiler" \
    "Installing Google Cloud Profiler"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Storage and Data
execute "pip3 install google-cloud-storage" \
    "Installing Google Cloud Storage"

execute "pip3 install google-cloud-bigquery" \
    "Installing Google Cloud BigQuery"

execute "pip3 install google-cloud-bigquery-storage" \
    "Installing Google Cloud BigQuery Storage"

execute "pip3 install google-cloud-datastore" \
    "Installing Google Cloud Datastore"

execute "pip3 install google-cloud-firestore" \
    "Installing Google Cloud Firestore"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Security and Authentication
execute "pip3 install google-auth" \
    "Installing Google Auth library"

execute "pip3 install google-auth-oauthlib" \
    "Installing Google Auth OAuth library"

execute "pip3 install google-auth-httplib2" \
    "Installing Google Auth HTTP library"

execute "pip3 install google-cloud-iam" \
    "Installing Google Cloud IAM"

execute "pip3 install google-cloud-kms" \
    "Installing Google Cloud KMS"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Networking and API Management
execute "pip3 install google-cloud-endpoints" \
    "Installing Google Cloud Endpoints"

execute "pip3 install google-cloud-api-gateway" \
    "Installing Google Cloud API Gateway"

execute "pip3 install google-cloud-service-directory" \
    "Installing Google Cloud Service Directory"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Compute and Infrastructure
execute "pip3 install google-cloud-compute" \
    "Installing Google Cloud Compute"

execute "pip3 install google-cloud-container" \
    "Installing Google Cloud Container"

execute "pip3 install google-cloud-kubernetes" \
    "Installing Google Cloud Kubernetes"

execute "pip3 install google-cloud-functions" \
    "Installing Google Cloud Functions"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Data Processing
execute "pip3 install google-cloud-dataflow" \
    "Installing Google Cloud Dataflow"

execute "pip3 install google-cloud-dataproc" \
    "Installing Google Cloud Dataproc"

execute "pip3 install google-cloud-dataprep" \
    "Installing Google Cloud Dataprep"

execute "pip3 install google-cloud-datalab" \
    "Installing Google Cloud Datalab"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Workflow and Orchestration
execute "pip3 install google-cloud-workflows" \
    "Installing Google Cloud Workflows"

execute "pip3 install google-cloud-scheduler" \
    "Installing Google Cloud Scheduler"

execute "pip3 install google-cloud-tasks" \
    "Installing Google Cloud Tasks"

execute "pip3 install google-cloud-pubsub" \
    "Installing Google Cloud Pub/Sub"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Testing and Quality Assurance
execute "pip3 install google-cloud-testing" \
    "Installing Google Cloud Testing"

execute "pip3 install google-cloud-error-reporting" \
    "Installing Google Cloud Error Reporting"

execute "pip3 install google-cloud-debugger" \
    "Installing Google Cloud Debugger"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Additional Google AI Tools
execute "pip3 install google-cloud-asset" \
    "Installing Google Cloud Asset"

execute "pip3 install google-cloud-billing" \
    "Installing Google Cloud Billing"

execute "pip3 install google-cloud-resource-manager" \
    "Installing Google Cloud Resource Manager"

execute "pip3 install google-cloud-org-policy" \
    "Installing Google Cloud Org Policy"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Configuration Setup
GEMINI_CONFIG_DIR="$HOME/.config/gemini"
GEMINI_CONFIG_FILE="$GEMINI_CONFIG_DIR/config.json"

# Create Gemini config directory
if [[ ! -d "$GEMINI_CONFIG_DIR" ]]; then
    mkdir -p "$GEMINI_CONFIG_DIR"
    print_success "Created Gemini config directory: $GEMINI_CONFIG_DIR"
fi

# Create Gemini configuration file
if [[ ! -f "$GEMINI_CONFIG_FILE" ]]; then
    cat > "$GEMINI_CONFIG_FILE" << 'EOF'
{
    "api_key": "",
    "model": "gemini-pro",
    "temperature": 0.7,
    "max_tokens": 2048,
    "top_p": 0.9,
    "top_k": 40,
    "safety_settings": {
        "harassment": "BLOCK_MEDIUM_AND_ABOVE",
        "hate_speech": "BLOCK_MEDIUM_AND_ABOVE",
        "sexually_explicit": "BLOCK_MEDIUM_AND_ABOVE",
        "dangerous_content": "BLOCK_MEDIUM_AND_ABOVE"
    },
    "generation_config": {
        "temperature": 0.7,
        "top_p": 0.9,
        "top_k": 40,
        "max_output_tokens": 2048,
        "candidate_count": 1
    }
}
EOF

    print_success "Created Gemini configuration file: $GEMINI_CONFIG_FILE"
else
    print_success "Gemini configuration file already exists: $GEMINI_CONFIG_FILE"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI CLI Tools Setup
GOOGLE_AI_CLI_DIR="$HOME/.local/bin"

# Create local bin directory if it doesn't exist
if [[ ! -d "$GOOGLE_AI_CLI_DIR" ]]; then
    mkdir -p "$GOOGLE_AI_CLI_DIR"
    print_success "Created local bin directory: $GOOGLE_AI_CLI_DIR"
fi

# Note: PATH modifications are now handled by the gemini.zsh config file

# Note: Environment variables are now handled by the gemini.zsh config file

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI CLI Helper Scripts
GOOGLE_AI_SCRIPTS_DIR="$GEMINI_CONFIG_DIR/scripts"

if [[ ! -d "$GOOGLE_AI_SCRIPTS_DIR" ]]; then
    mkdir -p "$GOOGLE_AI_SCRIPTS_DIR"
    print_success "Created Google AI scripts directory: $GOOGLE_AI_SCRIPTS_DIR"
fi

# Create Gemini CLI helper script
cat > "$GOOGLE_AI_SCRIPTS_DIR/gemini-cli" << 'EOF'
#!/usr/bin/env python3
"""
Gemini CLI Helper Script
Provides command-line interface for Google Gemini AI
"""

import argparse
import json
import os
import sys
from pathlib import Path

try:
    import google.generativeai as genai
except ImportError:
    print("Error: google-generativeai not installed. Run: pip install google-generativeai")
    sys.exit(1)

def load_config():
    """Load Gemini configuration"""
    config_file = Path.home() / ".config" / "gemini" / "config.json"
    if config_file.exists():
        with open(config_file, 'r') as f:
            return json.load(f)
    return {}

def setup_gemini():
    """Setup Gemini with API key"""
    api_key = os.getenv('GEMINI_API_KEY') or os.getenv('GOOGLE_API_KEY')
    if not api_key:
        print("Error: GEMINI_API_KEY or GOOGLE_API_KEY not set")
        return False

    genai.configure(api_key=api_key)
    return True

def chat(prompt, model="gemini-pro", temperature=0.7):
    """Chat with Gemini"""
    if not setup_gemini():
        return

    model_instance = genai.GenerativeModel(model)
    response = model_instance.generate_content(
        prompt,
        generation_config=genai.types.GenerationConfig(
            temperature=temperature,
            max_output_tokens=2048,
        )
    )

    print(response.text)

def code(prompt, language="python", model="gemini-pro"):
    """Generate code with Gemini"""
    full_prompt = f"Generate {language} code for: {prompt}"
    chat(full_prompt, model)

def explain(prompt, model="gemini-pro"):
    """Explain code or concepts with Gemini"""
    full_prompt = f"Explain the following: {prompt}"
    chat(full_prompt, model)

def main():
    parser = argparse.ArgumentParser(description='Gemini CLI Helper')
    parser.add_argument('command', choices=['chat', 'code', 'explain'], help='Command to execute')
    parser.add_argument('prompt', help='Prompt or question')
    parser.add_argument('--model', default='gemini-pro', help='Model to use')
    parser.add_argument('--temperature', type=float, default=0.7, help='Temperature for generation')
    parser.add_argument('--language', default='python', help='Programming language for code generation')

    args = parser.parse_args()

    if args.command == 'chat':
        chat(args.prompt, args.model, args.temperature)
    elif args.command == 'code':
        code(args.prompt, args.language, args.model)
    elif args.command == 'explain':
        explain(args.prompt, args.model)

if __name__ == '__main__':
    main()
EOF

chmod +x "$GOOGLE_AI_SCRIPTS_DIR/gemini-cli"
print_success "Created Gemini CLI helper script"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Google AI Project Templates
GOOGLE_AI_TEMPLATES_DIR="$GEMINI_CONFIG_DIR/templates"

if [[ ! -d "$GOOGLE_AI_TEMPLATES_DIR" ]]; then
    mkdir -p "$GOOGLE_AI_TEMPLATES_DIR"
    print_success "Created Google AI templates directory: $GOOGLE_AI_TEMPLATES_DIR"
fi

# Create Gemini project template
cat > "$GOOGLE_AI_TEMPLATES_DIR/gemini_project.py" << 'EOF'
#!/usr/bin/env python3
"""
Gemini AI Project Template
A template for creating Gemini AI applications
"""

import os
import json
from pathlib import Path

try:
    import google.generativeai as genai
except ImportError:
    print("Error: google-generativeai not installed. Run: pip install google-generativeai")
    exit(1)

class GeminiProject:
    def __init__(self, config_file=None):
        """Initialize Gemini project"""
        self.config_file = config_file or Path.home() / ".config" / "gemini" / "config.json"
        self.config = self.load_config()
        self.setup_gemini()

    def load_config(self):
        """Load configuration from file"""
        if self.config_file.exists():
            with open(self.config_file, 'r') as f:
                return json.load(f)
        return {}

    def setup_gemini(self):
        """Setup Gemini with API key"""
        api_key = os.getenv('GEMINI_API_KEY') or os.getenv('GOOGLE_API_KEY')
        if not api_key:
            raise ValueError("GEMINI_API_KEY or GOOGLE_API_KEY not set")

        genai.configure(api_key=api_key)

    def chat(self, prompt, model=None, temperature=None):
        """Chat with Gemini"""
        model = model or self.config.get('model', 'gemini-pro')
        temperature = temperature or self.config.get('temperature', 0.7)

        model_instance = genai.GenerativeModel(model)
        response = model_instance.generate_content(
            prompt,
            generation_config=genai.types.GenerationConfig(
                temperature=temperature,
                max_output_tokens=self.config.get('max_tokens', 2048),
            )
        )

        return response.text

    def generate_code(self, prompt, language="python", model=None):
        """Generate code with Gemini"""
        full_prompt = f"Generate {language} code for: {prompt}"
        return self.chat(full_prompt, model)

    def explain_code(self, code, language="python", model=None):
        """Explain code with Gemini"""
        prompt = f"Explain this {language} code: {code}"
        return self.chat(prompt, model)

# Example usage
if __name__ == '__main__':
    try:
        gemini = GeminiProject()

        # Chat example
        response = gemini.chat("Hello, how can you help me?")
        print("Chat response:", response)

        # Code generation example
        code = gemini.generate_code("A function that calculates fibonacci numbers", "python")
        print("Generated code:", code)

    except Exception as e:
        print(f"Error: {e}")
EOF

print_success "Created Gemini project template"

# Note: Environment variables are now handled by the gemini.zsh config file

print_success "Gemini CLI and Google AI tools installation completed!"
print_in_green "
   Gemini CLI and Google AI tools are now installed with:
   - Google Generative AI SDK and CLI tools
   - Google AI Studio and development tools
   - Google Cloud AI Platform and services
   - Google AI research tools (JAX, Flax, Trax)
   - TensorFlow and TensorFlow Hub
   - Google AI ethics and model analysis tools
   - Comprehensive configuration setup
   - CLI helper scripts and project templates

   Configuration directory: $GEMINI_CONFIG_DIR
   CLI scripts directory: $GOOGLE_AI_SCRIPTS_DIR
   Project templates directory: $GOOGLE_AI_TEMPLATES_DIR

   To get started:
   1. Set your GEMINI_API_KEY environment variable
   2. Use the gemini-cli helper script for command-line access
   3. Import the project template for Python applications

"
