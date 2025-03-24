#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   iCloud\n\n"

# iCloud Drive
execute "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool true" \
    "Save documents to iCloud by default"

execute "defaults write com.apple.finder FXICloudDriveEnabled -bool true" \
    "Enable iCloud Drive in Finder"

execute "defaults write com.apple.finder FXICloudDriveDesktop -bool true" \
    "Enable Desktop folder sync"

execute "defaults write com.apple.finder FXICloudDriveDocuments -bool true" \
    "Enable Documents folder sync"

# Photos
execute "defaults write com.apple.Photos IPXDefaultPhotoLibrary -string 'System Photo Library'" \
    "Set default photo library"

execute "defaults write com.apple.Photos IPXEnableiCloudPhotos -bool true" \
    "Enable iCloud Photos"

execute "defaults write com.apple.Photos IPXEnablePhotoStream -bool true" \
    "Enable My Photo Stream"

execute "defaults write com.apple.Photos IPXEnableSharedPhotoStream -bool true" \
    "Enable Shared Albums"

# Mail
execute "defaults write com.apple.mail EnableMailActivityNotifications -bool true" \
    "Enable Mail notifications"

execute "defaults write com.apple.mail PollTime -int 5" \
    "Set Mail check frequency to 5 minutes"

# Messages
execute "defaults write com.apple.messages.imservice EnableMessageSync -bool true" \
    "Enable Messages in iCloud"

execute "defaults write com.apple.messages.imservice SyncConversationHistory -bool true" \
    "Sync conversation history"

# Safari
execute "defaults write com.apple.Safari CloudHistoryEnabled -bool true" \
    "Enable Safari history sync"

execute "defaults write com.apple.Safari CloudTabEnabled -bool true" \
    "Enable Safari tab sync"

# Notes
execute "defaults write com.apple.Notes SyncEnabled -bool true" \
    "Enable Notes sync"

execute "defaults write com.apple.Notes UseCloudKitSync -bool true" \
    "Use CloudKit for Notes sync"

# Reminders
execute "defaults write com.apple.remindd EnableCloudSync -bool true" \
    "Enable Reminders sync"

# Calendar
execute "defaults write com.apple.iCal EnableCloudSync -bool true" \
    "Enable Calendar sync"

# Contacts
execute "defaults write com.apple.AddressBook EnableCloudSync -bool true" \
    "Enable Contacts sync"

# Keychain
execute "defaults write com.apple.security.cloudkeychainproxy3 Enabled -bool true" \
    "Enable iCloud Keychain"

# Find My Mac
execute "defaults write com.apple.FindMyMac FMMEnabled -bool true" \
    "Enable Find My Mac"

# Storage Management
execute "defaults write com.apple.bird optimize-storage -bool true" \
    "Enable optimize storage"

execute "defaults write com.apple.bird store-in-icloud -bool true" \
    "Enable store in iCloud"

execute "defaults write com.apple.bird store-documents-in-icloud -bool true" \
    "Enable store documents in iCloud"

# Privacy
execute "defaults write com.apple.icloud Analytics -bool false" \
    "Disable iCloud analytics"

execute "defaults write com.apple.icloud DiagnosticsEnabled -bool false" \
    "Disable iCloud diagnostics"

# Menu Bar
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/iCloud.menu'" \
    "Show iCloud in menu bar"

# Restart affected services
execute "killall Finder" \
    "Restart Finder"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall bird" \
    "Restart iCloud daemon"
