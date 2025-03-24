#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Mouse\n\n"

# Mouse Speed
execute "defaults write -g com.apple.mouse.scaling -float 2.5" \
    "Set mouse scaling (speed)"

execute "defaults write -g com.apple.mouse.doubleClickThreshold -float 0.5" \
    "Set double-click speed"

# Mouse Tracking
execute "defaults write -g com.apple.mouse.trackingSpeed -float 5.0" \
    "Set tracking speed"

execute "defaults write -g AppleEnableMouseSwipeNavigateWithScrolls -bool true" \
    "Enable swipe between pages"

# Mouse Scrolling
execute "defaults write -g com.apple.scrollwheel.scaling -float 0.7" \
    "Set scroll wheel speed"

execute "defaults write -g com.apple.swipescrolldirection -bool false" \
    "Disable natural scrolling for mouse"

# Mouse Secondary Click
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton" \
    "Enable secondary click"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonDivision 55" \
    "Set click pressure threshold"

# Mouse Gestures
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseMomentumScroll -bool true" \
    "Enable momentum scrolling"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture -bool true" \
    "Enable smart zoom"

# Mouse Button Configuration
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string 'TwoButton'" \
    "Configure mouse for two buttons"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseLeftClick -int 1" \
    "Configure left click"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseRightClick -int 2" \
    "Configure right click"

# Mouse Acceleration
execute "defaults write .GlobalPreferences com.apple.mouse.scaling -float 1.5" \
    "Set mouse acceleration"

execute "defaults write .GlobalPreferences com.apple.mouse.doubleClickThreshold -float 0.5" \
    "Set double-click threshold"

# Mouse Button Assignments
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string 'OneButton'" \
    "Set primary mouse button"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture -bool true" \
    "Enable double-tap gesture"

# Mouse Pointer
execute "defaults write NSGlobalDomain AppleCursorSize -float 1.5" \
    "Set cursor size"

execute "defaults write com.apple.universalaccess mouseDriverCursorSize -float 1.5" \
    "Set universal cursor size"

# Mouse Focus
execute "defaults write NSGlobalDomain AppleMouseButtonClickBehavior -int 1" \
    "Click in the scrollbar to jump to the spot that's clicked"

execute "defaults write com.apple.AppleMultitouchMouse MouseVerticalScroll -bool true" \
    "Enable vertical scrolling"

execute "defaults write com.apple.AppleMultitouchMouse MouseHorizontalScroll -bool true" \
    "Enable horizontal scrolling"

# Mouse Battery
execute "defaults write com.apple.menuextra.battery ShowPercent -bool true" \
    "Show mouse battery percentage"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Max (editable)' 80" \
    "Set Bluetooth audio quality"

# Mouse Menu Bar
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/Bluetooth.menu'" \
    "Show Bluetooth in menu bar"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall cfprefsd" \
    "Restart preferences daemon"
