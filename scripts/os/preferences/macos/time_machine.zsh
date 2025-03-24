#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Time Machine\n\n"

# General Settings
execute "sudo tmutil enable" \
    "Enable Time Machine"

execute "defaults write com.apple.TimeMachine AutoBackup -bool true" \
    "Enable automatic backups"

execute "defaults write com.apple.TimeMachine PreventAutoBackup -bool false" \
    "Allow automatic backups"

execute "defaults write com.apple.TimeMachine AlwaysShowDeletedBackupsWarning -bool true" \
    "Show warning before deleting backups"

# Backup Frequency
execute "defaults write com.apple.TimeMachine BackupInterval -int 3600" \
    "Set backup interval to 1 hour"

execute "defaults write com.apple.TimeMachine BackupSizeMB -int 0" \
    "Reset backup size counter"

execute "defaults write com.apple.TimeMachine BackupSkipSystemFiles -bool false" \
    "Include system files in backup"

execute "defaults write com.apple.TimeMachine MaxSize -integer 524288" \
    "Set maximum backup size to 512GB"

# Notifications and UI
execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool false" \
    "Show Time Machine prompts for new disks"

execute "defaults write com.apple.TimeMachine ShowPreviousVersionsAsNotifications -bool true" \
    "Show previous versions as notifications"

execute "defaults write com.apple.TimeMachine AlwaysShowBackupProgress -bool true" \
    "Always show backup progress"

execute "defaults write com.apple.TimeMachine ShowUnsupportedNetworkVolumes -bool true" \
    "Show unsupported network volumes"

# Menu Bar
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/TimeMachine.menu'" \
    "Show Time Machine in menu bar"

execute "defaults write com.apple.TimeMachine TMShowUnsupportedNetworkVolumes -bool true" \
    "Show unsupported network volumes in menu"

execute "defaults write com.apple.TimeMachine TMMenuBarShowTime -bool true" \
    "Show time in menu bar item"

# Exclusions
# Add directories to exclude from Time Machine backups
BACKUP_EXCLUSIONS=(
    "${HOME}/Downloads"           # Downloads folder
    "${HOME}/Library/Caches"      # Cache files
    "${HOME}/.Trash"             # Trash
    "${HOME}/node_modules"       # Node.js modules
    "${HOME}/.venv"              # Python virtual environments
    "${HOME}/.cache"             # Cache directories
    "${HOME}/.docker"            # Docker data
    "${HOME}/.gradle"            # Gradle cache
    "${HOME}/.m2"                # Maven cache
    "${HOME}/.npm"               # npm cache
    "${HOME}/.yarn"              # Yarn cache
    "${HOME}/.composer"          # Composer cache
    "${HOME}/.cargo"             # Rust cargo cache
    "${HOME}/.gem"               # Ruby gems
    "${HOME}/.android"           # Android SDK
    "${HOME}/Library/Developer"  # Developer tools
    "${HOME}/Library/Logs"       # System logs
    "${HOME}/Library/Application Support/Steam" # Steam games
)

for exclusion in $BACKUP_EXCLUSIONS; do
    execute "sudo tmutil addexclusion '$exclusion'" \
        "Exclude $exclusion from backups"
done

# Performance Settings
execute "sudo sysctl debug.lowpri_throttle_enabled=1" \
    "Enable low priority throttling"

execute "defaults write com.apple.TimeMachine ThrottleInterval -int 10" \
    "Set throttle interval to 10 seconds"

execute "defaults write com.apple.TimeMachine MaxConcurrentBackups -int 1" \
    "Set maximum concurrent backups"

execute "defaults write com.apple.TimeMachine BackupQueuePriority -int 4" \
    "Set backup queue priority"

# Local Snapshots
execute "sudo tmutil enablelocal" \
    "Enable local snapshots"

execute "defaults write com.apple.TimeMachine LocalizedDiskImageVolumeName -string 'Backup'" \
    "Set backup volume name"

execute "defaults write com.apple.TimeMachine MaxLocalSnapshots -int 10" \
    "Set maximum local snapshots"

execute "defaults write com.apple.TimeMachine LocalSnapshotInterval -int 3600" \
    "Set local snapshot interval to 1 hour"

# Network Settings
execute "defaults write com.apple.TimeMachine RequiresACPower -bool false" \
    "Allow backups on battery power"

execute "defaults write com.apple.TimeMachine MobileBackups -bool true" \
    "Enable mobile backups"

execute "defaults write com.apple.TimeMachine NetworkBackupEnabled -bool true" \
    "Enable network backups"

execute "defaults write com.apple.TimeMachine NetworkBackupThrottleEnabled -bool true" \
    "Enable network backup throttling"

# Backup Retention
execute "sudo tmutil setretainuntildate none" \
    "Clear retention settings"

execute "defaults write com.apple.TimeMachine RetainUntilDate -date '2030-12-31 23:59:59 +0000'" \
    "Set retention until end of 2030"

execute "defaults write com.apple.TimeMachine DeleteOldBackups -bool false" \
    "Keep old backups"

# Backup Verification
execute "defaults write com.apple.TimeMachine SkipSystemFiles -bool false" \
    "Include system files in backups"

execute "defaults write com.apple.TimeMachine VerifyBackups -bool true" \
    "Enable backup verification"

execute "defaults write com.apple.TimeMachine SkipPaths -array" \
    "Clear skip paths"

# Backup Encryption
execute "defaults write com.apple.TimeMachine EncryptBackup -bool true" \
    "Enable backup encryption"

execute "defaults write com.apple.TimeMachine UseEncryption -bool true" \
    "Use encryption for new backups"

execute "defaults write com.apple.TimeMachine EncryptionStrength -int 256" \
    "Set encryption strength to 256-bit"

# Backup Destination
execute "defaults write com.apple.TimeMachine PreferredDestination -string ''" \
    "Clear preferred backup destination"

execute "defaults write com.apple.TimeMachine AlternateDestination -string ''" \
    "Clear alternate backup destination"

execute "defaults write com.apple.TimeMachine RequiresDestination -bool true" \
    "Require backup destination"

# Backup Status
execute "defaults write com.apple.TimeMachine AutoBackupOnBattery -bool true" \
    "Enable backups on battery"

execute "defaults write com.apple.TimeMachine ShowBackupProgress -bool true" \
    "Show backup progress"

execute "defaults write com.apple.TimeMachine BackupStatusShowProgress -bool true" \
    "Show detailed backup progress"

# Cleanup and Maintenance
execute "sudo tmutil disablelocal" \
    "Disable local snapshots temporarily"

execute "sudo tmutil enablelocal" \
    "Re-enable local snapshots"

execute "sudo tmutil startbackup --auto" \
    "Start automatic backup"

execute "sudo tmutil disable" \
    "Temporarily disable Time Machine"

execute "sudo tmutil enable" \
    "Re-enable Time Machine"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"
