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

# Install Python 3.11 with specific patch version
pyenv_install "3.11.8" "false"

# Install Python 3.12 with specific patch version
pyenv_install "3.12.2" "true"

# Set Python 3.12 as global
pyenv global 3.12.2
print_result $? "Setting Python 3.12.2 as global"

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

# DevOps Tools
pipx_install "Ansible" "ansible"
pipx_install "Fabric" "fabric"


# Database Tools
pipx_install "Alembic" "alembic"

# Utility Tools
pipx_install "Typer" "typer"
pipx_install "Scrapy" "scrapy"

print_in_green "\n  Python development environment setup complete!\n"
