#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Dashboard\n\n"

# General Settings
execute "defaults write com.apple.dashboard mcx-disabled -bool true" \
    "Disable Dashboard"

execute "defaults write com.apple.dashboard enabled-state -int 1" \
    "Set Dashboard state to disabled"

execute "defaults write com.apple.dashboard devmode -bool false" \
    "Disable Dashboard development mode"

# Widget Settings
execute "defaults write com.apple.dashboard MDCloseOnLogout -bool true" \
    "Close Dashboard on logout"

execute "defaults write com.apple.dashboard EnabledState -int 1" \
    "Set Dashboard enabled state"

execute "defaults write com.apple.dashboard dashboard-enabled -bool false" \
    "Disable Dashboard system-wide"

# Layer Settings
execute "defaults write com.apple.dashboard db-enabled-state -int 1" \
    "Set Dashboard layer state"

execute "defaults write com.apple.dock dashboard-in-overlay -bool true" \
    "Set Dashboard to overlay mode"

# Note: Dashboard is managed by Dock process, so we need to restart it
killall "Dock" &> /dev/null
