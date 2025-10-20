#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

print_in_purple "
   Autonomous Agents Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# LangChain - Framework for developing context-aware reasoning applications
execute "pip3 install langchain" \
    "Installing LangChain"

# Auto-GPT - Autonomous GPT-4 experiment
execute "pip3 install auto-gpt" \
    "Installing Auto-GPT"

# Agent tooling and frameworks
execute "pip3 install crewai" \
    "Installing CrewAI"

execute "pip3 install autogen" \
    "Installing AutoGen"

# Vector databases for agent memory
execute "pip3 install chromadb" \
    "Installing ChromaDB"

execute "pip3 install faiss-cpu" \
    "Installing FAISS"

# Tools for agent capabilities
execute "pip3 install selenium" \
    "Installing Selenium for web automation"

execute "pip3 install beautifulsoup4" \
    "Installing BeautifulSoup for web scraping"

execute "pip3 install duckduckgo-search" \
    "Installing DuckDuckGo Search"

# Document processing
execute "pip3 install unstructured" \
    "Installing Unstructured"

execute "pip3 install pypdf" \
    "Installing PyPDF"

# Agent observation and monitoring
execute "pip3 install wandb" \
    "Installing Weights & Biases"

# Natural Language Processing
execute "pip3 install spacy" \
    "Installing SpaCy"

execute "python3 -m spacy download en_core_web_sm" \
    "Downloading SpaCy English model"

# CrewAI CLI tools and utilities
execute "pip3 install crewai-tools" \
    "Installing CrewAI tools"

execute "pip3 install crewai-cli" \
    "Installing CrewAI CLI"

# Additional CrewAI tools
execute "pip3 install serper-dev" \
    "Installing SerperDev for web search"

execute "pip3 install website-search" \
    "Installing WebsiteSearch tool"

execute "pip3 install exa-py" \
    "Installing Exa search tool"

execute "pip3 install tavily-python" \
    "Installing Tavily search tool"

# CrewAI configuration management
execute "pip3 install pyyaml" \
    "Installing PyYAML for configuration"

execute "pip3 install pydantic" \
    "Installing Pydantic for data validation"

execute "pip3 install python-dotenv" \
    "Installing python-dotenv for environment variables"

# Enhanced agent capabilities
execute "pip3 install playwright" \
    "Installing Playwright for browser automation"

execute "pip3 install requests-html" \
    "Installing Requests-HTML for web scraping"

execute "pip3 install newspaper3k" \
    "Installing Newspaper3k for article extraction"

execute "pip3 install textstat" \
    "Installing TextStat for text analysis"

# Agent memory and persistence
execute "pip3 install redis" \
    "Installing Redis for agent memory"

execute "pip3 install sqlalchemy" \
    "Installing SQLAlchemy for database operations"

execute "pip3 install psycopg2-binary" \
    "Installing PostgreSQL adapter"

# Agent communication and coordination
execute "pip3 install websockets" \
    "Installing WebSockets for real-time communication"

execute "pip3 install aiohttp" \
    "Installing aiohttp for async HTTP"

execute "pip3 install asyncio" \
    "Installing asyncio for async operations"

# Agent testing and debugging
execute "pip3 install pytest" \
    "Installing pytest for testing"

execute "pip3 install pytest-asyncio" \
    "Installing pytest-asyncio for async testing"

execute "pip3 install loguru" \
    "Installing Loguru for enhanced logging"

# Agent deployment and monitoring
execute "pip3 install fastapi" \
    "Installing FastAPI for API deployment"

execute "pip3 install uvicorn" \
    "Installing Uvicorn ASGI server"

execute "pip3 install prometheus-client" \
    "Installing Prometheus client for metrics"
