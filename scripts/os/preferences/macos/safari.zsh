#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Safari\n\n"

# General Settings
execute "defaults write com.apple.Safari HomePage -string 'about:blank'" \
    "Set homepage to 'about:blank'"

execute "defaults write com.apple.Safari AutoFillPasswords -bool false" \
    "Disable AutoFill passwords"

execute "defaults write com.apple.Safari AutoFillCreditCardData -bool false" \
    "Disable AutoFill credit card data"

execute "defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false" \
    "Disable AutoFill miscellaneous forms"

execute "defaults write com.apple.Safari AutoOpenSafeDownloads -bool false" \
    "Disable automatically opening 'safe' files"

execute "defaults write com.apple.Safari DownloadsClearingPolicy -int 2" \
    "Clear downloads list when Safari quits"

execute "defaults write com.apple.Safari ShowFavoritesBar -bool false" \
    "Hide bookmarks bar by default"

execute "defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true" \
    "Show full URL in address bar"

execute "defaults write com.apple.Safari ShowStatusBar -bool true" \
    "Show status bar"

# Search Settings
execute "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false" \
    "Set search type to 'Contains' instead of 'Starts with'"

execute "defaults write com.apple.Safari SuppressSearchSuggestions -bool true && \
         defaults write com.apple.Safari UniversalSearchEnabled -bool false" \
    "Don't send search queries to Apple"

execute "defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false" \
    "Disable website-specific search"

# Privacy Settings
execute "defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true" \
    "Enable Do Not Track header"

execute "defaults write com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -bool true" \
    "Enable Private Click Measurement"

execute "defaults write com.apple.Safari WebKitStorageBlockingPolicy -int 1" \
    "Block all third-party storage"

execute "defaults write com.apple.Safari BlockStoragePolicy -int 2" \
    "Block all cookies and website data"

execute "defaults write com.apple.Safari WebKitPreferences.dnsPrefetchingEnabled -bool false" \
    "Disable DNS prefetching"

execute "defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false" \
    "Disable inline media playback"

# Security Settings
execute "defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true" \
    "Warn about fraudulent websites"

execute "defaults write com.apple.Safari WebKitJavaEnabled -bool false" \
    "Disable Java"

execute "defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false" \
    "Block pop-up windows"

execute "defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 0" \
    "Deny websites access to location services"

execute "defaults write com.apple.Safari WebKitPreferences.javaScriptCanAccessClipboard -bool false" \
    "Prevent JavaScript from accessing clipboard"

# Developer Settings
execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
         defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
         defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true" \
    "Enable 'Developer' menu and 'Web Inspector'"

execute "defaults write com.apple.Safari IncludeInternalDebugMenu -bool true" \
    "Enable 'Debug' menu"

execute "defaults write -g WebKitDeveloperExtras -bool true" \
    "Add context menu item to show 'Web Inspector' in web views"

execute "defaults write com.apple.Safari WebKitPreferences.developerExtrasEnabled -bool true" \
    "Enable developer extras in all web views"

# Navigation Settings
execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true" \
    "Set backspace key to go to previous page in history"

execute "defaults write com.apple.Safari TabCreationPolicy -int 2" \
    "Open new tabs with empty page"

execute "defaults write com.apple.Safari NewTabBehavior -int 1" \
    "Open new windows with empty page"

execute "defaults write com.apple.Safari NewWindowBehavior -int 1" \
    "Open new windows with empty page"

execute "defaults write com.apple.Safari CommandClickMakesTabs -bool true" \
    "Command-click opens links in new tabs"

# Reading List
execute "defaults write com.apple.Safari ReadingListSaveArticlesOfflineAutomatically -bool true" \
    "Save Reading List articles for offline reading"

# Extensions
execute "defaults write com.apple.Safari ExtensionsEnabled -bool true" \
    "Enable Safari extensions"

execute "defaults write com.apple.Safari CanPromptForPushNotifications -bool false" \
    "Disable push notification prompts"

# Tab Settings
execute "defaults write com.apple.Safari ShowStandaloneTabBar -bool true" \
    "Always show tab bar"

execute "defaults write com.apple.Safari OpenNewTabsInFront -bool false" \
    "Don't activate new tabs"

execute "defaults write com.apple.Safari TabMinWidth -int 100" \
    "Set minimum tab width"

# PDF Settings
execute "defaults write com.apple.Safari WebKitOmitPDFSupport -bool true" \
    "Open PDFs in system viewer instead of Safari"

# History Settings
execute "defaults write com.apple.Safari HistoryAgeInDaysLimit -int 7" \
    "Set history items to expire after one week"

# Restart Safari
execute "killall Safari" \
    "Restart Safari"
