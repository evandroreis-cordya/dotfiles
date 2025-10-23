#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

print_in_purple "
   NVIDIA NeMO Framework

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# NVIDIA NeMO Toolkit - Core framework
execute "pip3 install nemo-toolkit[all]" \
    "Installing NVIDIA NeMO Toolkit with all components"

execute "pip3 install nemo-toolkit[asr]" \
    "Installing NVIDIA NeMO ASR components"

execute "pip3 install nemo-toolkit[nlp]" \
    "Installing NVIDIA NeMO NLP components"

execute "pip3 install nemo-toolkit[tts]" \
    "Installing NVIDIA NeMO TTS components"

execute "pip3 install nemo-toolkit[multimodal]" \
    "Installing NVIDIA NeMO Multimodal components"

# NVIDIA NeMO Framework
execute "pip3 install nemo-framework" \
    "Installing NVIDIA NeMO Framework"

# NVIDIA NeMO Speech Processing
execute "pip3 install nemo-speech" \
    "Installing NVIDIA NeMO Speech"

execute "pip3 install nemo-asr" \
    "Installing NVIDIA NeMO ASR"

execute "pip3 install nemo-tts" \
    "Installing NVIDIA NeMO TTS"

execute "pip3 install nemo-stt" \
    "Installing NVIDIA NeMO STT"

# NVIDIA NeMO NLP Processing
execute "pip3 install nemo-nlp" \
    "Installing NVIDIA NeMO NLP"

execute "pip3 install nemo-text-processing" \
    "Installing NVIDIA NeMO Text Processing"

execute "pip3 install nemo-language-modeling" \
    "Installing NVIDIA NeMO Language Modeling"

# NVIDIA NeMO Multimodal Processing
execute "pip3 install nemo-multimodal" \
    "Installing NVIDIA NeMO Multimodal"

execute "pip3 install nemo-vision" \
    "Installing NVIDIA NeMO Vision"

execute "pip3 install nemo-audio" \
    "Installing NVIDIA NeMO Audio"

# NVIDIA NeMO Model Training
execute "pip3 install nemo-training" \
    "Installing NVIDIA NeMO Training"

execute "pip3 install nemo-megatron" \
    "Installing NVIDIA NeMO Megatron"

execute "pip3 install nemo-prompt-learning" \
    "Installing NVIDIA NeMO Prompt Learning"

# NVIDIA NeMO Inference
execute "pip3 install nemo-inference" \
    "Installing NVIDIA NeMO Inference"

execute "pip3 install nemo-deploy" \
    "Installing NVIDIA NeMO Deploy"

execute "pip3 install nemo-serving" \
    "Installing NVIDIA NeMO Serving"

# NVIDIA NeMO Data Processing
execute "pip3 install nemo-data" \
    "Installing NVIDIA NeMO Data"

execute "pip3 install nemo-dataloader" \
    "Installing NVIDIA NeMO DataLoader"

execute "pip3 install nemo-preprocessing" \
    "Installing NVIDIA NeMO Preprocessing"

# NVIDIA NeMO Evaluation
execute "pip3 install nemo-evaluation" \
    "Installing NVIDIA NeMO Evaluation"

execute "pip3 install nemo-metrics" \
    "Installing NVIDIA NeMO Metrics"

execute "pip3 install nemo-benchmarks" \
    "Installing NVIDIA NeMO Benchmarks"

# NVIDIA NeMO Utilities
execute "pip3 install nemo-utils" \
    "Installing NVIDIA NeMO Utilities"

execute "pip3 install nemo-tools" \
    "Installing NVIDIA NeMO Tools"

execute "pip3 install nemo-cli" \
    "Installing NVIDIA NeMO CLI"

# NVIDIA NeMO Model Hub
execute "pip3 install nemo-model-hub" \
    "Installing NVIDIA NeMO Model Hub"

execute "pip3 install nemo-model-zoo" \
    "Installing NVIDIA NeMO Model Zoo"

execute "pip3 install nemo-pre-trained" \
    "Installing NVIDIA NeMO Pre-trained Models"

# NVIDIA NeMO Research
execute "pip3 install nemo-research" \
    "Installing NVIDIA NeMO Research"

execute "pip3 install nemo-experimental" \
    "Installing NVIDIA NeMO Experimental"

execute "pip3 install nemo-labs" \
    "Installing NVIDIA NeMO Labs"

# NVIDIA NeMO Enterprise
execute "pip3 install nemo-enterprise" \
    "Installing NVIDIA NeMO Enterprise"

execute "pip3 install nemo-production" \
    "Installing NVIDIA NeMO Production"

execute "pip3 install nemo-optimized" \
    "Installing NVIDIA NeMO Optimized"

# NVIDIA NeMO Integration
execute "pip3 install nemo-triton" \
    "Installing NVIDIA NeMO Triton Integration"

execute "pip3 install nemo-tensorrt" \
    "Installing NVIDIA NeMO TensorRT Integration"

execute "pip3 install nemo-onnx" \
    "Installing NVIDIA NeMO ONNX Integration"

# NVIDIA NeMO Deployment
execute "pip3 install nemo-container" \
    "Installing NVIDIA NeMO Container"

execute "pip3 install nemo-docker" \
    "Installing NVIDIA NeMO Docker"

execute "pip3 install nemo-kubernetes" \
    "Installing NVIDIA NeMO Kubernetes"

# NVIDIA NeMO Monitoring
execute "pip3 install nemo-monitoring" \
    "Installing NVIDIA NeMO Monitoring"

execute "pip3 install nemo-logging" \
    "Installing NVIDIA NeMO Logging"

execute "pip3 install nemo-profiling" \
    "Installing NVIDIA NeMO Profiling"

# NVIDIA NeMO Security
execute "pip3 install nemo-security" \
    "Installing NVIDIA NeMO Security"

execute "pip3 install nemo-encryption" \
    "Installing NVIDIA NeMO Encryption"

execute "pip3 install nemo-compliance" \
    "Installing NVIDIA NeMO Compliance"

# NVIDIA NeMO Documentation
execute "pip3 install nemo-docs" \
    "Installing NVIDIA NeMO Documentation"

execute "pip3 install nemo-tutorials" \
    "Installing NVIDIA NeMO Tutorials"

execute "pip3 install nemo-examples" \
    "Installing NVIDIA NeMO Examples"

# NVIDIA NeMO Testing
execute "pip3 install nemo-testing" \
    "Installing NVIDIA NeMO Testing"

execute "pip3 install nemo-unit-tests" \
    "Installing NVIDIA NeMO Unit Tests"

execute "pip3 install nemo-integration-tests" \
    "Installing NVIDIA NeMO Integration Tests"

# NVIDIA NeMO Performance
execute "pip3 install nemo-performance" \
    "Installing NVIDIA NeMO Performance"

execute "pip3 install nemo-benchmarking" \
    "Installing NVIDIA NeMO Benchmarking"

execute "pip3 install nemo-optimization" \
    "Installing NVIDIA NeMO Optimization"

# NVIDIA NeMO Community
execute "pip3 install nemo-community" \
    "Installing NVIDIA NeMO Community"

execute "pip3 install nemo-contrib" \
    "Installing NVIDIA NeMO Contributions"

execute "pip3 install nemo-extensions" \
    "Installing NVIDIA NeMO Extensions"

# NVIDIA NeMO Configuration
execute "pip3 install nemo-config" \
    "Installing NVIDIA NeMO Configuration"

execute "pip3 install nemo-settings" \
    "Installing NVIDIA NeMO Settings"

execute "pip3 install nemo-preferences" \
    "Installing NVIDIA NeMO Preferences"

# NVIDIA NeMO Workflow
execute "pip3 install nemo-workflow" \
    "Installing NVIDIA NeMO Workflow"

execute "pip3 install nemo-pipeline" \
    "Installing NVIDIA NeMO Pipeline"

execute "pip3 install nemo-automation" \
    "Installing NVIDIA NeMO Automation"
