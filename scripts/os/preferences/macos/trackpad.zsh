#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Trackpad\n\n"

# Enable tap to click
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1 && \
         defaults write -g com.apple.mouse.tapBehavior -int 1 && \
         defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1" \
    "Enable tap to click"

# Configure right-click behavior
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1 && \
         defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true && \
         defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0" \
    "Map 'click or tap with two fingers' to secondary click"

# Enable three finger drag
execute "defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true && \
         defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true" \
    "Enable three finger drag"

# Configure tracking speed
execute "defaults write -g com.apple.trackpad.scaling -float 2.5" \
    "Set tracking speed"

# Enable force click and haptic feedback
execute "defaults write -g com.apple.trackpad.forceClick -bool true" \
    "Enable force click and haptic feedback"

# Configure swipe between pages
execute "defaults write -g AppleEnableSwipeNavigateWithScrolls -bool true" \
    "Enable swipe between pages"

# Configure App Exposé swipe down
execute "defaults write com.apple.dock showAppExposeGestureEnabled -bool true" \
    "Enable App Exposé swipe down gesture"

# Configure Mission Control gesture
execute "defaults write com.apple.dock showMissionControlGestureEnabled -bool true" \
    "Enable Mission Control gesture"

# Configure natural scrolling
execute "defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true" \
    "Enable natural scrolling"

# Configure momentum scrolling
execute "defaults write NSGlobalDomain AppleMomentumScrollSupported -bool true" \
    "Enable momentum scrolling"

# Configure zoom gestures
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true" \
    "Enable pinch to zoom"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool true" \
    "Enable smart zoom"

# Configure rotation gesture
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true" \
    "Enable rotate gesture"

# Configure notification center gesture
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3" \
    "Enable notification center gesture"

# Configure launchpad gesture
execute "defaults write com.apple.dock showLaunchpadGestureEnabled -bool true" \
    "Enable launchpad gesture"

# Configure show desktop gesture
execute "defaults write com.apple.dock showDesktopGestureEnabled -bool true" \
    "Enable show desktop gesture"

# Configure look up gesture
execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2" \
    "Enable look up gesture"

# Configure app switcher gesture
execute "defaults write com.apple.dock showAppSwitcherGestureEnabled -bool true" \
    "Enable app switcher gesture"

# Configure pressure sensitivity
execute "defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1" \
    "Set light clicking pressure"

execute "defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1" \
    "Set light second clicking pressure"

# Configure trackpad sound
execute "defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0" \
    "Disable trackpad sound"

# Configure palm rejection
execute "defaults write com.apple.AppleMultitouchTrackpad PalmNoiseReduction -bool true" \
    "Enable palm rejection"

# Restart affected services
execute "killall Dock" \
    "Restart Dock"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"
