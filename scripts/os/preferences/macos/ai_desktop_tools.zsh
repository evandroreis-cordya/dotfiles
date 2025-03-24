#!/bin/zsh

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.zsh"

print_in_purple "\n   AI Desktop Applications and Tools\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Local LLM Platforms
brew_install "ollama" "Installing Ollama" false

brew_install "ollama-gui" "Installing Ollama GUI" true

brew_install "lm-studio" "Installing LM Studio" true

brew_install "text-generator" "Installing Text Generator" true

# AI Chat Clients
brew_install "chatgpt" "Installing ChatGPT Desktop" true

brew_install "claude" "Installing Claude Desktop" true

brew_install "cursor" "Installing Cursor AI Code Editor" true

brew_install "bito" "Installing Bito AI Assistant" true

brew_install "codeium" "Installing Codeium" true

brew_install "tabnine-desktop" "Installing Tabnine Desktop" true

# AI Image Tools
brew_install "stable-diffusion" "Installing Stable Diffusion UI" true

brew_install "diffusionbee" "Installing DiffusionBee" true

brew_install "invoke-ai" "Installing Invoke AI" true

brew_install "comfyui" "Installing ComfyUI" true

brew_install "automatic1111" "Installing AUTOMATIC1111" true

brew_install "fooocus" "Installing Fooocus" true

# AI Audio Tools
brew_install "whisper-studio" "Installing Whisper Studio" true

brew_install "bark-voice" "Installing Bark Voice Generation" true

brew_install "audiogen" "Installing AudioGen" true

brew_install "music-gen" "Installing MusicGen" true

brew_install "elevenlabs" "Installing ElevenLabs" true

brew_install "soundraw" "Installing Soundraw" true

# AI Video Tools
brew_install "runway" "Installing Runway" true

brew_install "d-id" "Installing D-ID Studio" true

brew_install "synthesia" "Installing Synthesia" true

brew_install "descript" "Installing Descript" true

brew_install "kapwing" "Installing Kapwing" true

brew_install "wonder-studio" "Installing Wonder Studio" true

# AI Writing and Productivity
brew_install "notion-ai" "Installing Notion AI" true

brew_install "mem" "Installing Mem AI" true

brew_install "otter" "Installing Otter AI" true

brew_install "murf" "Installing Murf Studio" true

brew_install "jasper" "Installing Jasper" true

brew_install "grammarly-desktop" "Installing Grammarly Desktop" true

# AI Development Environments
brew_install "visual-studio-code" "Installing VS Code" true

brew_install "jupyter-lab-desktop" "Installing JupyterLab Desktop" true

brew_install "anaconda" "Installing Anaconda" true

brew_install "pycharm" "Installing PyCharm" true

brew_install "deeplearning-tools" "Installing Deep Learning Tools" true

brew_install "nvidia-cuda-toolkit" "Installing NVIDIA CUDA Toolkit" true

# AI Model Management
brew_install "hugging-face-hub" "Installing Hugging Face Hub Desktop" true

brew_install "weights-and-biases" "Installing Weights & Biases Desktop" true

brew_install "neptune" "Installing Neptune" true

brew_install "mlflow" "Installing MLflow" false

brew_install "tensorboard" "Installing TensorBoard" false

brew_install "dvc" "Installing DVC" false

# AI Browser Extensions Manager
brew_install "chrome-extension-manager" "Installing Chrome Extension Manager" true

echo "Remember to install these browser extensions:"
echo "1. ChatGPT for Google"
echo "2. Codeium"
echo "3. GitHub Copilot"
echo "4. Grammarly AI"
echo "5. Notion AI"
echo "6. Jasper Browser Extension"

# Local Model Management
brew_install "modelz" "Installing Modelz" false

brew_install "model-manager" "Installing Model Manager" true

brew_install "hugging-face-downloader" "Installing Hugging Face Downloader" true

brew_install "model-converter" "Installing Model Converter" true

brew_install "onnx-runtime" "Installing ONNX Runtime" false

brew_install "tensorflow-tools" "Installing TensorFlow Tools" false

# AI Testing and Debugging
brew_install "ai-test-kitchen" "Installing AI Test Kitchen" true

brew_install "prompt-perfect" "Installing Prompt Perfect" true

brew_install "ai-playground" "Installing AI Playground" true

brew_install "model-debugger" "Installing Model Debugger" true

brew_install "explainable-ai" "Installing Explainable AI Tools" true

brew_install "ai-fairness-tools" "Installing AI Fairness Tools" true

# AI Research Tools
brew_install "papers-with-code" "Installing Papers with Code" true

brew_install "arxiv-sanity" "Installing Arxiv Sanity" true

brew_install "research-assistant" "Installing Research Assistant" true

brew_install "citation-manager" "Installing Citation Manager" true

brew_install "zotero" "Installing Zotero" true

brew_install "mendeley" "Installing Mendeley" true
