#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Date & Time\n\n"

# Time Zone
execute "sudo systemsetup -settimezone 'America/Sao_Paulo'" \
    "Set timezone to America/Los_Angeles"

execute "sudo systemsetup -setusingnetworktime on" \
    "Enable network time"

execute "sudo systemsetup -setnetworktimeserver 'time.apple.com'" \
    "Set network time server to time.apple.com"

# Date Format
execute "defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add '1' 'yyyy-MM-dd'" \
    "Set date format to yyyy-MM-dd"

execute "defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add '2' 'yyyy-MM-dd'" \
    "Set short date format to yyyy-MM-dd"

execute "defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add '3' 'yyyy-MM-dd'" \
    "Set medium date format to yyyy-MM-dd"

execute "defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add '4' 'EEEE, MMMM d, yyyy'" \
    "Set long date format to full text"

# Time Format
execute "defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add '1' 'HH:mm:ss'" \
    "Set time format to 24-hour"

execute "defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add '2' 'HH:mm:ss'" \
    "Set short time format to 24-hour"

execute "defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add '3' 'HH:mm:ss'" \
    "Set medium time format to 24-hour"

execute "defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add '4' 'HH:mm:ss z'" \
    "Set long time format with timezone"

# Menu Bar Clock
execute "defaults write com.apple.menuextra.clock IsAnalog -bool false" \
    "Use digital clock"

execute "defaults write com.apple.menuextra.clock Show24Hour -bool true" \
    "Show 24-hour time"

execute "defaults write com.apple.menuextra.clock ShowSeconds -bool true" \
    "Show seconds"

execute "defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true" \
    "Show day of week"

execute "defaults write com.apple.menuextra.clock ShowDayOfMonth -bool true" \
    "Show date"

# Menu Bar
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/Clock.menu'" \
    "Show clock in menu bar"

# First Day of Week
execute "defaults write NSGlobalDomain AppleFirstWeekday -dict 'gregorian' 2" \
    "Set first day of week to Monday"

# Calendar Week Numbers
execute "defaults write NSGlobalDomain AppleShowWeekNumbers -bool true" \
    "Show week numbers in calendar"

# Flash the time separators
execute "defaults write com.apple.menuextra.clock FlashDateSeparators -bool false" \
    "Don't flash time separators"

# Time Zone Support
execute "defaults write com.apple.menuextra.clock ShowTimeZone -bool true" \
    "Show time zone support"

execute "defaults write com.apple.menuextra.clock TimeZone -string 'America/Los_Angeles'" \
    "Set menu bar clock time zone"

# Calendar
execute "defaults write com.apple.iCal 'first day of week' -int 1" \
    "Set Calendar first day to Monday"

execute "defaults write com.apple.iCal 'show week numbers' -bool true" \
    "Show week numbers in Calendar"

# World Clock
execute "defaults write com.apple.menuextra.clock WorldClockEnabled -bool true" \
    "Enable world clock"

execute "defaults write com.apple.menuextra.clock WorldClockCities -array \
    '{city = \"London\"; identifier = \"Europe/London\";}' \
    '{city = \"New York\"; identifier = \"America/New_York\";}' \
    '{city = \"Tokyo\"; identifier = \"Asia/Tokyo\";}'" \
    "Add world clock cities"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"
