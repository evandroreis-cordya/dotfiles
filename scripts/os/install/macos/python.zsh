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

# Initialize pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Install latest Python versions
print_in_purple "\n   Installing Python Versions\n\n"
pyenv install 3.11
pyenv install 3.12
pyenv global 3.12

# Install Poetry for dependency management
curl -sSL https://install.python-poetry.org | python3 -

# Install pipx for isolated application installation
brew_install "pipx" "pipx"
pipx ensurepath

# Install global development tools
print_in_purple "\n   Installing Development Tools\n\n"

# Package Management
pipx install pip-tools
pipx install poetry

# Development Tools
pipx install black
pipx install isort
pipx install pylint
pipx install mypy
pipx install flake8
pipx install autopep8
pipx install yapf

# Testing Tools
pipx install pytest
pipx install pytest-cov
pipx install tox
pipx install coverage

# Documentation Tools
pipx install sphinx
pipx install mkdocs
pipx install pdoc3

# Web Development
pipx install flask
pipx install django
pipx install fastapi
pipx install uvicorn

# Data Science Tools
pipx install jupyter
pipx install jupyterlab
pipx install notebook

# CLI Tools
pipx install click
pipx install typer
pipx install rich

# Optional Development Tools
# Uncomment if needed
# pipx install streamlit
# pipx install dash
# pipx install gradio
# pipx install prefect
# pipx install great-expectations
# pipx install dvc

# Configure pip
pip config set global.require-virtualenv true
pip config set global.timeout 100

# Create default virtual environment
if [[ ! -d "$HOME/.venv" ]]; then
    python -m venv "$HOME/.venv"
    source "$HOME/.venv/bin/activate"
    
    # Install basic packages in default environment
    pip install --upgrade pip
    pip install wheel
    pip install setuptools
    pip install virtualenv
    
    deactivate
fi

# Add virtualenv wrapper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

# Python virtual environment functions
venv() {
    if [[ -n "$1" ]]; then
        python -m venv "$1"
        source "$1/bin/activate"
    else
        source "$HOME/.venv/bin/activate"
    fi
}

mkvenv() {
    python -m venv .venv
    source .venv/bin/activate
    pip install --upgrade pip wheel setuptools
}
EOL

print_result $? "Python development environment"
