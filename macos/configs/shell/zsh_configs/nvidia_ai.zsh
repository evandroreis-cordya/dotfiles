#!/bin/zsh
#==============================================================================
# NVIDIA AI DEVELOPMENT ENVIRONMENT CONFIGURATION
#==============================================================================
# Configuration for NVIDIA AI development tools and SDKs
# Provides environment setup for Riva, Jarvis, Merlin, Triton, DeepStream, and Omniverse
#
# Dependencies: nvidia-tensorrt, nvidia-triton, nvidia-deepstream, nvidia-omniverse
#==============================================================================

# NVIDIA AI configuration
export NVIDIA_AI_CONFIG_DIR="$HOME/.config/nvidia-ai"
export NVIDIA_AI_CONFIG_FILE="$NVIDIA_AI_CONFIG_DIR/config.json"
export NVIDIA_AI_WORKSPACE_DIR="$HOME/.nvidia-ai/workspace"
export NVIDIA_AI_MODELS_DIR="$HOME/.nvidia-ai/models"
export NVIDIA_AI_DATASETS_DIR="$HOME/.nvidia-ai/datasets"
export NVIDIA_AI_LOGS_DIR="$HOME/.nvidia-ai/logs"

# Create NVIDIA AI directories
mkdir -p "$NVIDIA_AI_CONFIG_DIR"
mkdir -p "$NVIDIA_AI_WORKSPACE_DIR"
mkdir -p "$NVIDIA_AI_MODELS_DIR"
mkdir -p "$NVIDIA_AI_DATASETS_DIR"
mkdir -p "$NVIDIA_AI_LOGS_DIR"

# NVIDIA AI environment variables
export NVIDIA_AI_DEFAULT_PRECISION="fp16"
export NVIDIA_AI_DEFAULT_BATCH_SIZE="1"
export NVIDIA_AI_DEFAULT_GPUS="1"
export NVIDIA_AI_DEFAULT_FRAMEWORK="tensorrt"

# CUDA configuration for NVIDIA AI
export CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES:-0}"
export NVIDIA_AI_CUDA_DEVICES="${NVIDIA_AI_CUDA_DEVICES:-0}"
export NVIDIA_AI_USE_CUDA="${NVIDIA_AI_USE_CUDA:-true}"

# NVIDIA Riva configuration
export RIVA_CONFIG_DIR="$HOME/.config/riva"
export RIVA_CONFIG_FILE="$RIVA_CONFIG_DIR/config.yaml"
export RIVA_MODELS_DIR="$HOME/.riva/models"
export RIVA_LOGS_DIR="$HOME/.riva/logs"

# NVIDIA Jarvis configuration
export JARVIS_CONFIG_DIR="$HOME/.config/jarvis"
export JARVIS_CONFIG_FILE="$JARVIS_CONFIG_DIR/config.yaml"
export JARVIS_MODELS_DIR="$HOME/.jarvis/models"
export JARVIS_LOGS_DIR="$HOME/.jarvis/logs"

# NVIDIA Merlin configuration
export MERLIN_CONFIG_DIR="$HOME/.config/merlin"
export MERLIN_CONFIG_FILE="$MERLIN_CONFIG_DIR/config.yaml"
export MERLIN_MODELS_DIR="$HOME/.merlin/models"
export MERLIN_DATASETS_DIR="$HOME/.merlin/datasets"

# NVIDIA Triton configuration
export TRITON_CONFIG_DIR="$HOME/.config/triton"
export TRITON_CONFIG_FILE="$TRITON_CONFIG_DIR/config.json"
export TRITON_MODELS_DIR="$HOME/.triton/models"
export TRITON_LOGS_DIR="$HOME/.triton/logs"

# NVIDIA DeepStream configuration
export DEEPSTREAM_CONFIG_DIR="$HOME/.config/deepstream"
export DEEPSTREAM_CONFIG_FILE="$DEEPSTREAM_CONFIG_DIR/config.txt"
export DEEPSTREAM_MODELS_DIR="$HOME/.deepstream/models"
export DEEPSTREAM_LOGS_DIR="$HOME/.deepstream/logs"

# NVIDIA Omniverse configuration
export OMNIVERSE_CONFIG_DIR="$HOME/.config/omniverse"
export OMNIVERSE_CONFIG_FILE="$OMNIVERSE_CONFIG_DIR/config.json"
export OMNIVERSE_WORKSPACE_DIR="$HOME/.omniverse/workspace"
export OMNIVERSE_LOGS_DIR="$HOME/.omniverse/logs"

# Create framework-specific directories
mkdir -p "$RIVA_CONFIG_DIR" "$RIVA_MODELS_DIR" "$RIVA_LOGS_DIR"
mkdir -p "$JARVIS_CONFIG_DIR" "$JARVIS_MODELS_DIR" "$JARVIS_LOGS_DIR"
mkdir -p "$MERLIN_CONFIG_DIR" "$MERLIN_MODELS_DIR" "$MERLIN_DATASETS_DIR"
mkdir -p "$TRITON_CONFIG_DIR" "$TRITON_MODELS_DIR" "$TRITON_LOGS_DIR"
mkdir -p "$DEEPSTREAM_CONFIG_DIR" "$DEEPSTREAM_MODELS_DIR" "$DEEPSTREAM_LOGS_DIR"
mkdir -p "$OMNIVERSE_CONFIG_DIR" "$OMNIVERSE_WORKSPACE_DIR" "$OMNIVERSE_LOGS_DIR"

# NVIDIA AI initialization functions
nvidia_ai_init() {
    # Initialize NVIDIA AI project
    local project_name="${1:-nvidia-ai-project}"
    local project_dir="$NVIDIA_AI_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        # Create basic NVIDIA AI structure
        cat > "nvidia_ai_config.json" << 'EOF'
{
    "framework": "tensorrt",
    "precision": "fp16",
    "batch_size": 1,
    "gpus": 1,
    "models": {
        "riva": {
            "enabled": true,
            "models_path": "./models/riva"
        },
        "jarvis": {
            "enabled": true,
            "models_path": "./models/jarvis"
        },
        "merlin": {
            "enabled": true,
            "models_path": "./models/merlin"
        },
        "triton": {
            "enabled": true,
            "models_path": "./models/triton"
        },
        "deepstream": {
            "enabled": true,
            "models_path": "./models/deepstream"
        }
    }
}
EOF

        cat > "requirements.txt" << 'EOF'
tensorrt
torch
torchvision
torchaudio
transformers
datasets
accelerate
nvidia-pyindex
nvidia-triton
nvidia-deepstream
EOF

        # Create model directories
        mkdir -p models/{riva,jarvis,merlin,triton,deepstream}
        
        echo "NVIDIA AI project '$project_name' initialized in $project_dir"
    else
        echo "Project '$project_name' already exists"
    fi
}

# NVIDIA Riva functions
riva_setup() {
    # Setup NVIDIA Riva
    cat > "$RIVA_CONFIG_FILE" << EOF
# NVIDIA Riva Configuration
models:
  asr:
    enabled: true
    model_path: $RIVA_MODELS_DIR/asr
  tts:
    enabled: true
    model_path: $RIVA_MODELS_DIR/tts
  nlp:
    enabled: true
    model_path: $RIVA_MODELS_DIR/nlp

server:
  host: localhost
  port: 50051
  max_workers: 4

gpu:
  devices: $CUDA_VISIBLE_DEVICES
  memory_fraction: 0.8
EOF
    echo "NVIDIA Riva configured"
}

riva_start() {
    # Start NVIDIA Riva server
    if command -v riva-start &> /dev/null; then
        riva-start --config "$RIVA_CONFIG_FILE"
    else
        echo "NVIDIA Riva not installed or not in PATH"
        return 1
    fi
}

riva_test() {
    # Test NVIDIA Riva connection
    if command -v python3 &> /dev/null; then
        python3 -c "
import grpc
import riva.client

# Test Riva connection
try:
    client = riva.client.SpeechClient('localhost:50051')
    print('NVIDIA Riva connection successful')
except Exception as e:
    print(f'NVIDIA Riva connection failed: {e}')
"
    else
        echo "Python3 not available"
    fi
}

# NVIDIA Jarvis functions
jarvis_setup() {
    # Setup NVIDIA Jarvis
    cat > "$JARVIS_CONFIG_FILE" << EOF
# NVIDIA Jarvis Configuration
models:
  nlp:
    enabled: true
    model_path: $JARVIS_MODELS_DIR/nlp
  vision:
    enabled: true
    model_path: $JARVIS_MODELS_DIR/vision
  multimodal:
    enabled: true
    model_path: $JARVIS_MODELS_DIR/multimodal

server:
  host: localhost
  port: 8000
  workers: 4

gpu:
  devices: $CUDA_VISIBLE_DEVICES
  memory_fraction: 0.8
EOF
    echo "NVIDIA Jarvis configured"
}

jarvis_start() {
    # Start NVIDIA Jarvis server
    if command -v jarvis-server &> /dev/null; then
        jarvis-server --config "$JARVIS_CONFIG_FILE"
    else
        echo "NVIDIA Jarvis not installed or not in PATH"
        return 1
    fi
}

# NVIDIA Merlin functions
merlin_setup() {
    # Setup NVIDIA Merlin
    cat > "$MERLIN_CONFIG_FILE" << EOF
# NVIDIA Merlin Configuration
models:
  recommendation:
    enabled: true
    model_path: $MERLIN_MODELS_DIR/recommendation
  ranking:
    enabled: true
    model_path: $MERLIN_MODELS_DIR/ranking

data:
  datasets_path: $MERLIN_DATASETS_DIR
  cache_path: $HOME/.cache/merlin

gpu:
  devices: $CUDA_VISIBLE_DEVICES
  memory_fraction: 0.8
EOF
    echo "NVIDIA Merlin configured"
}

merlin_train() {
    # Train NVIDIA Merlin model
    local config_file="${1:-$MERLIN_CONFIG_FILE}"
    echo "Starting NVIDIA Merlin training with config: $config_file"
    # Implementation would depend on specific Merlin training scripts
}

# NVIDIA Triton functions
triton_setup() {
    # Setup NVIDIA Triton
    cat > "$TRITON_CONFIG_FILE" << 'EOF'
{
    "server": {
        "host": "localhost",
        "port": 8000,
        "grpc_port": 8001,
        "metrics_port": 8002,
        "max_workers": 4
    },
    "models": {
        "repository_path": "./models",
        "auto_reload": true
    },
    "gpu": {
        "devices": [0],
        "memory_fraction": 0.8
    }
}
EOF
    echo "NVIDIA Triton configured"
}

triton_start() {
    # Start NVIDIA Triton server
    if command -v tritonserver &> /dev/null; then
        tritonserver --model-repository="$TRITON_MODELS_DIR" --config-file="$TRITON_CONFIG_FILE"
    else
        echo "NVIDIA Triton not installed or not in PATH"
        return 1
    fi
}

triton_test() {
    # Test NVIDIA Triton connection
    if command -v python3 &> /dev/null; then
        python3 -c "
import tritonclient.http as httpclient

# Test Triton connection
try:
    client = httpclient.InferenceServerClient(url='localhost:8000')
    print('NVIDIA Triton connection successful')
    print('Server status:', client.get_server_status())
except Exception as e:
    print(f'NVIDIA Triton connection failed: {e}')
"
    else
        echo "Python3 not available"
    fi
}

# NVIDIA DeepStream functions
deepstream_setup() {
    # Setup NVIDIA DeepStream
    cat > "$DEEPSTREAM_CONFIG_FILE" << EOF
[application]
enable-perf-measurement=1
perf-measurement-interval-sec=5

[sink0]
enable=1
type=2
sync=0
codec=1
bitrate=4000000
output-fps=30

[streammux]
gpu-id=0
batch-size=1
width=1920
height=1080
enable-padding=0

[sources]
num-sources=1

[source0]
enable=1
type=3
camera-width=1920
camera-height=1080
camera-fps-n=30
camera-fps-d=1

[primary-gie]
enable=1
gpu-id=0
model-engine-file=$DEEPSTREAM_MODELS_DIR/primary.engine
batch-size=1
bbox-border-color0=1;0;0;1
bbox-border-color1=0;1;1;1
bbox-border-color2=0;1;1;1
bbox-border-color3=0;1;0;1
interval=0
gie-unique-id=1
nvbuf-memory-type=0

[tracker]
enable=1
tracker-width=640
tracker-height=384
ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so
ll-config-file=/opt/nvidia/deepstream/deepstream/samples/configs/deepstream-app/config_tracker_NvDCF_perf.yml
gpu-id=0
EOF
    echo "NVIDIA DeepStream configured"
}

deepstream_start() {
    # Start NVIDIA DeepStream
    if command -v deepstream-app &> /dev/null; then
        deepstream-app -c "$DEEPSTREAM_CONFIG_FILE"
    else
        echo "NVIDIA DeepStream not installed or not in PATH"
        return 1
    fi
}

# NVIDIA Omniverse functions
omniverse_setup() {
    # Setup NVIDIA Omniverse
    cat > "$OMNIVERSE_CONFIG_FILE" << 'EOF'
{
    "server": {
        "host": "localhost",
        "port": 8080,
        "enable_ssl": false
    },
    "workspace": {
        "path": "./workspace",
        "auto_save": true
    },
    "gpu": {
        "devices": [0],
        "memory_fraction": 0.8
    }
}
EOF
    echo "NVIDIA Omniverse configured"
}

omniverse_start() {
    # Start NVIDIA Omniverse
    if command -v omniverse-app &> /dev/null; then
        omniverse-app --config "$OMNIVERSE_CONFIG_FILE"
    else
        echo "NVIDIA Omniverse not installed or not in PATH"
        return 1
    fi
}

# NVIDIA AI utility functions
nvidia_ai_status() {
    # Show NVIDIA AI configuration status
    echo "NVIDIA AI Configuration:"
    echo "  Config Dir: $NVIDIA_AI_CONFIG_DIR"
    echo "  Workspace Dir: $NVIDIA_AI_WORKSPACE_DIR"
    echo "  Models Dir: $NVIDIA_AI_MODELS_DIR"
    echo "  Datasets Dir: $NVIDIA_AI_DATASETS_DIR"
    echo "  Logs Dir: $NVIDIA_AI_LOGS_DIR"
    echo "  Default Precision: $NVIDIA_AI_DEFAULT_PRECISION"
    echo "  Default Batch Size: $NVIDIA_AI_DEFAULT_BATCH_SIZE"
    echo "  Default GPUs: $NVIDIA_AI_DEFAULT_GPUS"
    echo "  CUDA Devices: $CUDA_VISIBLE_DEVICES"
    echo "  Use CUDA: $NVIDIA_AI_USE_CUDA"
    echo ""
    echo "Framework Status:"
    echo "  Riva: $(test -f "$RIVA_CONFIG_FILE" && echo "configured" || echo "not configured")"
    echo "  Jarvis: $(test -f "$JARVIS_CONFIG_FILE" && echo "configured" || echo "not configured")"
    echo "  Merlin: $(test -f "$MERLIN_CONFIG_FILE" && echo "configured" || echo "not configured")"
    echo "  Triton: $(test -f "$TRITON_CONFIG_FILE" && echo "configured" || echo "not configured")"
    echo "  DeepStream: $(test -f "$DEEPSTREAM_CONFIG_FILE" && echo "configured" || echo "not configured")"
    echo "  Omniverse: $(test -f "$OMNIVERSE_CONFIG_FILE" && echo "configured" || echo "not configured")"
}

nvidia_ai_logs() {
    # Show NVIDIA AI logs
    local framework="${1:-all}"
    
    case "$framework" in
        "riva")
            ls -t "$RIVA_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
            ;;
        "jarvis")
            ls -t "$JARVIS_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
            ;;
        "merlin")
            ls -t "$MERLIN_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
            ;;
        "triton")
            ls -t "$TRITON_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
            ;;
        "deepstream")
            ls -t "$DEEPSTREAM_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
            ;;
        "omniverse")
            ls -t "$OMNIVERSE_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
            ;;
        *)
            echo "Available frameworks: riva, jarvis, merlin, triton, deepstream, omniverse"
            ;;
    esac
}

nvidia_ai_clean() {
    # Clean NVIDIA AI logs and temporary files
    rm -f "$NVIDIA_AI_LOGS_DIR"/*.log
    rm -f "$RIVA_LOGS_DIR"/*.log
    rm -f "$JARVIS_LOGS_DIR"/*.log
    rm -f "$MERLIN_LOGS_DIR"/*.log
    rm -f "$TRITON_LOGS_DIR"/*.log
    rm -f "$DEEPSTREAM_LOGS_DIR"/*.log
    rm -f "$OMNIVERSE_LOGS_DIR"/*.log
    rm -rf "$NVIDIA_AI_WORKSPACE_DIR"/*/__pycache__
    echo "NVIDIA AI logs and cache cleaned"
}

# NVIDIA AI aliases
alias nvai='nvidia_ai_init'
alias nvai-status='nvidia_ai_status'
alias nvai-logs='nvidia_ai_logs'
alias nvai-clean='nvidia_ai_clean'
alias riva-setup='riva_setup'
alias riva-start='riva_start'
alias riva-test='riva_test'
alias jarvis-setup='jarvis_setup'
alias jarvis-start='jarvis_start'
alias merlin-setup='merlin_setup'
alias merlin-train='merlin_train'
alias triton-setup='triton_setup'
alias triton-start='triton_start'
alias triton-test='triton_test'
alias deepstream-setup='deepstream_setup'
alias deepstream-start='deepstream_start'
alias omniverse-setup='omniverse_setup'
alias omniverse-start='omniverse_start'

# NVIDIA AI project management
nvidia_ai_list_projects() {
    # List NVIDIA AI projects
    ls -la "$NVIDIA_AI_WORKSPACE_DIR" 2>/dev/null | grep -v "^total" | awk '{print $9}' | grep -v "^\.$\|^\.\.$"
}

nvidia_ai_activate_project() {
    # Activate NVIDIA AI project
    local project_name="${1:-}"
    
    if [[ -n "$project_name" ]]; then
        local project_dir="$NVIDIA_AI_WORKSPACE_DIR/$project_name"
        if [[ -d "$project_dir" ]]; then
            cd "$project_dir"
            echo "Activated NVIDIA AI project: $project_name"
        else
            echo "Project '$project_name' not found"
            return 1
        fi
    else
        echo "Usage: nvidia_ai_activate_project 'project_name'"
        return 1
    fi
}

# NVIDIA AI installation check
nvidia_ai_install_check() {
    # Check if NVIDIA AI tools are properly installed
    local missing=()
    
    if ! command -v python3 &> /dev/null; then
        missing+=("python3")
    fi
    
    if ! command -v nvidia-smi &> /dev/null; then
        missing+=("nvidia-driver")
    fi
    
    if ! python3 -c "import torch; torch.cuda.is_available()" 2>/dev/null; then
        missing+=("torch-cuda")
    fi
    
    if [[ ${#missing[@]} -eq 0 ]]; then
        echo "All NVIDIA AI dependencies are installed"
        return 0
    else
        echo "Missing dependencies: ${missing[*]}"
        return 1
    fi
}

# NVIDIA AI CUDA check
nvidia_ai_cuda_check() {
    # Check CUDA availability for NVIDIA AI
    if command -v nvidia-smi &> /dev/null; then
        echo "NVIDIA GPU Information:"
        nvidia-smi --query-gpu=name,memory.total,memory.free,utilization.gpu --format=csv,noheader,nounits
    else
        echo "nvidia-smi not available"
    fi
    
    if command -v python3 &> /dev/null; then
        python3 -c "
import torch
print('\\nPyTorch CUDA Information:')
print('CUDA available:', torch.cuda.is_available())
if torch.cuda.is_available():
    print('CUDA device count:', torch.cuda.device_count())
    print('Current CUDA device:', torch.cuda.current_device())
    print('CUDA device name:', torch.cuda.get_device_name(0))
    print('CUDA memory allocated:', torch.cuda.memory_allocated(0) / 1024**3, 'GB')
    print('CUDA memory cached:', torch.cuda.memory_reserved(0) / 1024**3, 'GB')
"
    else
        echo "Python3 not available"
    fi
}

# NVIDIA AI configuration validation
if command -v nvidia-smi &> /dev/null && python3 -c "import torch; torch.cuda.is_available()" 2>/dev/null; then
    export NVIDIA_AI_CUDA_AVAILABLE=true
else
    export NVIDIA_AI_CUDA_AVAILABLE=false
fi

if command -v nvidia-smi &> /dev/null; then
    export NVIDIA_AI_CONFIGURED=true
else
    export NVIDIA_AI_CONFIGURED=false
fi

# NVIDIA AI integration complete
if [[ "$NVIDIA_AI_CONFIGURED" == "true" ]]; then
    export NVIDIA_AI_INTEGRATION="active"
else
    export NVIDIA_AI_INTEGRATION="limited"
fi
