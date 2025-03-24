#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Music\n\n"

# General Settings
execute "defaults write com.apple.Music automaticallySyncWhenDeviceIsConnected -bool false" \
    "Disable automatic device syncing"

execute "defaults write com.apple.Music dontAutomaticallyDownloadArtwork -bool true" \
    "Don't automatically download artwork"

execute "defaults write com.apple.Music automaticallyDownloadArtwork -bool false" \
    "Don't automatically download artwork in the background"

execute "defaults write com.apple.Music userWantsPlaybackNotifications -bool false" \
    "Disable playback notifications"

# Library Settings
execute "defaults write com.apple.Music libraryViewMode -int 2" \
    "Set library view mode to Songs"

execute "defaults write com.apple.Music showRatingColumn -bool true" \
    "Show rating column"

execute "defaults write com.apple.Music showGenreColumn -bool true" \
    "Show genre column"

execute "defaults write com.apple.Music showComposerColumn -bool true" \
    "Show composer column"

# Playback Settings
execute "defaults write com.apple.Music playbackRestoreEnabled -bool true" \
    "Remember playback position"

execute "defaults write com.apple.Music crossFadeEnabled -bool false" \
    "Disable cross-fade between songs"

execute "defaults write com.apple.Music soundCheckEnabled -bool true" \
    "Enable Sound Check"

execute "defaults write com.apple.Music volumeAdjustment -int 0" \
    "Reset volume adjustment"

# Device Backup Settings
execute "defaults write com.apple.Music deviceBackupsEnabled -bool false" \
    "Disable automatic device backups"

execute "defaults write com.apple.Music deviceBackupsDisabled -bool true" \
    "Prevent device backups"

execute "defaults write com.apple.Music dontAutomaticallySync -bool true" \
    "Don't automatically sync devices"

# Store Settings
execute "defaults write com.apple.Music restrictStoreBrowsing -bool true" \
    "Restrict store browsing"

execute "defaults write com.apple.Music showStoreInSidebar -bool false" \
    "Hide store in sidebar"

execute "defaults write com.apple.Music showStoreFrontInSidebar -bool false" \
    "Hide store front in sidebar"

execute "defaults write com.apple.Music disableStoreUI -bool true" \
    "Disable store UI"

# Sharing Settings
execute "defaults write com.apple.Music enableSharedLibrary -bool false" \
    "Disable shared library"

execute "defaults write com.apple.Music sharingEnabled -bool false" \
    "Disable sharing"

execute "defaults write com.apple.Music allowSharedLibraries -bool false" \
    "Don't allow shared libraries"

execute "defaults write com.apple.Music disableAirPlay -bool true" \
    "Disable AirPlay"

# Interface Settings
execute "defaults write com.apple.Music showStatusBar -bool true" \
    "Show status bar"

execute "defaults write com.apple.Music showSourceInTitle -bool true" \
    "Show source in window title"

execute "defaults write com.apple.Music showTimeInTitle -bool true" \
    "Show time in window title"

execute "defaults write com.apple.Music showMusicInTitle -bool true" \
    "Show current track in window title"

# Column Browser Settings
execute "defaults write com.apple.Music columnBrowserGenreShown -bool true" \
    "Show genre in column browser"

execute "defaults write com.apple.Music columnBrowserArtistShown -bool true" \
    "Show artist in column browser"

execute "defaults write com.apple.Music columnBrowserAlbumShown -bool true" \
    "Show album in column browser"

execute "defaults write com.apple.Music columnBrowserComposerShown -bool true" \
    "Show composer in column browser"

# Import Settings
execute "defaults write com.apple.Music automaticallyAddToLibrary -bool false" \
    "Don't automatically add songs to library"

execute "defaults write com.apple.Music copyFilesToLibrary -bool true" \
    "Copy files to Music Media folder when adding"

execute "defaults write com.apple.Music keepArrangedByFolders -bool true" \
    "Keep Music Media folder organized"

execute "defaults write com.apple.Music importPlaylistMetadata -bool true" \
    "Import playlist metadata"

# Advanced Settings
execute "defaults write com.apple.Music warnBeforeNetworkAccess -bool true" \
    "Warn before accessing network media"

execute "defaults write com.apple.Music warnBeforeRemovingFromLibrary -bool true" \
    "Warn before removing from library"

execute "defaults write com.apple.Music warnBeforeRevertingToDefault -bool true" \
    "Warn before reverting to default settings"

execute "defaults write com.apple.Music dontWarnAboutPlaylistChanges -bool false" \
    "Show warning about playlist changes"

# Equalizer Settings
execute "defaults write com.apple.Music showEQ -bool true" \
    "Show equalizer"

execute "defaults write com.apple.Music autoshowEQ -bool false" \
    "Don't automatically show equalizer"

execute "defaults write com.apple.Music EQEnabled -bool false" \
    "Disable equalizer by default"

execute "defaults write com.apple.Music EQPreset -string 'Flat'" \
    "Set equalizer preset to Flat"

# Mini Player Settings
execute "defaults write com.apple.Music MiniPlayerWindowStyle -int 0" \
    "Set mini player style"

execute "defaults write com.apple.Music MiniPlayerFullScreenEnabled -bool false" \
    "Disable mini player in full screen"

execute "defaults write com.apple.Music dontShowMiniPlayer -bool true" \
    "Don't show mini player when closing window"

# Lyrics Settings
execute "defaults write com.apple.Music automaticallyDownloadLyrics -bool false" \
    "Don't automatically download lyrics"

execute "defaults write com.apple.Music showLyrics -bool false" \
    "Don't show lyrics by default"

execute "defaults write com.apple.Music showFloatingLyricsWindow -bool false" \
    "Don't show floating lyrics window"

# Privacy Settings
execute "defaults write com.apple.Music allowMediaAnalysis -bool false" \
    "Disable media analysis"

execute "defaults write com.apple.Music submitDiagnosticData -bool false" \
    "Don't submit diagnostic data"

execute "defaults write com.apple.Music allowPlaylistRecommendations -bool false" \
    "Don't allow playlist recommendations"

# Restart Music
execute "killall Music" \
    "Restart Music"
