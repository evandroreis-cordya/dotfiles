#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Mission Control\n\n"

# Mission Control
execute "defaults write com.apple.dock expose-animation-duration -float 0.1" \
    "Speed up Mission Control animations"

execute "defaults write com.apple.dock showMissionControlGestureEnabled -bool true" \
    "Enable Mission Control gesture"

execute "defaults write com.apple.dock missioncontrol-animation-duration -float 0.1" \
    "Set Mission Control animation duration"

# Hot Corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# 14: Quick Note

# Top left screen corner
execute "defaults write com.apple.dock wvous-tl-corner -int 2" \
    "Set top left hot corner to Mission Control"

execute "defaults write com.apple.dock wvous-tl-modifier -int 0" \
    "No modifier key for top left hot corner"

# Top right screen corner
execute "defaults write com.apple.dock wvous-tr-corner -int 4" \
    "Set top right hot corner to Desktop"

execute "defaults write com.apple.dock wvous-tr-modifier -int 0" \
    "No modifier key for top right hot corner"

# Bottom left screen corner
execute "defaults write com.apple.dock wvous-bl-corner -int 11" \
    "Set bottom left hot corner to Launchpad"

execute "defaults write com.apple.dock wvous-bl-modifier -int 0" \
    "No modifier key for bottom left hot corner"

# Bottom right screen corner
execute "defaults write com.apple.dock wvous-br-corner -int 13" \
    "Set bottom right hot corner to Lock Screen"

execute "defaults write com.apple.dock wvous-br-modifier -int 0" \
    "No modifier key for bottom right hot corner"

# Spaces
execute "defaults write com.apple.dock mru-spaces -bool false" \
    "Don't automatically rearrange Spaces based on most recent use"

execute "defaults write com.apple.dock expose-group-by-app -bool false" \
    "Don't group windows by application in Mission Control"

execute "defaults write com.apple.dock expose-group-apps -bool false" \
    "Disable grouping of windows by application"

# Dashboard
execute "defaults write com.apple.dock dashboard-in-overlay -bool true" \
    "Don't show Dashboard as a Space"

execute "defaults write com.apple.dashboard mcx-disabled -bool true" \
    "Disable Dashboard"

# App Exposé
execute "defaults write com.apple.dock showAppExposeGestureEnabled -bool true" \
    "Enable App Exposé gesture"

# Application windows
execute "defaults write com.apple.dock expose-animation-duration -float 0.1" \
    "Speed up window animations"

# Keyboard and Mouse Shortcuts
execute "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 32 '
<dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
        <key>parameters</key>
        <array>
            <integer>65535</integer>
            <integer>126</integer>
            <integer>8650752</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'" \
    "Set Mission Control to Control + Up Arrow"

execute "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 33 '
<dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
        <key>parameters</key>
        <array>
            <integer>65535</integer>
            <integer>125</integer>
            <integer>8650752</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'" \
    "Set Application windows to Control + Down Arrow"

# Restart Dock
execute "killall Dock" \
    "Restart Dock"
