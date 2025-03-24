#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Git Tools\n\n"

# Core Git Tools
brew_install "Git" "git"
brew_install "Git LFS" "git-lfs"
brew_install "GitHub CLI" "gh"

# Git GUI Clients
brew_install "Sourcetree" "sourcetree" "--cask"
brew_install "GitKraken" "gitkraken" "--cask"
brew_install "Fork" "fork" "--cask"

# Git Utilities
brew_install "Git Flow" "git-flow"
brew_install "Git Delta" "git-delta"
brew_install "Git Filter Repo" "git-filter-repo"
brew_install "Git GUI" "git-gui"

# Code Review Tools
brew_install "Diff So Fancy" "diff-so-fancy"
brew_install "Git Interactive Rebase Tool" "git-interactive-rebase-tool"

# Git Hooks and Automation
brew_install "Pre-commit" "pre-commit"
brew_install "Husky" "husky"

# Git Security
brew_install "Git Secrets" "git-secrets"
brew_install "Git Crypt" "git-crypt"

# Optional Git Tools
# Uncomment if needed
# brew_install "Git Cola" "git-cola"
# brew_install "Git Absorb" "git-absorb"
# brew_install "Git Bug" "git-bug"
# brew_install "Git Town" "git-town"
# brew_install "Git Plus" "git-plus"

# Configure Git Credentials Helper
execute "git config --global credential.helper osxkeychain" \
    "Configure Git credential helper"

# Configure Git to use SSH instead of HTTPS
execute "git config --global url.ssh://git@github.com/.insteadOf https://github.com/" \
    "Configure Git to use SSH for GitHub"
