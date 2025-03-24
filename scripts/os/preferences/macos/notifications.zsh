#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Notifications\n\n"

# General Settings
execute "defaults write com.apple.notificationcenterui bannerTime -int 5" \
    "Set banner display time to 5 seconds"

execute "defaults write com.apple.notificationcenterui notificationCenterHasShownWelcome -bool true" \
    "Disable welcome message"

execute "defaults write com.apple.notificationcenterui allowNCAccessInRemoteSession -bool false" \
    "Disable Notification Center in remote sessions"

execute "defaults write com.apple.notificationcenterui showReminders -bool true" \
    "Show reminders in Notification Center"

# Do Not Disturb
execute "defaults write com.apple.controlcenter 'NSStatusItem Visible DoNotDisturb' -bool true" \
    "Show Do Not Disturb in Control Center"

execute "defaults write com.apple.ncprefs dndStart -int 2300" \
    "Set Do Not Disturb start time to 23:00"

execute "defaults write com.apple.ncprefs dndEnd -int 700" \
    "Set Do Not Disturb end time to 07:00"

execute "defaults write com.apple.ncprefs dndMirrored -bool true" \
    "Mirror Do Not Disturb on all devices"

execute "defaults write com.apple.ncprefs dndDisplaySleep -bool true" \
    "Enable Do Not Disturb when display is sleeping"

execute "defaults write com.apple.ncprefs dndWhileScreenSharing -bool true" \
    "Enable Do Not Disturb during screen sharing"

# Notification Style
execute "defaults write com.apple.notificationcenterui notificationStyle -int 2" \
    "Set notification style to banners"

execute "defaults write com.apple.notificationcenterui showInLockScreen -bool false" \
    "Disable notifications on lock screen"

execute "defaults write com.apple.notificationcenterui showInNotificationCenter -bool true" \
    "Show in Notification Center"

execute "defaults write com.apple.notificationcenterui showBadgeIcon -bool true" \
    "Show badge icon"

# Notification Grouping
execute "defaults write com.apple.notificationcenterui groupingStyle -int 1" \
    "Group notifications by app"

execute "defaults write com.apple.notificationcenterui groupingByAppEnabled -bool true" \
    "Enable notification grouping"

execute "defaults write com.apple.notificationcenterui groupingByThreadEnabled -bool true" \
    "Enable thread grouping"

execute "defaults write com.apple.notificationcenterui collapseGroupsWhenScrolling -bool true" \
    "Collapse groups when scrolling"

# Sound and Badges
execute "defaults write com.apple.notificationcenterui soundEnabled -bool true" \
    "Enable notification sounds"

execute "defaults write com.apple.notificationcenterui badgesEnabled -bool true" \
    "Enable notification badges"

execute "defaults write com.apple.notificationcenterui soundVolume -float 0.8" \
    "Set notification sound volume to 80%"

execute "defaults write com.apple.notificationcenterui hapticFeedbackEnabled -bool true" \
    "Enable haptic feedback"

# Preview Settings
execute "defaults write com.apple.notificationcenterui showPreview -bool true" \
    "Show notification previews always"

execute "defaults write com.apple.notificationcenterui showPreviewsSetting -int 2" \
    "Show previews when unlocked"

execute "defaults write com.apple.notificationcenterui privacyEnabled -bool true" \
    "Enable notification privacy"

# Critical Alerts
execute "defaults write com.apple.notificationcenterui criticalAlertEnabled -bool true" \
    "Enable critical alerts"

execute "defaults write com.apple.notificationcenterui criticalAlertVolume -float 1.0" \
    "Set critical alert volume to maximum"

execute "defaults write com.apple.notificationcenterui criticalAlertRepeat -bool true" \
    "Enable critical alert repeat"

# App-specific Settings
# Calendar
execute "defaults write com.apple.iCal NotificationPreferences -dict-add 'calendar.alert.usedefaults' -bool true" \
    "Use default Calendar notifications"

execute "defaults write com.apple.iCal 'Default Alert' -int 1" \
    "Set default Calendar alert time"

# Mail
execute "defaults write com.apple.mail NewMessagesSoundName -string 'Blow'" \
    "Set Mail notification sound"

execute "defaults write com.apple.mail VIPNotificationStyle -int 2" \
    "Set VIP Mail notification style"

execute "defaults write com.apple.mail SuppressNotificationSounds -bool false" \
    "Enable Mail notification sounds"

# Messages
execute "defaults write com.apple.messages NotificationPreferences -dict-add 'message.alert.usedefaults' -bool true" \
    "Use default Messages notifications"

execute "defaults write com.apple.messages PlaySoundOnSend -bool false" \
    "Disable sound on message send"

# FaceTime
execute "defaults write com.apple.facetime NotificationPreferences -dict-add 'facetime.alert.usedefaults' -bool true" \
    "Use default FaceTime notifications"

execute "defaults write com.apple.facetime RingtoneIdentifier -string 'Opening'" \
    "Set FaceTime ringtone"

# Focus Mode
execute "defaults write com.apple.ncprefs focusModesEnabled -bool true" \
    "Enable Focus modes"

execute "defaults write com.apple.ncprefs focusModesDuringSetup -bool true" \
    "Enable Focus modes during setup"

execute "defaults write com.apple.ncprefs focusModesShareAcrossDevices -bool true" \
    "Share Focus modes across devices"

execute "defaults write com.apple.ncprefs focusModesAutomationEnabled -bool true" \
    "Enable Focus modes automation"

# Time Sensitive Notifications
execute "defaults write com.apple.notificationcenterui timeSensitiveEnabled -bool true" \
    "Enable time sensitive notifications"

execute "defaults write com.apple.notificationcenterui timeSensitiveBypassDND -bool true" \
    "Allow time sensitive notifications during DND"

execute "defaults write com.apple.notificationcenterui timeSensitiveRequireUnlock -bool false" \
    "Don't require unlock for time sensitive notifications"

# Notification Center Widgets
execute "defaults write com.apple.notificationcenterui widgets -array-add '
<dict>
    <key>bundle-id</key>
    <string>com.apple.weather.widget</string>
    <key>enabled</key>
    <true/>
    <key>position</key>
    <integer>1</integer>
</dict>'" \
    "Add Weather widget"

execute "defaults write com.apple.notificationcenterui widgets -array-add '
<dict>
    <key>bundle-id</key>
    <string>com.apple.calculator.widget</string>
    <key>enabled</key>
    <true/>
    <key>position</key>
    <integer>2</integer>
</dict>'" \
    "Add Calculator widget"

execute "defaults write com.apple.notificationcenterui widgets -array-add '
<dict>
    <key>bundle-id</key>
    <string>com.apple.calendar.widget</string>
    <key>enabled</key>
    <true/>
    <key>position</key>
    <integer>3</integer>
</dict>'" \
    "Add Calendar widget"

# Widget Settings
execute "defaults write com.apple.notificationcenterui widgetSidebarEnabled -bool true" \
    "Enable widget sidebar"

execute "defaults write com.apple.notificationcenterui widgetSidebarShowDate -bool true" \
    "Show date in widget sidebar"

execute "defaults write com.apple.notificationcenterui widgetSidebarShowTime -bool true" \
    "Show time in widget sidebar"

# Restart affected services
execute "killall NotificationCenter" \
    "Restart Notification Center"

execute "killall ControlCenter" \
    "Restart Control Center"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"
