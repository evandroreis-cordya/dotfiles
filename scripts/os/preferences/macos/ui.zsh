#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   UI & UX\n\n"

# System Appearance
execute "defaults write -g AppleInterfaceStyle -string 'Dark'" \
    "Set appearance to Dark mode"

execute "defaults write -g AppleAquaColorVariant -int 1" \
    "Set system accent color to Blue"

# Menu Bar
execute "defaults write -g _HIHideMenuBar -bool false" \
    "Always show menu bar"

execute "defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  h:mm a'" \
    "Set menu bar clock format"

# Dock
execute "defaults write com.apple.dock orientation -string 'bottom'" \
    "Set Dock position to bottom"

execute "defaults write com.apple.dock tilesize -int 48" \
    "Set Dock icon size"

execute "defaults write com.apple.dock magnification -bool true" \
    "Enable Dock magnification"

execute "defaults write com.apple.dock largesize -int 64" \
    "Set Dock magnification size"

# Windows
execute "defaults write -g NSWindowResizeTime -float 0.001" \
    "Speed up window resize animations"

execute "defaults write com.apple.universalaccess reduceTransparency -bool false" \
    "Enable transparency effects"

execute "defaults write -g NSAutomaticWindowAnimationsEnabled -bool true" \
    "Enable window opening and closing animations"

# Finder
execute "defaults write com.apple.finder ShowPathbar -bool true" \
    "Show path bar in Finder"

execute "defaults write com.apple.finder ShowStatusBar -bool true" \
    "Show status bar in Finder"

execute "defaults write com.apple.finder _FXShowPosixPathInTitle -bool true" \
    "Show full POSIX path in Finder window title"

execute "defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'" \
    "Set default Finder search scope to current folder"

# Mission Control
execute "defaults write com.apple.dock expose-animation-duration -float 0.1" \
    "Speed up Mission Control animations"

execute "defaults write com.apple.dock showMissionControlGestureEnabled -bool true" \
    "Enable Mission Control gesture"

# Screenshots
execute "defaults write com.apple.screencapture location -string '$HOME/Desktop'" \
    "Save screenshots to Desktop"

execute "defaults write com.apple.screencapture type -string 'png'" \
    "Save screenshots as PNG files"

execute "defaults write com.apple.screencapture disable-shadow -bool true" \
    "Disable screenshot shadows"

# Other UI improvements
execute "defaults write -g NSNavPanelExpandedStateForSaveMode -bool true" \
    "Expand save panel by default"

execute "defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true" \
    "Expand save panel by default (alternate)"

execute "defaults write -g PMPrintingExpandedStateForPrint -bool true" \
    "Expand print panel by default"

execute "defaults write -g PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print panel by default (alternate)"

# Restart UI services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall Finder" \
    "Restart Finder"

execute "killall Dock" \
    "Restart Dock"
