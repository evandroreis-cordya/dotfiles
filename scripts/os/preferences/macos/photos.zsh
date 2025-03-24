#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Photos\n\n"

# General Settings
execute "defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true" \
    "Prevent photos from opening automatically when devices are connected"

execute "defaults write com.apple.Photos JPEGQuality -int 100" \
    "Set JPEG export quality to maximum"

execute "defaults write com.apple.Photos PVEnableAutoPlay -bool false" \
    "Disable auto-play for videos and Live Photos"

execute "defaults write com.apple.Photos PVEnableAutoPlayOnFullScreen -bool false" \
    "Disable auto-play in full screen"

# Library Settings
execute "defaults write com.apple.Photos PHPhotoLibraryMigrationIsComplete -bool true" \
    "Mark photo library migration as complete"

execute "defaults write com.apple.Photos PHPhotoLibraryUpgradeIsInProgress -bool false" \
    "Mark photo library upgrade as not in progress"

execute "defaults write com.apple.Photos PHPhotoLibraryUpgradeAvailable -bool false" \
    "Mark photo library upgrade as not available"

# iCloud Settings
execute "defaults write com.apple.Photos ICloudPhotoLibraryUploadIsComplete -bool true" \
    "Mark iCloud photo library upload as complete"

execute "defaults write com.apple.Photos ICloudPhotoLibraryDownloadIsComplete -bool true" \
    "Mark iCloud photo library download as complete"

execute "defaults write com.apple.Photos ICloudPhotoLibraryPreferences -dict-add Enabled -bool false" \
    "Disable iCloud Photo Library"

# Privacy Settings
execute "defaults write com.apple.Photos PHPhotoLibraryLocationServicesEnabled -bool false" \
    "Disable location services"

execute "defaults write com.apple.Photos PHPhotoLibraryFaceDetectionEnabled -bool false" \
    "Disable face detection"

execute "defaults write com.apple.Photos PHPhotoLibrarySceneDetectionEnabled -bool false" \
    "Disable scene detection"

execute "defaults write com.apple.Photos PHPhotoLibraryObjectDetectionEnabled -bool false" \
    "Disable object detection"

# View Settings
execute "defaults write com.apple.Photos PVDisplayTitles -bool true" \
    "Show photo titles"

execute "defaults write com.apple.Photos PVDisplayKeywords -bool true" \
    "Show keywords"

execute "defaults write com.apple.Photos PVDisplayLocation -bool true" \
    "Show location information"

execute "defaults write com.apple.Photos PVDisplayFaces -bool false" \
    "Hide face information"

# Interface Settings
execute "defaults write com.apple.Photos PVDisplaySidebar -bool true" \
    "Show sidebar"

execute "defaults write com.apple.Photos PVDisplayToolbar -bool true" \
    "Show toolbar"

execute "defaults write com.apple.Photos PVDisplayStatusBar -bool true" \
    "Show status bar"

execute "defaults write com.apple.Photos PVDisplayTabBar -bool false" \
    "Hide tab bar"

# Import Settings
execute "defaults write com.apple.Photos PVImportDeleteAfterImport -bool false" \
    "Don't delete items after import"

execute "defaults write com.apple.Photos PVImportCopyItems -bool true" \
    "Copy items to library"

execute "defaults write com.apple.Photos PVImportGroupByDate -bool true" \
    "Group imported items by date"

execute "defaults write com.apple.Photos PVImportSkipDuplicates -bool true" \
    "Skip duplicate items during import"

# Export Settings
execute "defaults write com.apple.Photos PVExportCompressionFactor -float 1.0" \
    "Set export compression to maximum quality"

execute "defaults write com.apple.Photos PVExportIncludeMetadata -bool true" \
    "Include metadata when exporting"

execute "defaults write com.apple.Photos PVExportIncludeLocation -bool false" \
    "Don't include location when exporting"

execute "defaults write com.apple.Photos PVExportIncludeFaces -bool false" \
    "Don't include face data when exporting"

# Slideshow Settings
execute "defaults write com.apple.Photos PVSlideshowDuration -float 3.0" \
    "Set slideshow duration to 3 seconds per slide"

execute "defaults write com.apple.Photos PVSlideshowMusicVolume -float 0.5" \
    "Set slideshow music volume to 50%"

execute "defaults write com.apple.Photos PVSlideshowRepeat -bool false" \
    "Don't repeat slideshow"

execute "defaults write com.apple.Photos PVSlideshowShuffle -bool false" \
    "Don't shuffle slideshow"

# Memory Settings
execute "defaults write com.apple.Photos PVMemoriesEnabled -bool false" \
    "Disable Memories feature"

execute "defaults write com.apple.Photos PVMemoriesNotificationsEnabled -bool false" \
    "Disable Memories notifications"

execute "defaults write com.apple.Photos PVMemoriesSuggestionsEnabled -bool false" \
    "Disable Memories suggestions"

# Search Settings
execute "defaults write com.apple.Photos PVSearchEnabled -bool true" \
    "Enable search"

execute "defaults write com.apple.Photos PVSearchSuggestionsEnabled -bool false" \
    "Disable search suggestions"

execute "defaults write com.apple.Photos PVSearchHistoryEnabled -bool false" \
    "Disable search history"

# Performance Settings
execute "defaults write com.apple.Photos PVThumbnailQuality -string 'High'" \
    "Set thumbnail quality to high"

execute "defaults write com.apple.Photos PVPreviewQuality -string 'High'" \
    "Set preview quality to high"

execute "defaults write com.apple.Photos PVCacheSize -int 1024" \
    "Set cache size to 1GB"

# Restart Photos
killall "Photos" &> /dev/null
