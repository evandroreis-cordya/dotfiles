#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Accessibility\n\n"

# Display
execute "defaults write com.apple.universalaccess reduceTransparency -bool false" \
    "Enable transparency"

execute "defaults write com.apple.universalaccess increaseContrast -bool false" \
    "Disable increase contrast"

execute "defaults write com.apple.universalaccess reduceMotion -bool false" \
    "Enable animations"

# Zoom
execute "defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true" \
    "Enable zoom using scroll gesture with modifier keys"

execute "defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -int 262144" \
    "Set zoom modifier to Control key"

execute "defaults write com.apple.universalaccess closeViewPanningMode -int 0" \
    "Set zoom panning to continuous with pointer"

# VoiceOver
execute "defaults write com.apple.universalaccess VoiceOverTouchEnabled -bool false" \
    "Disable VoiceOver"

# Voice Control
execute "defaults write com.apple.universalaccess voiceControlEnabled -bool false" \
    "Disable Voice Control"

# Switch Control
execute "defaults write com.apple.universalaccess switchControlEnabled -bool false" \
    "Disable Switch Control"

# Keyboard
execute "defaults write com.apple.universalaccess slowKey -bool false" \
    "Disable Slow Keys"

execute "defaults write com.apple.universalaccess stickyKey -bool false" \
    "Disable Sticky Keys"

execute "defaults write com.apple.universalaccess mouseKey -bool false" \
    "Disable Mouse Keys"

# Mouse & Trackpad
execute "defaults write com.apple.universalaccess mouseDriver -int 0" \
    "Set mouse driver to default"

execute "defaults write com.apple.universalaccess trackpadDriver -int 0" \
    "Set trackpad driver to default"

execute "defaults write com.apple.universalaccess mouseDriverCursorSize -float 1.0" \
    "Set cursor size to normal"

# Subtitles & Captioning
execute "defaults write com.apple.universalaccess captionDisplay -bool true" \
    "Enable closed captions when available"

execute "defaults write com.apple.universalaccess captionStyle -int 0" \
    "Set caption style to default"

# Audio
execute "defaults write com.apple.universalaccess flashScreen -bool false" \
    "Disable flash screen on alert"

execute "defaults write com.apple.universalaccess monoAudioEnabled -bool false" \
    "Disable mono audio"

# Siri
execute "defaults write com.apple.universalaccess siriDictationEnabled -bool false" \
    "Disable Siri dictation"

# Color Filters
execute "defaults write com.apple.universalaccess displayColorFiltersEnabled -bool false" \
    "Disable color filters"

# Display Accommodations
execute "defaults write com.apple.universalaccess whiteOnBlack -bool false" \
    "Disable invert colors"

execute "defaults write com.apple.universalaccess grayscale -bool false" \
    "Disable grayscale"

# Hover Text
execute "defaults write com.apple.universalaccess hoverTextEnabled -bool false" \
    "Disable hover text"

# Head Pointer
execute "defaults write com.apple.universalaccess headMouseEnabled -bool false" \
    "Disable head pointer"

# Dwell Control
execute "defaults write com.apple.universalaccess dwellEnabled -bool false" \
    "Disable dwell control"

# Alternative Input
execute "defaults write com.apple.universalaccess alternateInputEnabled -bool false" \
    "Disable alternative input methods"

# Shortcuts
execute "defaults write com.apple.universalaccess shortcuts -dict-add 'Full Keyboard Access' -bool true" \
    "Enable full keyboard access"

execute "defaults write com.apple.universalaccess shortcuts -dict-add 'VoiceOver' -bool false" \
    "Disable VoiceOver shortcut"

# Menu Bar
execute "defaults write com.apple.universalaccess showAccessibilityStatus -bool true" \
    "Show accessibility status in menu bar"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall Finder" \
    "Restart Finder"
