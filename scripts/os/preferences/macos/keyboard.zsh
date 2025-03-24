#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Keyboard\n\n"

# Enable full keyboard access for all controls
execute "defaults write -g AppleKeyboardUIMode -int 3" \
    "Enable full keyboard access for all controls"

# Configure key repeat behavior
execute "defaults write -g ApplePressAndHoldEnabled -bool false" \
    "Disable press-and-hold in favor of key repeat"

execute "defaults write -g InitialKeyRepeat -int 15" \
    "Set initial key repeat delay (shorter is faster)"

execute "defaults write -g KeyRepeat -int 2" \
    "Set key repeat rate (shorter is faster)"

# Disable automatic text features
execute "defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false" \
    "Disable automatic capitalization"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable automatic spelling correction"

execute "defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false" \
    "Disable automatic period substitution"

execute "defaults write -g NSAutomaticDashSubstitutionEnabled -bool false" \
    "Disable automatic dash substitution"

execute "defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false" \
    "Disable automatic quote substitution"

# Configure text selection behavior
execute "defaults write -g NSTextShowsControlCharacters -bool true" \
    "Display ASCII control characters"

# Configure input sources
execute "defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>'" \
    "Set U.S. keyboard as default input source"

# Configure keyboard function keys
execute "defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true" \
    "Use F1, F2, etc. keys as standard function keys"

# Configure keyboard illumination
execute "defaults write com.apple.BezelServices kDim -bool true" \
    "Enable keyboard illumination"

execute "defaults write com.apple.BezelServices kDimTime -int 300" \
    "Set keyboard illumination dim time (5 minutes)"

# Configure keyboard shortcuts
execute "defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add 'Copy' '@c'" \
    "Set Copy shortcut to Cmd+C"

execute "defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add 'Paste' '@v'" \
    "Set Paste shortcut to Cmd+V"

execute "defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add 'Cut' '@x'" \
    "Set Cut shortcut to Cmd+X"

execute "defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add 'Select All' '@a'" \
    "Set Select All shortcut to Cmd+A"

# Configure keyboard navigation
execute "defaults write NSGlobalDomain AppleKeyboardUIMode -int 3" \
    "Enable full keyboard navigation"

execute "defaults write NSGlobalDomain AppleKeyboardUIMode -int 2" \
    "Enable keyboard control for dialogs"

# Configure keyboard input
execute "defaults write NSGlobalDomain AppleLanguages -array 'en-US'" \
    "Set keyboard language to English (US)"

execute "defaults write NSGlobalDomain AppleLocale -string 'en_US'" \
    "Set keyboard locale to US"

# Configure keyboard feedback
execute "defaults write NSGlobalDomain com.apple.keyboard.feedback -bool false" \
    "Disable keyboard feedback sound"

# Configure keyboard modifiers
execute "defaults write NSGlobalDomain com.apple.keyboard.modifiermapping.1452-566-0 -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'" \
    "Map Caps Lock to Control"

# Configure keyboard typing
execute "defaults write NSGlobalDomain WebAutomaticTextCompletion -bool true" \
    "Enable text completion"

execute "defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool true" \
    "Enable automatic text completion"

# Restart affected applications
execute "killall SystemUIServer" \
    "Restart SystemUIServer to apply changes"
