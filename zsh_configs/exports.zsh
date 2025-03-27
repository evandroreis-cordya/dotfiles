#!/bin/zsh
#
# General exports for zsh
# This file contains common environment variables not specific to any language or tool
#

# Language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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
export OLLAMA_MODELS_DIR="/Volumes/MACOS16/.ollama/models"
export VIRTUAL_ENV="/Volumes/MACOS16/venvs"

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
