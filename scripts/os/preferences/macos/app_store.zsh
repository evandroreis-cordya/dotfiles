#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   App Store\n\n"

# General Settings
execute "defaults write com.apple.appstore ShowDebugMenu -bool true" \
    "Enable debug menu"

execute "defaults write com.apple.appstore WebKitDeveloperExtras -bool true" \
    "Enable WebKit Developer Extras"

execute "defaults write com.apple.appstore ShowInternalFeatures -bool true" \
    "Show internal features"

execute "defaults write com.apple.appstore ShowPreReleaseUpdates -bool true" \
    "Show pre-release updates"

# Update Settings
execute "defaults write com.apple.commerce AutoUpdate -bool true" \
    "Enable auto-update"

execute "defaults write com.apple.commerce AutoUpdateRestartRequired -bool true" \
    "Allow restart if required for updates"

execute "defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true" \
    "Enable automatic update check"

execute "defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1" \
    "Download newly available updates in background"

execute "defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1" \
    "Install system data files and security updates"

execute "defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1" \
    "Install configuration data files"

# Download Settings
execute "defaults write com.apple.appstore AutomaticDailyUpdatesEnabled -bool true" \
    "Enable automatic daily updates"

execute "defaults write com.apple.appstore AutomaticDownload -bool true" \
    "Enable automatic downloads"

execute "defaults write com.apple.appstore AllowMultipleDownloads -bool true" \
    "Allow multiple downloads"

execute "defaults write com.apple.appstore AutomaticCheckEnabled -bool true" \
    "Enable automatic check for updates"

# Installation Settings
execute "defaults write com.apple.appstore InstallAppUpdatesInBackground -bool true" \
    "Install app updates in background"

execute "defaults write com.apple.appstore AllowPreReleaseInstallation -bool false" \
    "Disable pre-release installation"

execute "defaults write com.apple.appstore AutomaticInstallEnabled -bool true" \
    "Enable automatic installation"

execute "defaults write com.apple.appstore AutomaticInstallDeviceUpdates -bool true" \
    "Enable automatic device updates"

# Notification Settings
execute "defaults write com.apple.appstore NotifyAvailableUpdates -bool true" \
    "Enable update notifications"

execute "defaults write com.apple.appstore ShowUpdatesNotifications -bool true" \
    "Show update notifications"

execute "defaults write com.apple.appstore NotifyDownloadComplete -bool true" \
    "Show download complete notifications"

execute "defaults write com.apple.appstore NotifyInstallComplete -bool true" \
    "Show installation complete notifications"

# Security Settings
execute "defaults write com.apple.appstore RequireAdminPasswordForActions -bool true" \
    "Require admin password for actions"

execute "defaults write com.apple.appstore RestrictStoreBrowsing -bool false" \
    "Allow store browsing"

execute "defaults write com.apple.appstore RestrictStoreRequirePassword -bool true" \
    "Require password for store actions"

execute "defaults write com.apple.appstore EnableAppInstallation -bool true" \
    "Enable app installation"

# Network Settings
execute "defaults write com.apple.appstore AllowContentCaching -bool true" \
    "Enable content caching"

execute "defaults write com.apple.appstore NetworkUsageOptimizationEnabled -bool true" \
    "Enable network usage optimization"

execute "defaults write com.apple.appstore PreferCellularData -bool false" \
    "Prefer Wi-Fi over cellular data"

execute "defaults write com.apple.appstore BackgroundDownloadEnabled -bool true" \
    "Enable background downloads"

# Privacy Settings
execute "defaults write com.apple.appstore SendDiagnosticData -bool false" \
    "Disable sending diagnostic data"

execute "defaults write com.apple.appstore SubmitAnalytics -bool false" \
    "Disable analytics submission"

execute "defaults write com.apple.appstore AllowPersonalization -bool false" \
    "Disable personalization"

execute "defaults write com.apple.appstore AllowTargetedAds -bool false" \
    "Disable targeted ads"

# Interface Settings
execute "defaults write com.apple.appstore ShowRatings -bool true" \
    "Show app ratings"

execute "defaults write com.apple.appstore ShowReviews -bool true" \
    "Show app reviews"

execute "defaults write com.apple.appstore ShowRecentSearches -bool false" \
    "Hide recent searches"

execute "defaults write com.apple.appstore ShowSuggestedApps -bool false" \
    "Hide suggested apps"

# Storage Settings
execute "defaults write com.apple.appstore CacheStorageEnabled -bool true" \
    "Enable cache storage"

execute "defaults write com.apple.appstore MaxConcurrentDownloads -int 3" \
    "Set maximum concurrent downloads to 3"

execute "defaults write com.apple.appstore MaxCacheSize -int 10240" \
    "Set maximum cache size to 10GB"

execute "defaults write com.apple.appstore AutomaticCacheCleanupEnabled -bool true" \
    "Enable automatic cache cleanup"

# In-App Purchase Settings
execute "defaults write com.apple.appstore RequirePasswordForInAppPurchase -bool true" \
    "Require password for in-app purchases"

execute "defaults write com.apple.appstore RestrictInAppPurchase -bool false" \
    "Allow in-app purchases"

execute "defaults write com.apple.appstore InAppPurchaseTimeout -int 300" \
    "Set in-app purchase timeout to 5 minutes"

# Beta Program Settings
execute "defaults write com.apple.appstore EnableBetaProgram -bool false" \
    "Disable beta program"

execute "defaults write com.apple.appstore ShowBetaUpdates -bool false" \
    "Hide beta updates"

execute "defaults write com.apple.appstore BetaProgramOptIn -bool false" \
    "Opt out of beta program"

# Restart App Store
execute "killall 'App Store'" \
    "Restart App Store"

# Restart related services
execute "killall storeaccountd" \
    "Restart store account daemon"

execute "killall storeassetd" \
    "Restart store asset daemon"

execute "killall storedownloadd" \
    "Restart store download daemon"

execute "killall storeinstalld" \
    "Restart store install daemon"
