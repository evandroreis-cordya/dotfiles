#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development Tools\n\n"

# Development environments and IDEs
brew_install "Visual Studio Code" "visual-studio-code" "--cask"
brew_install "Android Studio" "android-studio" "--cask"
brew_install "iTerm2" "iterm2" "--cask"
brew_install "Docker" "docker" "--cask"

# Development tools
brew_install "Git" "git"
brew_install "GitHub CLI" "gh"
brew_install "AWS CLI" "awscli"
brew_install "Azure CLI" "azure-cli"
brew_install "Terraform" "terraform"
brew_install "kubectl" "kubernetes-cli"

# Database tools
brew_install "PostgreSQL" "postgresql@14"
brew_install "MongoDB" "mongodb-community"
brew_install "Redis" "redis"

# API Development
brew_install "Postman" "postman" "--cask"
brew_install "HTTPie" "httpie"

# Image tools
brew_install "ImageMagick" "imagemagick"

# Package managers and build tools
brew_install "Maven" "maven"
brew_install "Gradle" "gradle"

# Programming languages
brew_install "Go" "go"
brew_install "Python" "python@3.11"
brew_install "Ruby" "ruby"
brew_install "Rust" "rust"

# Shell tools
brew_install "tmux" "tmux"
brew_install "The Silver Searcher" "the_silver_searcher"
brew_install "fzf" "fzf"
brew_install "jq" "jq"
brew_install "yq" "yq"

# Restart the shell to apply changes
execute "exec zsh" \
    "Restart shell to apply changes"
