#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh"

print_in_purple "\n   AI Development Tools\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# OpenAI Tools
pip_install "openai" "Installing OpenAI Python SDK"

pip_install "openai-whisper" "Installing OpenAI Whisper"

pip_install "tiktoken" "Installing OpenAI Tokenizer"

pip_install "openai-function-tools" "Installing OpenAI Function Tools"

pip_install "guidance" "Installing Guidance for OpenAI"

# Anthropic Tools
pip_install "anthropic" "Installing Anthropic SDK"

pip_install "anthropic-bedrock" "Installing Anthropic Bedrock"

pip_install "claude-api" "Installing Claude API"

pip_install "constitutional-ai" "Installing Constitutional AI"

# Grok AI Tools
pip_install "grok-client" "Installing Grok Client"

pip_install "grok-api" "Installing Grok API"

pip_install "xai" "Installing X AI Tools"

# DeepSeek Tools
pip_install "deepseek" "Installing DeepSeek SDK"

pip_install "deepseek-coder" "Installing DeepSeek Coder"

pip_install "deepseek-vl" "Installing DeepSeek Vision-Language"

# Google AI Tools
pip_install "google-generativeai" "Installing Google Generative AI"

pip_install "google-cloud-aiplatform" "Installing Google AI Platform"

pip_install "google-cloud-vision" "Installing Google Cloud Vision"

pip_install "google-cloud-speech" "Installing Google Cloud Speech"

pip_install "google-cloud-translate" "Installing Google Cloud Translate"

# AWS AI Services
pip_install "boto3" "Installing AWS SDK"

pip_install "sagemaker" "Installing SageMaker SDK"

pip_install "aws-cdk.aws-sagemaker" "Installing SageMaker CDK"

pip_install "amazon-textract-caller" "Installing Amazon Textract"

pip_install "amazon-rekognition-custom-labels-sdk" "Installing Amazon Rekognition"

# Azure AI Tools
pip_install "azure-cognitiveservices-vision-computervision" "Installing Azure Computer Vision"

pip_install "azure-cognitiveservices-language-textanalytics" "Installing Azure Text Analytics"

pip_install "azure-ai-language-conversations" "Installing Azure Conversations"

pip_install "azure-ai-ml" "Installing Azure ML"

# Meta AI Tools
pip_install "torch" "Installing PyTorch"

pip_install "fairseq" "Installing Fairseq"

pip_install "detectron2" "Installing Detectron2"

pip_install "pytorch3d" "Installing PyTorch3D"

# Hugging Face Tools
pip_install "transformers" "Installing Transformers"

pip_install "datasets" "Installing Datasets"

pip_install "diffusers" "Installing Diffusers"

pip_install "accelerate" "Installing Accelerate"

pip_install "huggingface_hub" "Installing Hugging Face Hub"

# AI Development Frameworks
pip_install "langchain" "Installing LangChain"

pip_install "llama-index" "Installing LlamaIndex"

pip_install "autogpt" "Installing AutoGPT"

pip_install "semantic-kernel" "Installing Semantic Kernel"

# Vector Databases
pip_install "chromadb" "Installing ChromaDB"

pip_install "pinecone-client" "Installing Pinecone"

pip_install "qdrant-client" "Installing Qdrant"

pip_install "weaviate-client" "Installing Weaviate"

# AI Testing and Evaluation
pip_install "ragas" "Installing Ragas"

pip_install "deepeval" "Installing DeepEval"

pip_install "evaluate" "Installing Evaluate"

# AI Monitoring and Observability
pip_install "langsmith" "Installing LangSmith"

pip_install "weights-biases" "Installing Weights & Biases"

pip_install "helicone" "Installing Helicone"

pip_install "arize-phoenix" "Installing Arize Phoenix"

# AI Safety and Security
pip_install "ai-safety-toolbox" "Installing AI Safety Toolbox"

pip_install "adversarial-robustness-toolbox" "Installing Adversarial Robustness Toolbox"

pip_install "ai-verify" "Installing AI Verify"

# AI Development Tools
pip_install "gradio" "Installing Gradio"

pip_install "streamlit" "Installing Streamlit"

pip_install "chainlit" "Installing Chainlit"

pip_install "jupyter" "Installing Jupyter"

# Model Serving and Deployment
pip_install "bentoml" "Installing BentoML"

pip_install "ray[serve]" "Installing Ray Serve"

pip_install "mlflow" "Installing MLflow"

pip_install "triton-inference-server" "Installing Triton Inference Server"

# AI Media Generation
pip_install "elevenlabs" "Installing ElevenLabs SDK"

pip_install "elevenlabs-python" "Installing ElevenLabs Python"

pip_install "elevenlabs-stream" "Installing ElevenLabs Streaming"

pip_install "elevenlabs-voice-clone" "Installing ElevenLabs Voice Cloning"

pip_install "veed-sdk" "Installing Veed.io SDK"

pip_install "veed-client" "Installing Veed.io Client"

pip_install "veed-api" "Installing Veed.io API"

pip_install "did-api" "Installing D-ID API"

pip_install "did-client" "Installing D-ID Client"

pip_install "did-python" "Installing D-ID Python SDK"

pip_install "did-streaming" "Installing D-ID Streaming"

# Cartesia AI Tools
pip_install "cartesia" "Installing Cartesia SDK"

pip_install "cartesia-client" "Installing Cartesia Client"

pip_install "cartesia-api" "Installing Cartesia API"

pip_install "cartesia-geo" "Installing Cartesia Geo Tools"

pip_install "cartesia-vision" "Installing Cartesia Vision"

pip_install "cartesia-mapping" "Installing Cartesia Mapping"

pip_install "cartesia-3d" "Installing Cartesia 3D"

pip_install "cartesia-ml" "Installing Cartesia ML"

# AI Media Processing
pip_install "media-pipe" "Installing MediaPipe"

pip_install "moviepy" "Installing MoviePy"

pip_install "vidgear" "Installing VidGear"

pip_install "imageio" "Installing ImageIO"

pip_install "av" "Installing PyAV"
