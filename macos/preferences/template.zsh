#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Minimum supported macOS version for this script
MINIMUM_MACOS_VERSION="14.0.0"  # macOS Sonoma

# Check macOS version compatibility
check_macos_compatibility() {
    local current_version=$(sw_vers -productVersion)
    
    if ! is_supported_version "$current_version" "$MINIMUM_MACOS_VERSION"; then
        print_error "Your macOS version ($current_version) is not supported for these preferences"
        print_in_yellow "Please upgrade to macOS Sonoma ($MINIMUM_MACOS_VERSION) or later.\n"
        return 1
    fi
    
    return 0
}

# Check compatibility before proceeding
if ! check_macos_compatibility; then
    exit 1
fi

print_in_purple "\n   [PREFERENCE_CATEGORY]\n\n"

# Version-specific settings
MACOS_MAJOR_VERSION=$(sw_vers -productVersion | cut -d. -f1)

# Example of version-specific settings
if [[ $MACOS_MAJOR_VERSION -ge 14 ]]; then
    # macOS Sonoma (14.0) or later specific settings
    execute "defaults write com.example.app setting1 -bool true" \
        "Enable setting1 (Sonoma+ specific)"
elif [[ $MACOS_MAJOR_VERSION -ge 13 ]]; then
    # macOS Ventura (13.0) specific settings
    execute "defaults write com.example.app setting2 -bool true" \
        "Enable setting2 (Ventura specific)"
else
    # Fallback for older macOS versions
    execute "defaults write com.example.app legacy_setting -bool true" \
        "Enable legacy_setting (pre-Ventura)"
fi

# Common settings for all supported versions
execute "defaults write com.example.app common_setting -bool true" \
    "Enable common_setting (all versions)"

# Apply changes if needed
# execute "killall ProcessName" \
#     "Restart ProcessName"
