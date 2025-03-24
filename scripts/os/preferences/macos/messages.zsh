#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Messages\n\n"

# General Settings
execute "defaults write com.apple.MobileSMS MMSMessaging -bool true" \
    "Enable MMS messaging"

execute "defaults write com.apple.MobileSMS SyncTranscript -bool true" \
    "Enable message syncing"

execute "defaults write com.apple.MobileSMS AutoDownload -bool false" \
    "Disable automatic download of attachments"

execute "defaults write com.apple.MobileSMS PreviewEnabled -bool true" \
    "Enable message previews"

execute "defaults write com.apple.MobileSMS ShowPreviewsSetting -int 1" \
    "Show message previews when locked"

# iMessage Settings
execute "defaults write com.apple.MobileSMS DeliveryReports -bool true" \
    "Enable read receipts"

execute "defaults write com.apple.MobileSMS SendTypingIndicators -bool true" \
    "Enable typing indicators"

execute "defaults write com.apple.MobileSMS SendReadReceipts -bool true" \
    "Enable read receipts"

execute "defaults write com.apple.MobileSMS SMSRelay -bool true" \
    "Enable SMS relay"

execute "defaults write com.apple.MobileSMS iMessageAutoLogin -bool true" \
    "Enable automatic iMessage login"

# Notification Settings
execute "defaults write com.apple.MobileSMS PlaySoundsKey -bool true" \
    "Enable message sounds"

execute "defaults write com.apple.MobileSMS NotificationAlertType -int 1" \
    "Set notification style to banners"

execute "defaults write com.apple.MobileSMS NotificationSoundName -string 'Popcorn'" \
    "Set notification sound to Popcorn"

execute "defaults write com.apple.MobileSMS NotificationCenterEnabled -bool true" \
    "Show notifications in Notification Center"

execute "defaults write com.apple.MobileSMS NotificationGrouping -int 1" \
    "Group notifications by app"

# Privacy Settings
execute "defaults write com.apple.MobileSMS BlockUnknownSenders -bool true" \
    "Filter unknown senders"

execute "defaults write com.apple.MobileSMS FilterSpam -bool true" \
    "Enable spam filtering"

execute "defaults write com.apple.MobileSMS ShareAnalytics -bool false" \
    "Disable analytics sharing"

execute "defaults write com.apple.MobileSMS ShareCrashReports -bool false" \
    "Disable crash report sharing"

execute "defaults write com.apple.MobileSMS ShareUsageData -bool false" \
    "Disable usage data sharing"

# Appearance Settings
execute "defaults write com.apple.MobileSMS ShowContactPhotos -bool true" \
    "Show contact photos"

execute "defaults write com.apple.MobileSMS ShowFullName -bool true" \
    "Show full contact names"

execute "defaults write com.apple.MobileSMS ConversationTimeStamps -bool true" \
    "Show conversation timestamps"

execute "defaults write com.apple.MobileSMS MessageTimeStamps -bool true" \
    "Show message timestamps"

execute "defaults write com.apple.MobileSMS BalloonShape -int 1" \
    "Set message bubble style"

# Storage Settings
execute "defaults write com.apple.MobileSMS MessageRetentionPolicy -int 1" \
    "Keep messages forever"

execute "defaults write com.apple.MobileSMS MediaRetentionPolicy -int 1" \
    "Keep media attachments forever"

execute "defaults write com.apple.MobileSMS AutoDeleteThreads -bool false" \
    "Disable automatic thread deletion"

execute "defaults write com.apple.MobileSMS AutoDeleteMessages -bool false" \
    "Disable automatic message deletion"

execute "defaults write com.apple.MobileSMS DeleteOnLowStorage -bool false" \
    "Disable deletion on low storage"

# Text Forwarding
execute "defaults write com.apple.MobileSMS TextForwardingEnabled -bool true" \
    "Enable text message forwarding"

execute "defaults write com.apple.MobileSMS TextForwardingAutoAccept -bool true" \
    "Auto-accept text message forwarding"

execute "defaults write com.apple.MobileSMS TextForwardingShowAlert -bool true" \
    "Show text forwarding alerts"

# Sync Settings
execute "defaults write com.apple.MobileSMS CloudKitSyncEnabled -bool true" \
    "Enable iCloud sync"

execute "defaults write com.apple.MobileSMS CloudKitSyncDevices -bool true" \
    "Sync across all devices"

execute "defaults write com.apple.MobileSMS CloudKitSyncAttachments -bool true" \
    "Sync attachments"

# Effects Settings
execute "defaults write com.apple.MobileSMS EffectsEnabled -bool true" \
    "Enable message effects"

execute "defaults write com.apple.MobileSMS AutoPlayEffects -bool true" \
    "Auto-play message effects"

execute "defaults write com.apple.MobileSMS ReduceMotion -bool false" \
    "Enable full motion effects"

# Group Message Settings
execute "defaults write com.apple.MobileSMS GroupMessaging -bool true" \
    "Enable group messaging"

execute "defaults write com.apple.MobileSMS GroupPhotoSharing -bool true" \
    "Enable group photo sharing"

execute "defaults write com.apple.MobileSMS GroupNameSync -bool true" \
    "Enable group name syncing"

# Keyboard Settings
execute "defaults write com.apple.MobileSMS PredictiveEnabled -bool true" \
    "Enable predictive text"

execute "defaults write com.apple.MobileSMS AutoCorrectEnabled -bool true" \
    "Enable auto-correction"

execute "defaults write com.apple.MobileSMS SpellCheckingEnabled -bool true" \
    "Enable spell checking"

# Restart Messages
execute "killall Messages" \
    "Restart Messages"
