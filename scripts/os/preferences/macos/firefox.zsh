#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Firefox\n\n"

# Navigation Settings
execute "defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool false" \
    "Disable swipe navigation"

execute "defaults write org.mozilla.firefox AppleEnableMouseSwipeNavigateWithScrolls -bool false" \
    "Disable mouse swipe navigation"

# Performance Settings
execute "defaults write org.mozilla.firefox WebKitDNSPrefetchingEnabled -bool true" \
    "Enable DNS prefetching"

execute "defaults write org.mozilla.firefox WebKitAcceleratedCompositingEnabled -bool true" \
    "Enable accelerated compositing"

# UI Settings
execute "defaults write org.mozilla.firefox AppleShowScrollBars -string 'WhenScrolling'" \
    "Show scrollbars only when scrolling"

execute "defaults write org.mozilla.firefox NSWindowTabbingEnabled -bool true" \
    "Enable window tabbing"

# Security Settings
execute "defaults write org.mozilla.firefox WebKitWebSecurityEnabled -bool true" \
    "Enable web security"

execute "defaults write org.mozilla.firefox WebKitAllowDisplayingInsecureContent -bool false" \
    "Disable displaying insecure content"

# Download Settings
execute "defaults write org.mozilla.firefox AutoOpenSafeDownloads -bool false" \
    "Don't auto-open safe downloads"

execute "defaults write org.mozilla.firefox DownloadPathDefaultDirectory -string '$HOME/Downloads'" \
    "Set default download directory"

# Privacy Settings
execute "defaults write org.mozilla.firefox PrivateBrowsingEnabled -bool true" \
    "Enable private browsing option"

execute "defaults write org.mozilla.firefox SendDoNotTrackHTTPHeader -bool true" \
    "Enable Do Not Track header"

# Developer Settings
execute "defaults write org.mozilla.firefox WebKitDeveloperExtrasEnabledPreferenceKey -bool true" \
    "Enable developer extras"

execute "defaults write org.mozilla.firefox WebKitPreferences.developerExtrasEnabled -bool true" \
    "Enable developer preferences"

# Restart Firefox
killall "firefox" &> /dev/null
