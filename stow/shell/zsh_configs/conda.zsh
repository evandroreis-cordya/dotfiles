#!/bin/zsh
#
# Conda configuration for zsh
# This file contains Conda initialization
#

# Conda initialization
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Volumes/MACOS/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Volumes/MACOS/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Volumes/MACOS/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Volumes/MACOS/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

