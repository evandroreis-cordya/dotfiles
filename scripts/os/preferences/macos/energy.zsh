#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Energy Saver\n\n"

# Battery Settings
execute "sudo pmset -b displaysleep 5" \
    "Set display sleep to 5 minutes on battery"

execute "sudo pmset -b sleep 15" \
    "Set system sleep to 15 minutes on battery"

execute "sudo pmset -b disksleep 10" \
    "Set disk sleep to 10 minutes on battery"

execute "sudo pmset -b lessbright 1" \
    "Slightly dim the display on battery"

execute "sudo pmset -b lidwake 1" \
    "Wake when lid is opened on battery"

execute "sudo pmset -b autopoweroff 1" \
    "Enable automatic power off on battery"

execute "sudo pmset -b standby 1" \
    "Enable standby mode on battery"

execute "sudo pmset -b standbydelay 86400" \
    "Set standby delay to 24 hours on battery"

# Power Adapter Settings
execute "sudo pmset -c displaysleep 15" \
    "Set display sleep to 15 minutes on power adapter"

execute "sudo pmset -c sleep 0" \
    "Never sleep when connected to power adapter"

execute "sudo pmset -c disksleep 0" \
    "Never sleep disks when connected to power adapter"

execute "sudo pmset -c lessbright 0" \
    "Don't dim display on power adapter"

execute "sudo pmset -c lidwake 1" \
    "Wake when lid is opened on power adapter"

execute "sudo pmset -c autopoweroff 0" \
    "Disable automatic power off on power adapter"

execute "sudo pmset -c standby 1" \
    "Enable standby mode on power adapter"

execute "sudo pmset -c standbydelay 86400" \
    "Set standby delay to 24 hours on power adapter"

# General Settings
execute "sudo pmset -a hibernatemode 3" \
    "Enable safe sleep mode"

execute "sudo pmset -a powernap 1" \
    "Enable Power Nap"

execute "sudo pmset -a tcpkeepalive 1" \
    "Enable TCP keep alive"

execute "sudo pmset -a womp 1" \
    "Enable wake on network access"

execute "sudo pmset -a networkoversleep 0" \
    "Disable network connection wake"

# Battery Health
execute "sudo pmset -a destroyfvkeyonstandby 1" \
    "Destroy FileVault key on standby"

execute "sudo pmset -a highstandbythreshold 50" \
    "Set high standby threshold to 50%"

execute "sudo pmset -a proximitywake 0" \
    "Disable wake on iPhone proximity"

# Display Settings
execute "sudo pmset -a halfdim 1" \
    "Enable display dimming before sleep"

# Power Button Settings
execute "defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool false" \
    "Disable power button instant sleep"

# Menu Bar
execute "defaults write com.apple.menuextra.battery ShowPercent -bool true" \
    "Show battery percentage in menu bar"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"
