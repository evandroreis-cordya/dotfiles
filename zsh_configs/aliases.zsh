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

# Git shortcuts
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --decorate --graph"

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
alias j="jobs -l"
alias dud="du -d 1 -h"
alias duf="du -sh *"
alias ff="find . -type f -name"
alias fd="find . -type d -name"
