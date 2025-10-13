#!/bin/zsh
#
# Oh My Zsh configuration
# This file contains all Oh My Zsh related settings and plugins
#

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH_THEME="cordya"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto        # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Explanations can  be found at https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins

plugins=(
    # Essential utilities
    1password
    aliases
    brew
    colored-man-pages
    command-not-found
    copyfile
    copypath
    cp
    extract
    jsontools
    macos
    man
    rsync
    safe-paste
    sudo
    thefuck
    tldr
    web-search

    # Cloud providers
    aws
    azure
    gcloud

    # Docker & Kubernetes
    docker
    docker-compose
    helm
    kubectl
    kubectx
    minikube

    # Git plugins
    gh
    git
    git-auto-fetch
    git-extras
    github
    gitignore

    # Programming languages
    golang
    node
    npm
    nvm
    pip
    pipenv
    pyenv
    python
    ruby
    rust

    # Directory & environment
    #direnv
    dirhistory
    z

    # Security
    keychain
    ssh-agent

    # Development tools
    iterm2
    terraform
    vscode
    xcode
    yarn

    # Python environments
    conda-env
    virtualenv
    #uv

    # History & completions (load last for best performance)
    #history-substring-search
    zsh-syntax-highlighting
    zsh-autosuggestions
    #zsh-completions
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

