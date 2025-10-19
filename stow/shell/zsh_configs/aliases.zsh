#!/bin/zsh
#
# General aliases for zsh
# This file contains common aliases not specific to any language or tool
#

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias cdo="cd /Volumes/MACOS"

# List directory contents
alias ls="ls -G"
alias ll="ls -la"
alias la="ls -a"
alias l="ls -CF"

# File operations
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias mkdir="mkdir -p"
alias cf="copyfile"
alias cpf="copypath"
alias ex="extract"

# Git shortcuts
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gbr="git branch"  # Changed from 'gb' to avoid conflict with go.zsh (go build)
alias glog="git log --oneline --decorate --graph"

# Python/development
# Note: py and pip aliases are defined in python.zsh
alias yt="youtube-transcript"

# Docker shortcuts
# Note: Docker aliases (dc, dps, di) are defined in docker.zsh
# Keeping these here as fallback if docker.zsh is not loaded

# Editor
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# System
alias ip="curl -s https://ipinfo.io/ip"
alias localip="ipconfig getifaddr en0"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias update="brew update && brew upgrade && brew cleanup"
alias path="echo $PATH | tr ':' '\n'"

# Utility
alias h="history"
alias jbs="jobs -l"  # Changed from 'j' to avoid conflict with java.zsh
alias dud="du -d 1 -h"
alias duf="du -sh *"
alias ff="find . -type f -name"
alias fd="find . -type d -name"
alias webs="web-search"
alias sbl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"


