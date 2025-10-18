#!/bin/zsh
#
# Homebrew configuration for zsh
# This file contains all Homebrew-related configurations
#

# Homebrew environment setup
if [[ "$(uname -m)" == "arm64" ]]; then
    # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Homebrew aliases
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewls="brew list"
alias brewi="brew install"
alias brewci="brew install --cask"
alias brewrm="brew uninstall"
alias brewsr="brew search"
alias brewinfo="brew info"
alias brewdeps="brew deps --tree --installed"
alias brewdoc="brew doctor"
alias brewout="brew outdated"
