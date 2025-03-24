#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Security & Privacy\n\n"

# FileVault
execute "sudo fdesetup status | grep 'FileVault is On' || sudo fdesetup enable" \
    "Enable FileVault"

execute "sudo defaults write /Library/Preferences/com.apple.security.fdesetup ShowRecoveryKey -bool false" \
    "Hide FileVault recovery key"

execute "sudo pmset -a destroyfvkeyonstandby 1" \
    "Destroy FileVault key when going to standby mode"

execute "sudo pmset -a hibernatemode 25" \
    "Enable secure hibernation mode"

# Firewall
execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on" \
    "Enable Firewall"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on" \
    "Enable Firewall Logging"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on" \
    "Enable Stealth Mode"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on" \
    "Allow signed apps through firewall"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp on" \
    "Allow signed app downloads"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setblockall on" \
    "Block all incoming connections"

# Gatekeeper
execute "sudo spctl --master-enable" \
    "Enable Gatekeeper"

execute "sudo spctl --enable" \
    "Enable app assessment"

execute "sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool true" \
    "Auto-rearm Gatekeeper after 30 days"

# Login Window
execute "sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true" \
    "Show name and password fields in login window"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0" \
    "Disable password hints"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow DisableConsoleAccess -bool true" \
    "Disable console access at login"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText 'Unauthorized access is prohibited.'" \
    "Set login window message"

# Password Policy
execute "sudo pwpolicy -setglobalpolicy 'maxMinutesUntilChangePassword=129600'" \
    "Set password expiration to 90 days"

execute "sudo pwpolicy -setglobalpolicy 'minChars=12'" \
    "Set minimum password length to 12 characters"

execute "sudo pwpolicy -setglobalpolicy 'requiresNumeric=1 requiresAlpha=1 requiresSymbol=1'" \
    "Require complex passwords"

# Screen Lock
execute "defaults write com.apple.screensaver askForPassword -int 1" \
    "Require password immediately after sleep or screen saver"

execute "defaults write com.apple.screensaver askForPasswordDelay -int 0" \
    "Set password delay to 0 seconds"

execute "defaults write com.apple.screensaver idleTime -int 300" \
    "Set screen saver timeout to 5 minutes"

execute "defaults write com.apple.screensaver moduleDict -dict moduleName 'Random' path '/System/Library/Screen Savers/Random.saver'" \
    "Set screen saver to Random"

# Safari Security
execute "defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true" \
    "Warn about fraudulent websites"

execute "defaults write com.apple.Safari WebKitJavaEnabled -bool false" \
    "Disable Java"

execute "defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false" \
    "Block pop-up windows"

execute "defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true" \
    "Enable Do Not Track"

execute "defaults write com.apple.Safari AutoFillPasswords -bool false" \
    "Disable AutoFill passwords"

execute "defaults write com.apple.Safari AutoFillCreditCardData -bool false" \
    "Disable AutoFill credit cards"

execute "defaults write com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -bool true" \
    "Enable Private Click Measurement"

execute "defaults write com.apple.Safari WebKitPreferences.dnsPrefetchingEnabled -bool false" \
    "Disable DNS prefetching"

# System Security
execute "sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool true" \
    "Auto-rearm Gatekeeper after 30 days"

execute "defaults write com.apple.CrashReporter DialogType -string 'none'" \
    "Disable crash reporter"

execute "sudo defaults write /Library/Preferences/com.apple.security.libraryvalidation Enabled -bool true" \
    "Enable library validation"

execute "sudo defaults write /Library/Preferences/com.apple.security.plist SecureTimestamp -bool true" \
    "Enable secure timestamp"

# Privacy
execute "defaults write com.apple.assistant.support 'Assistant Enabled' -bool false" \
    "Disable Siri"

execute "defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false" \
    "Disable personalized advertising"

execute "defaults write com.apple.Safari UniversalSearchEnabled -bool false" \
    "Disable Safari Universal Search"

execute "defaults write com.apple.Safari SuppressSearchSuggestions -bool true" \
    "Disable Safari Search Suggestions"

execute "defaults write com.apple.locationd LocationServicesEnabled -bool false" \
    "Disable Location Services"

execute "defaults write com.apple.security.privacy AllowAppsToRequestAccess -bool false" \
    "Disable apps requesting access to protected data"

execute "defaults write com.apple.assistant.backedup 'Use device speaker for TTS' -int 3" \
    "Disable Hey Siri"

# Secure Keyboard Entry
execute "defaults write com.apple.terminal SecureKeyboardEntry -bool true" \
    "Enable secure keyboard entry in Terminal"

# Time Machine
execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
    "Disable Time Machine prompts for new disks"

execute "defaults write com.apple.TimeMachine RequiresEncryption -bool true" \
    "Require encrypted Time Machine backups"

# Software Updates
execute "defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true" \
    "Enable automatic update checks"

execute "defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true" \
    "Enable automatic downloads"

execute "defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true" \
    "Install critical updates automatically"

execute "defaults write com.apple.commerce AutoUpdate -bool true" \
    "Enable automatic App Store updates"

execute "defaults write com.apple.SoftwareUpdate ConfigDataInstall -bool true" \
    "Install system data files"

execute "defaults write com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool true" \
    "Install macOS updates automatically"

# Secure Empty Trash
execute "defaults write com.apple.finder EmptyTrashSecurely -bool true" \
    "Enable secure empty trash"

# Bluetooth Security
execute "defaults write com.apple.Bluetooth ControllerPowerState -int 0" \
    "Disable Bluetooth by default"

execute "defaults write com.apple.Bluetooth DisableIncomingRequests -bool true" \
    "Disable incoming Bluetooth requests"

# iCloud Security
execute "defaults write com.apple.icloud FindMyMac -bool true" \
    "Enable Find My Mac"

execute "defaults write com.apple.icloud KeychainSyncEnabled -bool false" \
    "Disable iCloud Keychain sync"

# Restart affected services
execute "killall Finder" \
    "Restart Finder"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "sudo pkill -f bluetoothd" \
    "Restart Bluetooth daemon"
