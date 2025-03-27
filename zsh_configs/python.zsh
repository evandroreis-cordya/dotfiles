#!/bin/zsh
#
# Python configuration for zsh
# This file contains all Python-related configurations
#

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

# Python aliases
alias py="python"
alias py3="python3"
alias pip-upgrade="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U"
alias pip3-upgrade="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"

# Virtual environment configuration
if [ -d "$VIRTUAL_ENV" ]; then
  export PATH="$VIRTUAL_ENV/bin:$PATH"
fi
