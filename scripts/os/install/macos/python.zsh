#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Python Development Tools\n\n"

# Install Python via Homebrew
brew_install "Python" "python"
brew_install "Python@3.11" "python@3.11"

# Install pyenv for Python version management
brew_install "pyenv" "pyenv"
brew_install "pyenv-virtualenv" "pyenv-virtualenv"

# Add pyenv to shell configuration if not already added
if ! grep -q "pyenv init" ~/.zshrc; then
    execute "echo 'export PYENV_ROOT=\"\$HOME/.pyenv\"' >> ~/.zshrc" "Add PYENV_ROOT to .zshrc"
    execute "echo 'export PATH=\"\$PYENV_ROOT/bin:\$PATH\"' >> ~/.zshrc" "Add pyenv to PATH in .zshrc"
    execute "echo 'eval \"\$(pyenv init --path)\"' >> ~/.zshrc" "Add pyenv init to .zshrc"
    execute "echo 'eval \"\$(pyenv virtualenv-init -)\"' >> ~/.zshrc" "Add pyenv virtualenv-init to .zshrc"
fi

# Install Python versions
print_in_purple "\n   Installing Python Versions\n\n"

# Install Python 3.11
pyenv_install "Python 3.11" "3.11"

# Install Python 3.12
pyenv_install "Python 3.12" "3.12"

# Set Python 3.12 as global
print_in_yellow "  [ ] Setting Python 3.12 as global"
pyenv global 3.12
print_result $? "Setting Python 3.12 as global"

# Install Poetry for dependency management
poetry_install

# Install pipx for isolated application installation
brew_install "pipx" "pipx"
run_command "pipx ensurepath" "pipx path setup"

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

# Create a data science virtual environment
print_in_purple "\n   Setting up Data Science Environment\n\n"

# Create a dedicated virtual environment for data science packages
DATASCIENCE_ENV="datascience"
print_in_yellow "  [ ] Creating Data Science virtual environment"
pyenv virtualenv 3.12 $DATASCIENCE_ENV 2>/dev/null || true
print_result $? "Creating Data Science virtual environment"

# Function to install packages in the data science environment
pip_install_in_env() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"
    
    print_in_yellow "  [ ] $PACKAGE_READABLE_NAME"
    PYENV_VERSION=$DATASCIENCE_ENV pip install $PACKAGE -U &>/dev/null
    print_result $? "$PACKAGE_READABLE_NAME"
}

# Data Science packages
pip_install_in_env "Jupyter" "jupyter"
pip_install_in_env "Pandas" "pandas"
pip_install_in_env "NumPy" "numpy"
pip_install_in_env "Matplotlib" "matplotlib"
pip_install_in_env "Seaborn" "seaborn"
pip_install_in_env "SciPy" "scipy"
pip_install_in_env "Scikit-learn" "scikit-learn"

# Machine Learning packages
pip_install_in_env "TensorFlow" "tensorflow"
pip_install_in_env "PyTorch" "torch torchvision torchaudio"
pip_install_in_env "Keras" "keras"
pip_install_in_env "XGBoost" "xgboost"
pip_install_in_env "LightGBM" "lightgbm"

# DevOps Tools
pipx_install "Ansible" "ansible"
pipx_install "Fabric" "fabric"
pip_install_in_env "Docker Compose" "docker-compose"
pipx_install "AWS CLI" "awscli"
pipx_install "Azure CLI" "azure-cli" "--include-deps"
pip_install_in_env "Google Cloud SDK" "google-cloud-sdk"

# Database Tools
pip_install_in_env "SQLAlchemy" "sqlalchemy"
pipx_install "Alembic" "alembic"
pip_install_in_env "PyMongo" "pymongo"
pip_install_in_env "Redis" "redis"

# Utility Tools
pip_install_in_env "Rich" "rich"
pip_install_in_env "Click" "click"
pipx_install "Typer" "typer"
pip_install_in_env "Requests" "requests"
pip_install_in_env "BeautifulSoup" "beautifulsoup4"
pipx_install "Scrapy" "scrapy"
pip_install_in_env "PyYAML" "pyyaml"
pip_install_in_env "Pillow" "pillow"

# Create activation script for data science environment
ACTIVATE_SCRIPT="$HOME/.jarvistoolset/scripts/activate_datascience.sh"
print_in_yellow "  [ ] Creating activation script for Data Science environment"
mkdir -p "$(dirname "$ACTIVATE_SCRIPT")" 2>/dev/null || true
cat > "$ACTIVATE_SCRIPT" << EOL
#!/bin/bash
# Activate the Data Science Python environment
echo "Activating Data Science Python environment..."
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
pyenv activate $DATASCIENCE_ENV
echo "Data Science environment activated. Run 'pyenv deactivate' to exit."
EOL
chmod +x "$ACTIVATE_SCRIPT"
print_success "Created activation script: $ACTIVATE_SCRIPT"

print_in_green "\n  Python development environment setup complete!\n"
print_in_green "  To activate the Data Science environment, run: source $ACTIVATE_SCRIPT\n"
