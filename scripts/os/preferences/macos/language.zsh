#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Language & Region\n\n"

# Language
execute "defaults write NSGlobalDomain AppleLanguages -array 'en-US'" \
    "Set language to English (US)"

execute "defaults write NSGlobalDomain AppleLocale -string 'en_US'" \
    "Set locale to en_US"

# Region
execute "defaults write NSGlobalDomain AppleMetricUnits -bool true" \
    "Set measurement units to metric"

execute "defaults write NSGlobalDomain AppleMeasurementUnits -string 'Centimeters'" \
    "Set measurement units to centimeters"

execute "defaults write NSGlobalDomain AppleTemperatureUnit -string 'Celsius'" \
    "Set temperature to Celsius"

# Date & Time
execute "defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add '1' 'yyyy-MM-dd'" \
    "Set date format to yyyy-MM-dd"

execute "defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add '1' 'HH:mm:ss'" \
    "Set time format to 24-hour"

execute "defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm'" \
    "Set menu bar clock format"

# First day of week
execute "defaults write NSGlobalDomain AppleFirstWeekday -dict 'gregorian' 2" \
    "Set first day of week to Monday"

# Currency
execute "defaults write NSGlobalDomain AppleICUNumberSymbols -dict 0 '.' 1 ',' 10 '.' 17 ','" \
    "Set decimal separator to dot and thousands separator to comma"

# Input Sources
execute "defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '
<dict>
    <key>InputSourceKind</key>
    <string>Keyboard Layout</string>
    <key>KeyboardLayout ID</key>
    <integer>0</integer>
    <key>KeyboardLayout Name</key>
    <string>U.S.</string>
</dict>'" \
    "Add U.S. keyboard layout"

# Spelling
execute "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true" \
    "Enable automatic spelling correction"

execute "defaults write NSGlobalDomain NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true" \
    "Enable automatic language detection"

execute "defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool true" \
    "Enable automatic spelling correction in web views"

# Text Substitution
execute "defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array" \
    "Clear text substitutions"

# Add common text substitutions
execute "defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array-add '{
    on=1;
    replace=\"(c)\";
    with=\"©\";
}'" \
    "Add copyright symbol substitution"

execute "defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array-add '{
    on=1;
    replace=\"(r)\";
    with=\"®\";
}'" \
    "Add registered trademark symbol substitution"

execute "defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array-add '{
    on=1;
    replace=\"(tm)\";
    with=\"™\";
}'" \
    "Add trademark symbol substitution"

# Restart affected applications
execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall Finder" \
    "Restart Finder"
