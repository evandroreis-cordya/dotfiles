#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   System\n\n"

# Computer Name
execute "sudo scutil --set ComputerName 'MacBook Pro'" \
    "Set computer name"

execute "sudo scutil --set HostName 'MacBook-Pro'" \
    "Set host name"

execute "sudo scutil --set LocalHostName 'MacBook-Pro'" \
    "Set local host name"

execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string 'MacBook-Pro'" \
    "Set NetBIOS name"

# System Language and Region
execute "defaults write NSGlobalDomain AppleLanguages -array 'en-US'" \
    "Set system language to English (US)"

execute "defaults write NSGlobalDomain AppleLocale -string 'en_US'" \
    "Set system locale to US"

# System Performance
execute "sudo pmset -a hibernatemode 0" \
    "Disable hibernation"

execute "sudo rm /private/var/vm/sleepimage" \
    "Remove sleep image file"

execute "sudo touch /private/var/vm/sleepimage" \
    "Create empty sleep image file"

execute "sudo chflags uchg /private/var/vm/sleepimage" \
    "Make sleep image file immutable"

# System UI
execute "defaults write NSGlobalDomain NSWindowResizeTime -float 0.001" \
    "Speed up window resize animations"

execute "defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false" \
    "Disable window opening and closing animations"

execute "defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false" \
    "Disable smooth scrolling"

# System Sounds
execute "defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false" \
    "Disable feedback sound when changing volume"

execute "defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool false" \
    "Disable user interface sound effects"

# System Updates
execute "sudo softwareupdate --schedule on" \
    "Enable automatic system updates"

# System Crash Reports
execute "defaults write com.apple.CrashReporter DialogType none" \
    "Disable crash reporter dialogs"

# System Logging
execute "sudo defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true" \
    "Disable library validation"

# System Sleep
execute "sudo pmset -a sleep 0" \
    "Never sleep when plugged in"

execute "sudo pmset -a displaysleep 15" \
    "Display sleep after 15 minutes"

# System Temperature
execute "sudo pmset -a thermaltrigger 0" \
    "Disable thermal throttling"

# System Power
execute "sudo pmset -a powernap 0" \
    "Disable Power Nap"

execute "sudo pmset -a standby 0" \
    "Disable standby mode"

execute "sudo pmset -a autopoweroff 0" \
    "Disable auto power off"

# System Memory
execute "sudo pmset -a destroyfvkeyonstandby 1" \
    "Destroy FileVault key on standby"

# System Security
execute "sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false" \
    "Disable Gatekeeper auto-rearm"

# System Privacy
execute "defaults write com.apple.security.privacy AllowApplePersonalizedAdvertising -bool false" \
    "Disable personalized advertising"

# System Diagnostics
execute "defaults write com.apple.appleseed.FeedbackAssistant Autogather -bool false" \
    "Disable automatic feedback reporting"

# System Maintenance
execute "sudo periodic daily weekly monthly" \
    "Run system maintenance scripts"

# System Cleanup
execute "sudo rm -rf /private/var/log/asl/*.asl" \
    "Clear system logs"

execute "sudo rm -rf /Library/Caches/* /System/Library/Caches/*" \
    "Clear system caches"

# Restart affected services
execute "sudo pkill -HUP configd" \
    "Restart network configuration"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall Finder" \
    "Restart Finder"
