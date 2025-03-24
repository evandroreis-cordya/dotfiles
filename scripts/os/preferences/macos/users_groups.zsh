#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Users & Groups\n\n"

# Login Window
execute "sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true" \
    "Show name and password fields in login window"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText -string 'Welcome!'" \
    "Set login window message"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo -string 'HostName'" \
    "Show hostname in login window"

# Guest Account
execute "sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false" \
    "Disable guest account"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow DisableGuestAccount -bool true" \
    "Disable guest account (alternative method)"

# Automatic Login
execute "sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser -bool false" \
    "Disable automatic login"

# Password Hints
execute "sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0" \
    "Disable password hints"

# Fast User Switching
execute "sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool true" \
    "Enable fast user switching"

execute "defaults write NSGlobalDomain userMenuExtraStyle -int 2" \
    "Show full name in user menu"

# Login Items
execute "osascript -e 'tell application \"System Events\" to delete every login item'" \
    "Remove all login items"

# Password Requirements
execute "sudo pwpolicy -setglobalpolicy 'minChars=12 requiresNumeric=1 requiresAlpha=1 requiresSymbol=1'" \
    "Set password requirements"

# Account Pictures
execute "sudo defaults write /Library/Preferences/com.apple.loginwindow UseComputerNameForBanner -bool true" \
    "Use computer name for banner"

# Home Directory
execute "sudo defaults write /Library/Preferences/com.apple.loginwindow CreateHomeInUserPartition -bool true" \
    "Create home directory in user partition"

# Account Type
execute "sudo dscl . -create /Users/$USER UserShell /bin/zsh" \
    "Set default shell to zsh"

execute "sudo dscl . -create /Users/$USER NFSHomeDirectory /Users/$USER" \
    "Set home directory"

# File Vault
execute "sudo fdesetup enable" \
    "Enable FileVault"

# Keychain
execute "security set-keychain-settings -t 3600 -l" \
    "Lock keychain after 1 hour"

execute "security set-keychain-settings -u" \
    "Lock keychain when sleeping"

# Screen Saver Password
execute "defaults write com.apple.screensaver askForPassword -int 1" \
    "Require password after sleep or screen saver"

execute "defaults write com.apple.screensaver askForPasswordDelay -int 0" \
    "No delay before asking for password"

# Menu Bar
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/User.menu'" \
    "Show user menu in menu bar"

# Parental Controls
execute "sudo defaults write /Library/Preferences/com.apple.familycontrols.managed ContentFilter -dict-add Enabled -bool false" \
    "Disable parental controls"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall cfprefsd" \
    "Restart preferences daemon"
