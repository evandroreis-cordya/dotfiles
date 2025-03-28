#!/bin/zsh
#
# IPFS configuration for zsh
# This file contains all IPFS-related configurations
#

# IPFS aliases
alias ipfs-start="ipfs daemon &"
alias ipfs-stop="pkill -f ipfs"
alias ipfs-status="pgrep -l ipfs"
alias ipfs-ls="ipfs ls"
alias ipfs-peers="ipfs swarm peers"
alias ipfs-id="ipfs id"
alias ipfs-cat="ipfs cat"
alias ipfs-add="ipfs add"
alias ipfs-pin="ipfs pin add"
alias ipfs-unpin="ipfs pin rm"

# IPFS functions
ipfs-init() {
    if [ -d "$HOME/.ipfs" ]; then
        echo "IPFS is already initialized"
        return 0
    fi
    
    ipfs init
    echo "IPFS initialized successfully"
}

ipfs-publish() {
    if [ $# -lt 1 ]; then
        echo "Usage: ipfs-publish <file-or-directory>"
        return 1
    fi
    
    local target=$1
    local hash=$(ipfs add -Q -r "$target")
    
    if [ -n "$hash" ]; then
        ipfs name publish "$hash"
        echo "Published $target to IPNS"
        echo "Access via: https://gateway.ipfs.io/ipns/$(ipfs key list -l | grep "self" | awk '{print $2}')"
    else
        echo "Failed to add $target to IPFS"
        return 1
    fi
}

ipfs-get() {
    if [ $# -lt 1 ]; then
        echo "Usage: ipfs-get <hash> [output-dir]"
        return 1
    fi
    
    local hash=$1
    local output_dir=${2:-.}
    
    ipfs get "$hash" -o "$output_dir"
    echo "Downloaded $hash to $output_dir"
}
