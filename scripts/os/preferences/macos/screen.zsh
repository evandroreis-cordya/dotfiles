#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Screen\n\n"

# Screen Saver
execute "defaults write com.apple.screensaver askForPassword -int 1" \
    "Require password immediately after sleep or screen saver"

execute "defaults write com.apple.screensaver askForPasswordDelay -int 0" \
    "Set password delay to 0 seconds"

execute "defaults -currentHost write com.apple.screensaver idleTime -int 300" \
    "Start screen saver after 5 minutes"

# Screenshots
execute "defaults write com.apple.screencapture location -string '$HOME/Desktop'" \
    "Save screenshots to Desktop"

execute "defaults write com.apple.screencapture type -string 'png'" \
    "Save screenshots in PNG format"

execute "defaults write com.apple.screencapture disable-shadow -bool true" \
    "Disable shadow in screenshots"

execute "defaults write com.apple.screencapture show-thumbnail -bool true" \
    "Show thumbnail after taking screenshot"

execute "defaults write com.apple.screencapture include-date -bool true" \
    "Include date in screenshot filenames"

execute "defaults write com.apple.screencapture show-cursor -bool true" \
    "Include cursor in screenshots"

# Screen Recording
execute "defaults write com.apple.QuickTimePlayerX MGShowStopRecordingConfirmation -bool false" \
    "Disable recording confirmation dialog in QuickTime"

execute "defaults write com.apple.screencapture enable-video-recording -bool true" \
    "Enable screen recording in menu bar"

# Display Sleep
execute "sudo pmset -a displaysleep 15" \
    "Set display sleep to 15 minutes"

execute "sudo pmset -a disksleep 15" \
    "Set disk sleep to 15 minutes"

# Energy Saver
execute "sudo pmset -a hibernatemode 3" \
    "Enable safe sleep mode"

execute "sudo pmset -a standby 1" \
    "Enable standby mode"

execute "sudo pmset -a standbydelay 86400" \
    "Set standby delay to 24 hours"

execute "sudo pmset -a powernap 1" \
    "Enable Power Nap"

# Night Shift
execute "defaults write com.apple.CoreBrightness CBBlueReductionStatus -bool true" \
    "Enable Night Shift"

execute "defaults write com.apple.CoreBrightness CBBlueReductionStartHour -int 22" \
    "Set Night Shift start time to 22:00"

execute "defaults write com.apple.CoreBrightness CBBlueReductionEndHour -int 7" \
    "Set Night Shift end time to 07:00"

execute "defaults write com.apple.CoreBrightness CBBlueReductionStrength -float 0.7" \
    "Set Night Shift strength to 70%"

execute "defaults write com.apple.CoreBrightness CBBlueReductionScheduleEnabled -bool true" \
    "Enable Night Shift schedule"

# True Tone
execute "defaults write com.apple.CoreBrightness CBDisplayShouldUseTrueTone -bool true" \
    "Enable True Tone if supported"

# Display Resolution
execute "defaults write NSGlobalDomain AppleDisplayScaleFactor -int 2" \
    "Enable Retina display scaling"

execute "defaults write NSGlobalDomain NSWindowResizeTime -float 0.001" \
    "Speed up display resize time"

# Display Arrangement
execute "defaults write com.apple.windowserver DisplayResolutionEnabled -bool true" \
    "Enable display resolution options"

execute "defaults write com.apple.windowserver DisplayArragement -bool true" \
    "Enable display arrangement"

# Display Color
execute "defaults write NSGlobalDomain AppleDisplayGamut -string 'sRGB'" \
    "Set display color profile to sRGB"

execute "defaults write NSGlobalDomain AppleColorSpacePreference -string 'sRGB'" \
    "Set color space preference to sRGB"

# Hot Corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 14: Quick Note

# Top left screen corner → Mission Control
execute "defaults write com.apple.dock wvous-tl-corner -int 2 && \
         defaults write com.apple.dock wvous-tl-modifier -int 0" \
    "Set top left hot corner to Mission Control"

# Top right screen corner → Desktop
execute "defaults write com.apple.dock wvous-tr-corner -int 4 && \
         defaults write com.apple.dock wvous-tr-modifier -int 0" \
    "Set top right hot corner to Desktop"

# Bottom left screen corner → Start screen saver
execute "defaults write com.apple.dock wvous-bl-corner -int 5 && \
         defaults write com.apple.dock wvous-bl-modifier -int 0" \
    "Set bottom left hot corner to Start screen saver"

# Bottom right screen corner → Quick Note
execute "defaults write com.apple.dock wvous-br-corner -int 14 && \
         defaults write com.apple.dock wvous-br-modifier -int 0" \
    "Set bottom right hot corner to Quick Note"

# Menu Bar
execute "defaults write NSGlobalDomain _HIHideMenuBar -bool false" \
    "Show menu bar"

execute "defaults write NSGlobalDomain AppleMenuBarExtraHeight -int 22" \
    "Set menu bar height"

# Wallpaper
execute "osascript -e 'tell application \"System Events\" to tell every desktop to set picture to \"$HOME/Pictures/Wallpapers/default.jpg\"'" \
    "Set default wallpaper"

# Restart affected applications
execute "killall Dock" \
    "Restart Dock"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall Finder" \
    "Restart Finder"
