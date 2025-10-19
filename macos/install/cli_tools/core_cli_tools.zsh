#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

print_in_purple "
   Core CLI Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Essential CLI Tools
brew_install "Git" "git"
brew_install "GitHub CLI" "gh"
brew_install "Git LFS" "git-lfs"

# Text Processing and Search
brew_install "ripgrep" "ripgrep"  # Fast text search
brew_install "fd" "fd"  # Alternative to find
brew_install "The Silver Searcher" "the_silver_searcher"  # Code search
brew_install "fzf" "fzf"  # Fuzzy finder
brew_install "bat" "bat"  # Better cat
brew_install "exa" "exa"  # Better ls
brew_install "tree" "tree"  # Directory tree

# JSON/YAML Processing
brew_install "jq" "jq"  # JSON processor
brew_install "yq" "yq"  # YAML processor

# Network Tools
brew_install "curl" "curl"
brew_install "wget" "wget"
brew_install "HTTPie" "httpie"  # Better curl
brew_install "htop" "htop"  # Process monitor

# Compression and Archiving
brew_install "unzip" "unzip"
brew_install "zip" "zip"
brew_install "tar" "tar"

# Terminal Multiplexer
brew_install "tmux" "tmux"

# Documentation
brew_install "tldr" "tldr"  # Simplified man pages

# Additional utilities from daily_tools
brew_install "mas" "mas"  # Mac App Store command line interface

print_in_green "
  Core CLI tools installation complete!
"
