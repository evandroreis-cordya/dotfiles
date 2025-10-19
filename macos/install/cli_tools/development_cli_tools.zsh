#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

print_in_purple "
   Development CLI Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Version Control Tools
brew_install "Git" "git"
brew_install "GitHub CLI" "gh"
brew_install "Git LFS" "git-lfs"

# Editors and IDEs
brew_install "NeoVim" "neovim"
brew_install "Vim" "vim"

# Database Tools
brew_install "PostgreSQL" "postgresql@14"
brew_install "MySQL" "mysql"
brew_install "MongoDB Community" "mongodb-community"
brew_install "Redis" "redis"

# API Development Tools
brew_install "Postman CLI" "newman"  # Newman for Postman collections
brew_install "HTTPie" "httpie"
brew_install "curl" "curl"

# Build Tools
brew_install "Maven" "maven"
brew_install "Gradle" "gradle"
brew_install "Make" "make"
brew_install "CMake" "cmake"

# Image Processing
brew_install "ImageMagick" "imagemagick"

# Security Tools
brew_install "GPG" "gnupg"
brew_install "OpenSSL" "openssl"

# Package Managers
brew_install "Homebrew" "homebrew"  # Ensure Homebrew is up to date

# Development Utilities
brew_install "mas" "mas"  # Mac App Store command line interface

# Additional tools from dev_tools/devtools.zsh
brew_install "Maven" "maven"
brew_install "Gradle" "gradle"
brew_install "Make" "make"
brew_install "CMake" "cmake"

print_in_green "
  Development CLI tools installation complete!
"
