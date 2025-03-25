#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Python Development Tools\n\n"

# Install Python
brew_install "Python" "python"
brew_install "Python@3.11" "python@3.11"

# Install pyenv for Python version management
brew_install "pyenv" "pyenv"
brew_install "pyenv-virtualenv" "pyenv-virtualenv"

# Add pyenv to shell configuration
if ! grep -q 'eval "$(pyenv init --path)"' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOL
fi

# Set up pyenv in the current shell session
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Install Python versions using pyenv
print_in_purple "\n   Installing Python Versions\n\n"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    
    # Install Python versions
    pyenv_install "3.11"
    pyenv_install "3.12" "true"  # Set as global
else
    print_error "pyenv command not found. Please restart your terminal and run the script again."
    print_in_purple "\n   Continuing with other installations...\n\n"
fi

# Install Poetry for dependency management
poetry_install

# Install pipx for isolated application installation
brew_install "pipx" "pipx"
execute "pipx ensurepath" "pipx path setup"

# Install global development tools
print_in_purple "\n   Installing Development Tools\n\n"

# Package Management
pipx_install "pip-tools" "pip-tools"
pipx_install "Poetry" "poetry"

# Development Tools
pipx_install "Black" "black"
pipx_install "isort" "isort"
pipx_install "Pylint" "pylint"
pipx_install "MyPy" "mypy"
pipx_install "Flake8" "flake8"
pipx_install "Bandit" "bandit"
pipx_install "Pyright" "pyright"

# Testing Tools
pipx_install "Pytest" "pytest"
pipx_install "Coverage" "coverage"
pipx_install "Tox" "tox"
pipx_install "Hypothesis" "hypothesis"

# Documentation Tools
pipx_install "Sphinx" "sphinx"
pipx_install "MkDocs" "mkdocs"
pipx_install "pdoc" "pdoc"

# Web Development
pipx_install "Django" "django"
pipx_install "Flask" "flask"
pipx_install "FastAPI" "fastapi"
pipx_install "Streamlit" "streamlit"
pipx_install "Dash" "dash"

# Data Science
pipx_install "Jupyter" "jupyter"
pipx_install "Pandas" "pandas"
pipx_install "NumPy" "numpy"
pipx_install "Matplotlib" "matplotlib"
pipx_install "Seaborn" "seaborn"
pipx_install "SciPy" "scipy"
pipx_install "Scikit-learn" "scikit-learn"

# Machine Learning
pipx_install "TensorFlow" "tensorflow"
pipx_install "PyTorch" "torch"
pipx_install "Keras" "keras"
pipx_install "XGBoost" "xgboost"
pipx_install "LightGBM" "lightgbm"

# DevOps Tools
pipx_install "Ansible" "ansible"
pipx_install "Fabric" "fabric"
pipx_install "Docker Compose" "docker-compose"
pipx_install "AWS CLI" "awscli"
pipx_install "Azure CLI" "azure-cli"
pipx_install "Google Cloud SDK" "google-cloud-sdk"

# Database Tools
pipx_install "SQLAlchemy" "sqlalchemy"
pipx_install "Alembic" "alembic"
pipx_install "PyMongo" "pymongo"
pipx_install "Redis" "redis"

# Utility Tools
pipx_install "Rich" "rich"
pipx_install "Click" "click"
pipx_install "Typer" "typer"
pipx_install "Requests" "requests"
pipx_install "BeautifulSoup" "beautifulsoup4"
pipx_install "Scrapy" "scrapy"
pipx_install "PyYAML" "pyyaml"
pipx_install "Pillow" "pillow"

print_in_green "\n  Python development environment setup complete!\n"
