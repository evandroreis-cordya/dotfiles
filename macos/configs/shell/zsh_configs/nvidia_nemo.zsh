#!/bin/zsh
#==============================================================================
# NVIDIA NEMO FRAMEWORK CONFIGURATION
#==============================================================================
# Configuration for NVIDIA NeMO framework and toolkit
# Provides environment setup for NeMO model training, inference, and development
#
# Dependencies: nemo-toolkit, nemo-framework, nvidia-tensorrt, cuda
#==============================================================================

# NVIDIA NeMO configuration
export NEMO_CONFIG_DIR="$HOME/.config/nemo"
export NEMO_CONFIG_FILE="$NEMO_CONFIG_DIR/config.yaml"
export NEMO_WORKSPACE_DIR="$HOME/.nemo/workspace"
export NEMO_MODELS_DIR="$HOME/.nemo/models"
export NEMO_DATASETS_DIR="$HOME/.nemo/datasets"
export NEMO_LOGS_DIR="$HOME/.nemo/logs"

# Create NeMO directories
mkdir -p "$NEMO_CONFIG_DIR"
mkdir -p "$NEMO_WORKSPACE_DIR"
mkdir -p "$NEMO_MODELS_DIR"
mkdir -p "$NEMO_DATASETS_DIR"
mkdir -p "$NEMO_LOGS_DIR"

# NeMO environment variables
export NEMO_DEFAULT_MODEL="nemo-megatron-gpt-5b"
export NEMO_DEFAULT_FRAMEWORK="pytorch"
export NEMO_DEFAULT_PRECISION="fp16"
export NEMO_DEFAULT_GPUS="1"
export NEMO_DEFAULT_NODES="1"

# CUDA configuration for NeMO
export CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES:-0}"
export NEMO_CUDA_DEVICES="${NEMO_CUDA_DEVICES:-0}"
export NEMO_USE_CUDA="${NEMO_USE_CUDA:-true}"

# NeMO model configuration
export NEMO_MODEL_CACHE_DIR="$HOME/.cache/nemo/models"
export NEMO_DATASET_CACHE_DIR="$HOME/.cache/nemo/datasets"

# Create cache directories
mkdir -p "$NEMO_MODEL_CACHE_DIR"
mkdir -p "$NEMO_DATASET_CACHE_DIR"

# NeMO initialization functions
nemo_init() {
    # Initialize NeMO project
    local project_name="${1:-nemo-project}"
    local project_dir="$NEMO_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        # Create basic NeMO structure
        cat > "nemo_config.yaml" << 'EOF'
# NeMO Configuration
model:
  name: nemo-megatron-gpt-5b
  framework: pytorch
  precision: fp16
  gpus: 1
  nodes: 1

training:
  batch_size: 4
  learning_rate: 1e-4
  max_epochs: 10
  gradient_clip_val: 1.0

data:
  train_data_path: ./data/train
  validation_data_path: ./data/validation
  test_data_path: ./data/test

logging:
  log_dir: ./logs
  log_level: INFO
  tensorboard: true

checkpointing:
  save_top_k: 3
  monitor: val_loss
  mode: min
EOF

        cat > "requirements.txt" << 'EOF'
nemo-toolkit[asr]==1.22.0
nemo-toolkit[nlp]==1.22.0
nemo-toolkit[tts]==1.22.0
nemo-framework
torch
torchaudio
transformers
datasets
accelerate
deepspeed
EOF

        # Create data directories
        mkdir -p data/{train,validation,test}
        
        echo "NeMO project '$project_name' initialized in $project_dir"
    else
        echo "Project '$project_name' already exists"
    fi
}

# NeMO model functions
nemo_download_model() {
    # Download NeMO model
    local model_name="${1:-nemo-megatron-gpt-5b}"
    local model_dir="$NEMO_MODELS_DIR/$model_name"
    
    if [[ ! -d "$model_dir" ]]; then
        mkdir -p "$model_dir"
        cd "$model_dir"
        
        # Download model using NeMO
        if command -v python3 &> /dev/null; then
            python3 -c "
import nemo.collections.nlp as nemo_nlp
from nemo.collections.nlp.models import MegatronGPTPEFTModel

# Download the model
model = MegatronGPTPEFTModel.from_pretrained('$model_name')
model.save_to('$model_dir')
print('Model downloaded successfully')
"
        else
            echo "Python3 not available"
            return 1
        fi
    else
        echo "Model '$model_name' already exists"
    fi
}

nemo_list_models() {
    # List available NeMO models
    if command -v python3 &> /dev/null; then
        python3 -c "
import nemo.collections.nlp as nemo_nlp
import nemo.collections.asr as nemo_asr
import nemo.collections.tts as nemo_tts

print('Available NeMO Models:')
print('NLP Models:')
for model in nemo_nlp.models.__all__:
    print(f'  - {model}')

print('ASR Models:')
for model in nemo_asr.models.__all__:
    print(f'  - {model}')

print('TTS Models:')
for model in nemo_tts.models.__all__:
    print(f'  - {model}')
"
    else
        echo "Python3 not available"
    fi
}

nemo_load_model() {
    # Load NeMO model
    local model_name="${1:-nemo-megatron-gpt-5b}"
    local model_path="${2:-$NEMO_MODELS_DIR/$model_name}"
    
    if [[ -d "$model_path" ]]; then
        export NEMO_LOADED_MODEL="$model_name"
        export NEMO_MODEL_PATH="$model_path"
        echo "NeMO model '$model_name' loaded from $model_path"
    else
        echo "Model path '$model_path' not found"
        return 1
    fi
}

# NeMO training functions
nemo_train() {
    # Train NeMO model
    local config_file="${1:-nemo_config.yaml}"
    local model_name="${2:-$NEMO_DEFAULT_MODEL}"
    
    if [[ -f "$config_file" ]]; then
        echo "Starting NeMO training with config: $config_file"
        if command -v python3 &> /dev/null; then
            python3 -c "
import yaml
import nemo.collections.nlp as nemo_nlp
from nemo.collections.nlp.models import MegatronGPTPEFTModel

# Load config
with open('$config_file', 'r') as f:
    config = yaml.safe_load(f)

# Create model
model = MegatronGPTPEFTModel.from_pretrained('$model_name')

# Configure training
model.setup_training_data(
    train_data_config=config['data']['train_data_path'],
    validation_data_config=config['data']['validation_data_path']
)

# Start training
model.train()
"
        else
            echo "Python3 not available"
            return 1
        fi
    else
        echo "Config file '$config_file' not found"
        return 1
    fi
}

nemo_evaluate() {
    # Evaluate NeMO model
    local model_name="${1:-$NEMO_LOADED_MODEL}"
    local test_data_path="${2:-./data/test}"
    
    if [[ -n "$model_name" ]]; then
        echo "Evaluating NeMO model: $model_name"
        if command -v python3 &> /dev/null; then
            python3 -c "
import nemo.collections.nlp as nemo_nlp
from nemo.collections.nlp.models import MegatronGPTPEFTModel

# Load model
model = MegatronGPTPEFTModel.from_pretrained('$model_name')

# Evaluate
results = model.evaluate(test_data_config='$test_data_path')
print('Evaluation results:', results)
"
        else
            echo "Python3 not available"
            return 1
        fi
    else
        echo "No model loaded. Use 'nemo_load_model' first."
        return 1
    fi
}

# NeMO inference functions
nemo_inference() {
    # Run NeMO inference
    local model_name="${1:-$NEMO_LOADED_MODEL}"
    local input_text="${2:-Hello, world!}"
    local output_length="${3:-100}"
    
    if [[ -n "$model_name" ]]; then
        echo "Running NeMO inference with model: $model_name"
        if command -v python3 &> /dev/null; then
            python3 -c "
import nemo.collections.nlp as nemo_nlp
from nemo.collections.nlp.models import MegatronGPTPEFTModel

# Load model
model = MegatronGPTPEFTModel.from_pretrained('$model_name')

# Generate text
output = model.generate(
    input_text='$input_text',
    max_length=$output_length,
    temperature=0.7,
    do_sample=True
)

print('Generated text:', output)
"
        else
            echo "Python3 not available"
            return 1
        fi
    else
        echo "No model loaded. Use 'nemo_load_model' first."
        return 1
    fi
}

# NeMO utility functions
nemo_status() {
    # Show NeMO configuration status
    echo "NeMO Configuration:"
    echo "  Config Dir: $NEMO_CONFIG_DIR"
    echo "  Workspace Dir: $NEMO_WORKSPACE_DIR"
    echo "  Models Dir: $NEMO_MODELS_DIR"
    echo "  Datasets Dir: $NEMO_DATASETS_DIR"
    echo "  Logs Dir: $NEMO_LOGS_DIR"
    echo "  Default Model: $NEMO_DEFAULT_MODEL"
    echo "  Default Framework: $NEMO_DEFAULT_FRAMEWORK"
    echo "  Default Precision: $NEMO_DEFAULT_PRECISION"
    echo "  Default GPUs: $NEMO_DEFAULT_GPUS"
    echo "  CUDA Devices: $CUDA_VISIBLE_DEVICES"
    echo "  Use CUDA: $NEMO_USE_CUDA"
    echo "  Loaded Model: ${NEMO_LOADED_MODEL:-none}"
}

nemo_logs() {
    # Show NeMO logs
    local log_file="${1:-latest}"
    
    if [[ "$log_file" == "latest" ]]; then
        ls -t "$NEMO_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
    else
        cat "$NEMO_LOGS_DIR/$log_file"
    fi
}

nemo_clean() {
    # Clean NeMO logs and temporary files
    rm -f "$NEMO_LOGS_DIR"/*.log
    rm -rf "$NEMO_WORKSPACE_DIR"/*/__pycache__
    rm -rf "$NEMO_WORKSPACE_DIR"/*/checkpoints
    echo "NeMO logs and cache cleaned"
}

# NeMO aliases
alias nemo='nemo_init'
alias nemo-dl='nemo_download_model'
alias nemo-list='nemo_list_models'
alias nemo-load='nemo_load_model'
alias nemo-train='nemo_train'
alias nemo-eval='nemo_evaluate'
alias nemo-inf='nemo_inference'
alias nemo-status='nemo_status'
alias nemo-logs='nemo_logs'
alias nemo-clean='nemo_clean'

# NeMO project management
nemo_list_projects() {
    # List NeMO projects
    ls -la "$NEMO_WORKSPACE_DIR" 2>/dev/null | grep -v "^total" | awk '{print $9}' | grep -v "^\.$\|^\.\.$"
}

nemo_activate_project() {
    # Activate NeMO project
    local project_name="${1:-}"
    
    if [[ -n "$project_name" ]]; then
        local project_dir="$NEMO_WORKSPACE_DIR/$project_name"
        if [[ -d "$project_dir" ]]; then
            cd "$project_dir"
            echo "Activated NeMO project: $project_name"
        else
            echo "Project '$project_name' not found"
            return 1
        fi
    else
        echo "Usage: nemo_activate_project 'project_name'"
        return 1
    fi
}

# NeMO templates
nemo_template_nlp() {
    # Create NLP NeMO template
    nemo_init "nlp-project"
    cd "$NEMO_WORKSPACE_DIR/nlp-project"
    
    cat > "nlp_model.py" << 'EOF'
import nemo.collections.nlp as nemo_nlp
from nemo.collections.nlp.models import MegatronGPTPEFTModel
from nemo.collections.nlp.modules import MegatronGPTPEFTModel

class NLPModel:
    def __init__(self, model_name="nemo-megatron-gpt-5b"):
        self.model_name = model_name
        self.model = None
        
    def load_model(self):
        """Load the NeMO model"""
        self.model = MegatronGPTPEFTModel.from_pretrained(self.model_name)
        print(f"Model {self.model_name} loaded successfully")
        
    def train(self, config):
        """Train the model"""
        if self.model is None:
            self.load_model()
            
        # Configure training
        self.model.setup_training_data(
            train_data_config=config['train_data_path'],
            validation_data_config=config['validation_data_path']
        )
        
        # Start training
        self.model.train()
        
    def evaluate(self, test_data_path):
        """Evaluate the model"""
        if self.model is None:
            self.load_model()
            
        results = self.model.evaluate(test_data_config=test_data_path)
        return results
        
    def generate(self, input_text, max_length=100):
        """Generate text"""
        if self.model is None:
            self.load_model()
            
        output = self.model.generate(
            input_text=input_text,
            max_length=max_length,
            temperature=0.7,
            do_sample=True
        )
        return output

# Example usage
if __name__ == "__main__":
    model = NLPModel()
    model.load_model()
    
    # Generate text
    output = model.generate("Hello, world!")
    print("Generated text:", output)
EOF
    
    echo "NLP NeMO template created"
}

nemo_template_asr() {
    # Create ASR NeMO template
    nemo_init "asr-project"
    cd "$NEMO_WORKSPACE_DIR/asr-project"
    
    cat > "asr_model.py" << 'EOF'
import nemo.collections.asr as nemo_asr
from nemo.collections.asr.models import EncDecCTCModel

class ASRModel:
    def __init__(self, model_name="QuartzNet15x5Base-En"):
        self.model_name = model_name
        self.model = None
        
    def load_model(self):
        """Load the NeMO ASR model"""
        self.model = EncDecCTCModel.from_pretrained(self.model_name)
        print(f"ASR Model {self.model_name} loaded successfully")
        
    def transcribe(self, audio_file):
        """Transcribe audio file"""
        if self.model is None:
            self.load_model()
            
        transcription = self.model.transcribe([audio_file])
        return transcription[0]
        
    def transcribe_batch(self, audio_files):
        """Transcribe multiple audio files"""
        if self.model is None:
            self.load_model()
            
        transcriptions = self.model.transcribe(audio_files)
        return transcriptions

# Example usage
if __name__ == "__main__":
    model = ASRModel()
    model.load_model()
    
    # Transcribe audio
    transcription = model.transcribe("sample_audio.wav")
    print("Transcription:", transcription)
EOF
    
    echo "ASR NeMO template created"
}

# NeMO installation check
nemo_install_check() {
    # Check if NeMO tools are properly installed
    local missing=()
    
    if ! command -v python3 &> /dev/null; then
        missing+=("python3")
    fi
    
    if ! python3 -c "import nemo" 2>/dev/null; then
        missing+=("nemo-toolkit")
    fi
    
    if ! python3 -c "import torch" 2>/dev/null; then
        missing+=("torch")
    fi
    
    if ! command -v nvidia-smi &> /dev/null; then
        missing+=("nvidia-driver")
    fi
    
    if [[ ${#missing[@]} -eq 0 ]]; then
        echo "All NeMO dependencies are installed"
        return 0
    else
        echo "Missing dependencies: ${missing[*]}"
        return 1
    fi
}

# NeMO CUDA check
nemo_cuda_check() {
    # Check CUDA availability for NeMO
    if command -v python3 &> /dev/null; then
        python3 -c "
import torch
print('CUDA available:', torch.cuda.is_available())
if torch.cuda.is_available():
    print('CUDA device count:', torch.cuda.device_count())
    print('Current CUDA device:', torch.cuda.current_device())
    print('CUDA device name:', torch.cuda.get_device_name(0))
"
    else
        echo "Python3 not available"
    fi
}

# NeMO configuration validation
if command -v nvidia-smi &> /dev/null && python3 -c "import torch; torch.cuda.is_available()" 2>/dev/null; then
    export NEMO_CUDA_AVAILABLE=true
else
    export NEMO_CUDA_AVAILABLE=false
fi

if python3 -c "import nemo" 2>/dev/null; then
    export NEMO_CONFIGURED=true
else
    export NEMO_CONFIGURED=false
fi

# NeMO integration complete
if [[ "$NEMO_CONFIGURED" == "true" ]]; then
    export NEMO_INTEGRATION="active"
else
    export NEMO_INTEGRATION="limited"
fi
