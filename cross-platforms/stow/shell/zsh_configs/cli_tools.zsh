#!/usr/bin/env zsh

# =============================================================================
# CLI Tools Configuration
# =============================================================================
# This file contains configuration for various CLI tools installed via Homebrew
# and other package managers. It includes aliases, functions, and environment
# variables for CLI tools.

# =============================================================================
# Core CLI Tools Configuration
# =============================================================================

# Git Configuration
if command -v git &> /dev/null; then
    # Git aliases
    alias g='git'
    alias ga='git add'
    alias gaa='git add --all'
    alias gap='git add --patch'
    alias gb='git branch'
    alias gba='git branch --all'
    alias gbd='git branch --delete'
    alias gco='git checkout'
    alias gcb='git checkout -b'
    alias gcm='git checkout main'
    alias gd='git diff'
    alias gdc='git diff --cached'
    alias gf='git fetch'
    alias gl='git log'
    alias gla='git log --all'
    alias glg='git log --graph'
    alias glga='git log --graph --all'
    alias gp='git push'
    alias gpl='git pull'
    alias gs='git status'
    alias gst='git stash'
    alias gstp='git stash pop'
    alias gsw='git switch'
    alias gswc='git switch -c'
fi

# GitHub CLI Configuration
if command -v gh &> /dev/null; then
    # GitHub CLI aliases
    alias ghpr='gh pr'
    alias ghprc='gh pr create'
    alias ghprl='gh pr list'
    alias ghprv='gh pr view'
    alias ghiss='gh issue'
    alias ghissc='gh issue create'
    alias ghissl='gh issue list'
    alias ghissv='gh issue view'
    alias ghrepo='gh repo'
    alias ghrepoc='gh repo create'
    alias ghrepoc='gh repo clone'
fi

# =============================================================================
# Text Processing and Search Tools
# =============================================================================

# ripgrep Configuration
if command -v rg &> /dev/null; then
    # ripgrep aliases
    alias rg='rg --smart-case'
    alias rgi='rg --ignore-case'
    alias rgv='rg --vimgrep'
    alias rgf='rg --files'
    alias rgt='rg --type'
fi

# fd Configuration
if command -v fd &> /dev/null; then
    # fd aliases
    alias fd='fd --hidden --exclude .git'
    alias fdi='fd --ignore-case'
    alias fdt='fd --type'
fi

# fzf Configuration
if command -v fzf &> /dev/null; then
    # fzf aliases
    alias fzf='fzf --height 40% --border'
    alias fzfi='fzf --height 40% --border --reverse'

    # fzf functions
    fzf-cd() {
        local dir
        dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
    }

    fzf-history() {
        local cmd
        cmd=$(history | fzf +s +m -e | sed 's/ *[0-9]* *//')
        [ -n "$cmd" ] && eval "$cmd"
    }
fi

# bat Configuration
if command -v bat &> /dev/null; then
    # bat aliases
    alias cat='bat'
    alias bat='bat --style=auto'
    alias batp='bat --plain'
    alias batn='bat --number'
fi

# exa Configuration
if command -v exa &> /dev/null; then
    # exa aliases
    alias ls='exa'
    alias ll='exa -l'
    alias la='exa -la'
    alias lt='exa --tree'
    alias lta='exa --tree --all'
fi

# =============================================================================
# JSON/YAML Processing Tools
# =============================================================================

# jq Configuration
if command -v jq &> /dev/null; then
    # jq aliases
    alias jq='jq --tab'
    alias jqc='jq --compact-output'
    alias jqr='jq --raw-output'
fi

# yq Configuration
if command -v yq &> /dev/null; then
    # yq aliases
    alias yq='yq --indent 2'
    alias yqc='yq --compact-output'
fi

# =============================================================================
# Network Tools
# =============================================================================

# HTTPie Configuration
if command -v http &> /dev/null; then
    # HTTPie aliases
    alias http='http --style=auto'
    alias https='https --style=auto'
    alias httpi='http --interactive'
fi

# curl Configuration
if command -v curl &> /dev/null; then
    # curl aliases
    alias curl='curl --progress-bar'
    alias curli='curl --include'
    alias curlv='curl --verbose'
fi

# =============================================================================
# Cloud CLI Tools Configuration
# =============================================================================

# AWS CLI Configuration
if command -v aws &> /dev/null; then
    # AWS CLI aliases
    alias aws='aws --output table'
    alias awsj='aws --output json'
    alias awsy='aws --output yaml'
    alias awst='aws --output text'
fi

# Google Cloud SDK Configuration
if command -v gcloud &> /dev/null; then
    # gcloud aliases
    alias gcloud='gcloud --format="table"'
    alias gcloudj='gcloud --format="json"'
    alias gcloudy='gcloud --format="yaml"'
fi

# Azure CLI Configuration
if command -v az &> /dev/null; then
    # Azure CLI aliases
    alias az='az --output table'
    alias azj='az --output json'
    alias azy='az --output yaml'
    alias azt='az --output tsv'
fi

# Terraform Configuration
if command -v terraform &> /dev/null; then
    # Terraform aliases
    alias tf='terraform'
    alias tfi='terraform init'
    alias tfp='terraform plan'
    alias tfa='terraform apply'
    alias tfd='terraform destroy'
    alias tff='terraform fmt'
    alias tfv='terraform validate'
fi

# Kubernetes Configuration
if command -v kubectl &> /dev/null; then
    # kubectl aliases
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias ke='kubectl edit'
    alias kdel='kubectl delete'
    alias kex='kubectl exec'
    alias kpf='kubectl port-forward'
fi

# Docker Configuration
if command -v docker &> /dev/null; then
    # Docker aliases
    alias d='docker'
    alias dc='docker-compose'
    alias dcu='docker-compose up'
    alias dcd='docker-compose down'
    alias dcb='docker-compose build'
    alias dcr='docker-compose run'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dr='docker run'
    alias de='docker exec'
fi

# =============================================================================
# System Monitoring Tools
# =============================================================================

# htop Configuration
if command -v htop &> /dev/null; then
    # htop aliases
    alias htop='htop -d 2'
fi

# btop Configuration
if command -v btop &> /dev/null; then
    # btop aliases
    alias btop='btop --preset 0'
fi

# =============================================================================
# Terminal Multiplexer
# =============================================================================

# tmux Configuration
if command -v tmux &> /dev/null; then
    # tmux aliases
    alias t='tmux'
    alias ta='tmux attach'
    alias tn='tmux new-session'
    alias tl='tmux list-sessions'
    alias tk='tmux kill-session'
fi

# =============================================================================
# Utility Functions
# =============================================================================

# Function to search in command history
search-history() {
    if command -v fzf &> /dev/null; then
        history | fzf +s +m -e | sed 's/ *[0-9]* *//'
    else
        history | grep "$1"
    fi
}

# Function to find and open files
find-and-open() {
    if command -v fzf &> /dev/null; then
        local file
        file=$(find . -type f | fzf +m)
        [ -n "$file" ] && ${EDITOR:-vim} "$file"
    else
        echo "fzf is required for this function"
    fi
}

# Function to search in files
search-in-files() {
    if command -v rg &> /dev/null; then
        rg "$1" --smart-case
    elif command -v grep &> /dev/null; then
        grep -r "$1" .
    else
        echo "ripgrep or grep is required for this function"
    fi
}

# Function to show disk usage
disk-usage() {
    if command -v duf &> /dev/null; then
        duf
    elif command -v df &> /dev/null; then
        df -h
    else
        echo "duf or df is required for this function"
    fi
}

# Function to show directory tree
show-tree() {
    if command -v exa &> /dev/null; then
        exa --tree --all
    elif command -v tree &> /dev/null; then
        tree -a
    else
        echo "exa or tree is required for this function"
    fi
}

# =============================================================================
# Environment Variables
# =============================================================================

# Set default editor
export EDITOR=${EDITOR:-vim}
export VISUAL=${VISUAL:-vim}

# Set pager
export PAGER=${PAGER:-less}

# Set less options
export LESS='-R -X -F'

# =============================================================================
# Completion
# =============================================================================

# Enable completion for various CLI tools
if command -v gh &> /dev/null; then
    # GitHub CLI completion
    eval "$(gh completion --shell zsh)"
fi

if command -v aws &> /dev/null; then
    # AWS CLI completion
    complete -C aws_completer aws
fi

if command -v gcloud &> /dev/null; then
    # Google Cloud SDK completion
    source "$(gcloud info --format='value(installation.sdk_root)')/completion.zsh.inc"
fi

if command -v kubectl &> /dev/null; then
    # kubectl completion
    source <(kubectl completion zsh)
fi

if command -v terraform &> /dev/null; then
    # Terraform completion
    complete -o nospace -C terraform terraform
fi

# =============================================================================
# Load Order Information
# =============================================================================
# This file should be loaded after:
# - 00_load_order.zsh (load order management)
# - ohmyzsh.zsh (Oh My Zsh framework)
# - exports.zsh (general environment variables)
# - homebrew.zsh (Homebrew package manager)
#
# Load order: 24 (after most other tools are configured)
# Dependencies: Various CLI tools installed via Homebrew
# Conflicts: None known
