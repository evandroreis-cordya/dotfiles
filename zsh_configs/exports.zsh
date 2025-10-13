#!/bin/zsh
#
# General exports for zsh
# This file contains common environment variables not specific to any language or tool
#

# Language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DIRENV_LOG_FORMAT=""
export DIRENV_WARN_TIMEOUT="0s"


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='cursor'
else
   export EDITOR='code'
fi

# Man pages
export MANPATH="/usr/local/man:$MANPATH"

# Ollama
export OLLAMA_HOST="0.0.0.0:11434"
export OLLAMA_MODELS_DIR="/Volumes/DEVS/models/ollama"

# VIRTUAL_ENV should NEVER be set globally - it's managed by venv activation
# export VIRTUAL_ENV="/Volumes/DEVS/venvs"  # DISABLED: This breaks virtual environment management!

# But we DO want to disable the default venv prompt modification (let the theme handle it)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL=ignoreboth:erasedups

# Less configuration
export LESS="-R"
export LESSCHARSET="utf-8"

# Set terminal colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
