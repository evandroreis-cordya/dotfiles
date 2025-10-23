#!/bin/zsh
#
# NVIDIA Cloud Configuration
# This file contains all NVIDIA cloud-related configurations
#

# Environment Variables
export NVIDIA_API_KEY="${NVIDIA_API_KEY:-}"
export NVIDIA_CLOUD_REGION="${NVIDIA_CLOUD_REGION:-us-east-1}"
export NVIDIA_CLOUD_PROJECT="${NVIDIA_CLOUD_PROJECT:-}"

# NVIDIA Configuration Directory
export NVIDIA_CONFIG_DIR="$HOME/.config/nvidia-cloud"
export NVIDIA_CONFIG_FILE="$NVIDIA_CONFIG_DIR/config.json"

# CUDA Configuration
export CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES:-0}"
export CUDA_HOME="${CUDA_HOME:-/usr/local/cuda}"

# Aliases
alias nvidia-smi="nvidia-smi"
alias nvidia-cloud="nvidia-cloud"
alias cuda-info="nvcc --version"

# Functions
nvidia_setup() {
    if [[ -z "$NVIDIA_API_KEY" ]]; then
        echo "Warning: NVIDIA_API_KEY not set. Please set it in your environment."
        return 1
    fi
    echo "NVIDIA cloud configuration is complete."
}

cuda_check() {
    if command -v nvidia-smi &> /dev/null; then
        nvidia-smi
    else
        echo "NVIDIA drivers not found or not properly installed."
    fi
}

# Tool-specific setup
if command -v nvidia-smi &> /dev/null; then
    # Initialize NVIDIA tools if available
    nvidia_setup
fi
