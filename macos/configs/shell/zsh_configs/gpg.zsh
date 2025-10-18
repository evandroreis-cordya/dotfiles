#!/bin/zsh
#
# GPG configuration for zsh
# This file contains all GPG-related configurations
#

# Set GPG TTY
export GPG_TTY=$(tty)

# GPG aliases
alias gpg-list="gpg --list-keys"
alias gpg-list-secret="gpg --list-secret-keys"
alias gpg-refresh="gpg --refresh-keys"

# GPG functions
gpg-export() {
    if [ $# -ne 1 ]; then
        echo "Usage: gpg-export <key-id>"
        return 1
    fi
    
    local key_id=$1
    gpg --armor --export "$key_id"
}

gpg-export-secret() {
    if [ $# -ne 1 ]; then
        echo "Usage: gpg-export-secret <key-id>"
        return 1
    fi
    
    local key_id=$1
    gpg --armor --export-secret-key "$key_id"
}

gpg-import() {
    if [ $# -ne 1 ]; then
        echo "Usage: gpg-import <key-file>"
        return 1
    fi
    
    local key_file=$1
    gpg --import "$key_file"
}
