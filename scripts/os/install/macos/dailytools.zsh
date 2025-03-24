#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Daily Tools\n\n"

# System Utilities
brew install --cask appcleaner
brew install --cask rectangle  # Modern alternative to Spectacle
brew install --cask spectacle

# Cloud Storage
brew install --cask dropbox
brew install --cask google-drive

# Security Tools
brew install --cask veracrypt
brew install --cask 1password

# Development Tools
brew install --cask powershell
brew install --cask iterm2

# Media Tools
brew install --cask vlc
brew install --cask smart-converter

# Communication
brew install --cask slack
brew install --cask zoom

# Optional Tools
# Uncomment if needed
# brew install --cask teamviewer
# brew install --cask anydesk
# brew install --cask notion
# brew install --cask microsoft-teams
