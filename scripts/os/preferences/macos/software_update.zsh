#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Software Update\n\n"

# Automatic Updates
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true" \
    "Enable automatic update checks"

execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true" \
    "Enable automatic downloads"

execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool true" \
    "Enable automatic macOS updates"

execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true" \
    "Install system data files"

execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true" \
    "Install critical updates"

# Update Frequency
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ScheduleFrequency -int 1" \
    "Check for updates daily"

# App Store Updates
execute "sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true" \
    "Enable automatic App Store updates"

execute "sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true" \
    "Allow restart if required"

# Download Options
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AllowPreReleaseInstallation -bool false" \
    "Disable pre-release updates"

execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallAppUpdates -bool true" \
    "Automatically install app updates"

# Notifications
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate SUEnableAutomaticChecks -bool true" \
    "Enable update notifications"

execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate SUEnableAutomaticDownload -bool true" \
    "Enable download notifications"

# Menu Bar
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/SoftwareUpdate.menu'" \
    "Show Software Update in menu bar"

# Update History
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AllowMacOSInstallHistory -bool true" \
    "Keep update history"

# Beta Updates
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AllowBetaUpdates -bool false" \
    "Disable beta updates"

# Background Updates
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate EnableBackgroundUpdates -bool true" \
    "Enable background updates"

# Power Management
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate InstallWhilePowerPluggedIn -bool true" \
    "Only install updates when plugged in"

# Network Usage
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate DisableLowPriorityDownloads -bool false" \
    "Allow low priority downloads"

execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AllowLowPowerInstallation -bool false" \
    "Disable low power installation"

# Security
execute "sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate RequireAdminPasswordForUpdates -bool true" \
    "Require admin password for updates"

# Cleanup
execute "sudo softwareupdate --clear-catalog" \
    "Clear update catalog"

# Restart affected services
execute "sudo pkill -HUP softwareupdated" \
    "Restart Software Update daemon"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"
