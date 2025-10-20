#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh"

print_in_purple "
   NVIDIA Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# CUDA Toolkit
execute "brew install cuda" \
    "Installing CUDA Toolkit"

execute "brew install cuda-tools" \
    "Installing CUDA Development Tools"

# Deep Learning Frameworks
execute "pip3 install cupy-cuda12x" \
    "Installing CuPy for CUDA"

execute "pip3 install nvidia-cuda-runtime-cu12" \
    "Installing CUDA Runtime"

execute "pip3 install nvidia-cuda-nvrtc-cu12" \
    "Installing CUDA NVRTC"

execute "pip3 install nvidia-cublas-cu12" \
    "Installing cuBLAS"

execute "pip3 install nvidia-cudnn-cu12" \
    "Installing cuDNN"

execute "pip3 install nvidia-cufft-cu12" \
    "Installing cuFFT"

execute "pip3 install nvidia-curand-cu12" \
    "Installing cuRAND"

execute "pip3 install nvidia-cusolver-cu12" \
    "Installing cuSOLVER"

execute "pip3 install nvidia-cusparse-cu12" \
    "Installing cuSPARSE"

execute "pip3 install nvidia-nccl-cu12" \
    "Installing NCCL"

# NVIDIA Deep Learning Libraries
execute "pip3 install nvidia-dali-cuda120" \
    "Installing NVIDIA DALI"

execute "pip3 install nvidia-tensorrt" \
    "Installing TensorRT"

execute "pip3 install nvidia-apex" \
    "Installing NVIDIA Apex"

execute "pip3 install nvidia-pyindex" \
    "Installing NVIDIA PyIndex"

# NVIDIA Optimization Tools
execute "pip3 install triton" \
    "Installing Triton"

execute "pip3 install cutlass" \
    "Installing CUTLASS"

execute "pip3 install cudf-cu12" \
    "Installing cuDF"

execute "pip3 install cuml-cu12" \
    "Installing cuML"

execute "pip3 install cugraph-cu12" \
    "Installing cuGraph"

# NVIDIA Monitoring and Profiling
execute "pip3 install nvidia-ml-py" \
    "Installing NVIDIA Management Library"

execute "pip3 install pynvml" \
    "Installing PyNVML"

# NVIDIA Container Tools
execute "brew install nvidia-container-toolkit" \
    "Installing NVIDIA Container Toolkit"

# NVIDIA Development Tools
execute "pip3 install numba" \
    "Installing Numba"

execute "pip3 install cupy" \
    "Installing CuPy"

execute "pip3 install pycuda" \
    "Installing PyCUDA"

# NVIDIA AI Tools
execute "pip3 install torch --extra-index-url https://download.pytorch.org/whl/cu121" \
    "Installing PyTorch with CUDA support"

execute "pip3 install nvidia-tensorflow" \
    "Installing NVIDIA TensorFlow"

execute "pip3 install nvidia-rapids" \
    "Installing RAPIDS"

execute "pip3 install nvidia-modulus" \
    "Installing NVIDIA Modulus"

execute "pip3 install nvidia-tao" \
    "Installing NVIDIA TAO Toolkit"

# NVIDIA Riva - Speech AI
execute "pip3 install nvidia-riva-client" \
    "Installing NVIDIA Riva Client"

execute "pip3 install nvidia-riva-server" \
    "Installing NVIDIA Riva Server"

execute "pip3 install nvidia-riva-asr" \
    "Installing NVIDIA Riva ASR"

execute "pip3 install nvidia-riva-tts" \
    "Installing NVIDIA Riva TTS"

execute "pip3 install nvidia-riva-nlp" \
    "Installing NVIDIA Riva NLP"

# NVIDIA Jarvis - Conversational AI
execute "pip3 install nvidia-jarvis" \
    "Installing NVIDIA Jarvis"

execute "pip3 install nvidia-jarvis-client" \
    "Installing NVIDIA Jarvis Client"

execute "pip3 install nvidia-jarvis-server" \
    "Installing NVIDIA Jarvis Server"

# NVIDIA Merlin - Recommendation Systems
execute "pip3 install nvidia-merlin" \
    "Installing NVIDIA Merlin"

execute "pip3 install nvidia-merlin-core" \
    "Installing NVIDIA Merlin Core"

execute "pip3 install nvidia-merlin-systems" \
    "Installing NVIDIA Merlin Systems"

execute "pip3 install nvidia-merlin-dataloader" \
    "Installing NVIDIA Merlin DataLoader"

execute "pip3 install nvidia-merlin-models" \
    "Installing NVIDIA Merlin Models"

# NVIDIA Triton Inference Server
execute "pip3 install tritonclient" \
    "Installing Triton Client"

execute "pip3 install tritonclient[all]" \
    "Installing Triton Client with all protocols"

execute "pip3 install nvidia-triton" \
    "Installing NVIDIA Triton"

# NVIDIA DeepStream SDK
execute "pip3 install nvidia-deepstream" \
    "Installing NVIDIA DeepStream"

execute "pip3 install nvidia-deepstream-sdk" \
    "Installing NVIDIA DeepStream SDK"

execute "pip3 install nvidia-deepstream-plugins" \
    "Installing NVIDIA DeepStream Plugins"

# NVIDIA Omniverse Tools
execute "pip3 install nvidia-omniverse" \
    "Installing NVIDIA Omniverse"

execute "pip3 install nvidia-omniverse-client" \
    "Installing NVIDIA Omniverse Client"

execute "pip3 install nvidia-omniverse-kit" \
    "Installing NVIDIA Omniverse Kit"

# NVIDIA Maxine - AI Effects Platform
execute "pip3 install nvidia-maxine" \
    "Installing NVIDIA Maxine"

execute "pip3 install nvidia-maxine-sdk" \
    "Installing NVIDIA Maxine SDK"

# NVIDIA Video Codec SDK
execute "pip3 install nvidia-video-codec-sdk" \
    "Installing NVIDIA Video Codec SDK"

# NVIDIA Audio Effects SDK
execute "pip3 install nvidia-audio-effects-sdk" \
    "Installing NVIDIA Audio Effects SDK"

# NVIDIA Clara - Healthcare AI
execute "pip3 install nvidia-clara" \
    "Installing NVIDIA Clara"

execute "pip3 install nvidia-clara-train" \
    "Installing NVIDIA Clara Train"

execute "pip3 install nvidia-clara-infer" \
    "Installing NVIDIA Clara Infer"

# NVIDIA Isaac - Robotics AI
execute "pip3 install nvidia-isaac" \
    "Installing NVIDIA Isaac"

execute "pip3 install nvidia-isaac-sim" \
    "Installing NVIDIA Isaac Sim"

# NVIDIA Fleet Command
execute "pip3 install nvidia-fleet-command" \
    "Installing NVIDIA Fleet Command"

# NVIDIA AI Enterprise
execute "pip3 install nvidia-ai-enterprise" \
    "Installing NVIDIA AI Enterprise"

# NVIDIA AI Workbench
execute "pip3 install nvidia-ai-workbench" \
    "Installing NVIDIA AI Workbench"

# NVIDIA AI Foundation Models
execute "pip3 install nvidia-foundation-models" \
    "Installing NVIDIA Foundation Models"

# NVIDIA NeMO Framework
execute "pip3 install nemo-toolkit[all]" \
    "Installing NVIDIA NeMO Toolkit"

execute "pip3 install nemo-framework" \
    "Installing NVIDIA NeMO Framework"

execute "pip3 install nemo-speech" \
    "Installing NVIDIA NeMO Speech"

execute "pip3 install nemo-nlp" \
    "Installing NVIDIA NeMO NLP"

execute "pip3 install nemo-tts" \
    "Installing NVIDIA NeMO TTS"

# NVIDIA HPC SDK
execute "pip3 install nvidia-hpc-sdk" \
    "Installing NVIDIA HPC SDK"

# NVIDIA Quantum Computing
execute "pip3 install nvidia-quantum" \
    "Installing NVIDIA Quantum"

# NVIDIA Edge Computing
execute "pip3 install nvidia-edge" \
    "Installing NVIDIA Edge Computing"

# NVIDIA Cloud Native
execute "pip3 install nvidia-cloud-native" \
    "Installing NVIDIA Cloud Native"

# NVIDIA AI Platform
execute "pip3 install nvidia-ai-platform" \
    "Installing NVIDIA AI Platform"

# NVIDIA Developer Tools
execute "pip3 install nvidia-developer-tools" \
    "Installing NVIDIA Developer Tools"

# NVIDIA AI SDK
execute "pip3 install nvidia-ai-sdk" \
    "Installing NVIDIA AI SDK"
