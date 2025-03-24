#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Spotlight\n\n"

# Spotlight Categories
execute "defaults write com.apple.spotlight orderedItems -array \
    '{enabled = 1; name = APPLICATIONS;}' \
    '{enabled = 1; name = SYSTEM_PREFS;}' \
    '{enabled = 1; name = DIRECTORIES;}' \
    '{enabled = 1; name = PDF;}' \
    '{enabled = 1; name = DOCUMENTS;}' \
    '{enabled = 1; name = IMAGES;}' \
    '{enabled = 1; name = MUSIC;}' \
    '{enabled = 1; name = MOVIES;}' \
    '{enabled = 0; name = PRESENTATIONS;}' \
    '{enabled = 0; name = SPREADSHEETS;}' \
    '{enabled = 0; name = MESSAGES;}' \
    '{enabled = 0; name = CONTACT;}' \
    '{enabled = 0; name = EVENT_TODO;}' \
    '{enabled = 0; name = BOOKMARKS;}' \
    '{enabled = 0; name = FONTS;}' \
    '{enabled = 0; name = MENU_DEFINITION;}' \
    '{enabled = 0; name = MENU_CONVERSION;}' \
    '{enabled = 0; name = MENU_OTHER;}' \
    '{enabled = 0; name = MENU_EXPRESSION;}' \
    '{enabled = 0; name = SOURCE;}'" \
    "Configure Spotlight search categories"

# Spotlight Exclusions
# Add directories to exclude from Spotlight indexing
SPOTLIGHT_EXCLUSIONS=(
    "/Volumes/*"              # External drives
    "${HOME}/Downloads"       # Downloads folder
    "${HOME}/Library"         # Library folder
    "${HOME}/.Trash"         # Trash
    "${HOME}/.git"           # Git repositories
    "${HOME}/node_modules"   # Node.js modules
    "${HOME}/.venv"          # Python virtual environments
    "${HOME}/.cache"         # Cache directories
    "${HOME}/.npm"          # NPM cache
    "${HOME}/.gradle"       # Gradle cache
    "${HOME}/.docker"       # Docker data
    "${HOME}/.m2"          # Maven repository
    "${HOME}/.cargo"       # Rust cargo cache
    "${HOME}/.composer"    # Composer cache
)

for exclusion in $SPOTLIGHT_EXCLUSIONS; do
    execute "sudo mdutil -i off '$exclusion' 2>/dev/null" \
        "Disable Spotlight indexing for $exclusion"
    execute "sudo rm -rf /.Spotlight-V100/Store-V*" \
        "Remove Spotlight index for $exclusion"
done

# Spotlight Privacy
execute "defaults write com.apple.spotlight menuEnabled -bool true" \
    "Enable Spotlight menu"

execute "defaults write com.apple.spotlight showedFTE -bool true" \
    "Disable first-time experience"

execute "defaults write com.apple.spotlight DiscoverableByOtherDevices -bool false" \
    "Disable discoverable by other devices"

# Spotlight Suggestions
execute "defaults write com.apple.spotlight SUEnableLocalSpotlightSuggestions -bool false" \
    "Disable local Spotlight suggestions"

execute "defaults write com.apple.spotlight SUEnableSpotlightSuggestions -bool false" \
    "Disable Spotlight suggestions"

execute "defaults write com.apple.spotlight SUEnableSpotlightInternetResults -bool false" \
    "Disable Internet-based suggestions"

execute "defaults write com.apple.spotlight SUEnableSpotlightDiagnostics -bool false" \
    "Disable Spotlight diagnostics"

# Spotlight Performance
execute "defaults write com.apple.spotlight SUEnableConcurrentIndexing -bool true" \
    "Enable concurrent indexing"

execute "defaults write com.apple.spotlight SUEnableBackgroundIndexing -bool true" \
    "Enable background indexing"

execute "defaults write com.apple.spotlight indexingPriority -int 1" \
    "Set indexing priority to low"

execute "defaults write com.apple.spotlight disableHotkeys -bool false" \
    "Enable Spotlight hotkeys"

# Spotlight Interface
execute "defaults write com.apple.spotlight SUWindowLevel -int 1" \
    "Set Spotlight window level"

execute "defaults write com.apple.spotlight SUStatusMenuIconType -int 1" \
    "Set Spotlight menu bar icon type"

execute "defaults write com.apple.spotlight SUDefaultsWindowLevel -int 1000" \
    "Set Spotlight window level above other windows"

execute "defaults write com.apple.spotlight SUWindowAlpha -float 0.95" \
    "Set Spotlight window transparency"

# Spotlight Search Results
execute "defaults write com.apple.spotlight SUMaximumResults -int 20" \
    "Set maximum number of search results"

execute "defaults write com.apple.spotlight SUOrderByScore -bool true" \
    "Order results by relevance score"

execute "defaults write com.apple.spotlight SUShowInPreview -bool true" \
    "Show results in Preview"

# Spotlight Keyboard Shortcuts
execute "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '
<dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
        <key>parameters</key>
        <array>
            <integer>65535</integer>
            <integer>49</integer>
            <integer>1048576</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'" \
    "Set Spotlight keyboard shortcut to Command + Space"

# Spotlight Language & Region
execute "defaults write com.apple.spotlight SUEnableMultilingualSpotlight -bool true" \
    "Enable multilingual support"

execute "defaults write com.apple.spotlight SURegionSensitive -bool true" \
    "Enable region-sensitive search"

# Spotlight History
execute "defaults write com.apple.spotlight SUEnableHistoryAPI -bool false" \
    "Disable Spotlight history"

execute "defaults write com.apple.spotlight SUEnableHistoryService -bool false" \
    "Disable history service"

# Restart Spotlight
execute "killall mds" \
    "Kill Spotlight indexing process"

execute "sudo mdutil -i on / &>/dev/null" \
    "Enable Spotlight indexing for root volume"

execute "sudo mdutil -E / &>/dev/null" \
    "Rebuild Spotlight index for root volume"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"
