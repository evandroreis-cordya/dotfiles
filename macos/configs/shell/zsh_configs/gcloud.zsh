#!/bin/zsh
#
# Google Cloud SDK configuration for zsh
# This file contains Google Cloud SDK initialization
#

# Google Cloud SDK (Local installation)
if [ -f '/Applications/google-cloud-sdk/path.zsh.inc' ]; then
    . '/Applications/google-cloud-sdk/path.zsh.inc'
fi

if [ -f '/Applications/google-cloud-sdk/completion.zsh.inc' ]; then
    . '/Applications/google-cloud-sdk/completion.zsh.inc'
fi

# Google Cloud SDK (installed via Homebrew)
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then
    . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
fi

if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then
    . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'
fi

