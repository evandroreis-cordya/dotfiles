#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# Default values
HOSTNAME="$1"
USERNAME="$2"
EMAIL="$3"
SELECTED_CATEGORIES="$4"  # Comma-separated list of categories to run

# Minimum supported macOS version
MINIMUM_MACOS_VERSION="14.0.0"  # macOS Sonoma

# Function to check macOS version compatibility
check_macos_compatibility() {
    local current_version=$(sw_vers -productVersion)
    
    print_in_yellow "\n >> Checking macOS version compatibility\n"
    print_in_yellow "   Current macOS version: $current_version\n"
    print_in_yellow "   Minimum supported version: $MINIMUM_MACOS_VERSION\n"
    
    if is_supported_version "$current_version" "$MINIMUM_MACOS_VERSION"; then
        print_success "macOS version is compatible"
        return 0
    else
        print_error "Your macOS version ($current_version) is not supported"
        print_in_yellow "Please upgrade to macOS Sonoma ($MINIMUM_MACOS_VERSION) or later before running these preference scripts.\n"
        return 1
    fi
}

# Function to run a preference script with error handling
run_preference_script() {
    local script="$1"
    local script_name=$(basename "$script")
    
    if [[ -f "$script" && -x "$script" ]]; then
        print_in_yellow "Running $script_name...\n"
        "$script" 2>/tmp/preference_error_$$.log
        
        if [[ $? -ne 0 ]]; then
            print_warning "Warning: $script_name encountered issues"
            if [[ -s /tmp/preference_error_$$.log ]]; then
                print_in_yellow "Error details:\n"
                cat /tmp/preference_error_$$.log
            fi
        else
            print_success "$script_name completed successfully"
        fi
        
        rm -f /tmp/preference_error_$$.log
    else
        print_warning "Script $script_name not found or not executable"
    fi
}

# Function to check if a category is selected
is_category_selected() {
    local category="$1"
    
    # If no categories specified, run all
    if [[ -z "$SELECTED_CATEGORIES" ]]; then
        return 0
    fi
    
    # Check if category is in the comma-separated list
    if [[ "$SELECTED_CATEGORIES" == "all" ]]; then
        return 0
    fi
    
    if [[ "$SELECTED_CATEGORIES" == *"$category"* ]]; then
        local IFS=','
        for selected in $SELECTED_CATEGORIES; do
            if [[ "$selected" == "$category" ]]; then
                return 0
            fi
        done
    fi
    
    return 1
}

print_in_yellow "\n\n"
print_in_yellow "   ------------------------------------------------------\n"
print_in_yellow "   Configuring system and application preferences\n"
print_in_yellow "   ------------------------------------------------------\n\n"

# Check macOS compatibility before proceeding
if ! check_macos_compatibility; then
    print_in_red "\nAborting preferences configuration due to incompatible macOS version.\n"
    exit 1
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Close any open System Preferences panes to prevent
# overriding the preferences that are being changed.
if [[ -f "./close_system_preferences_panes.applescript" ]]; then
    print_in_yellow "Closing any open System Settings panes...\n"
    ./close_system_preferences_panes.applescript
else
    print_warning "close_system_preferences_panes.applescript not found"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n >> Applying Selected System Preferences\n\n"

# Define all available preference scripts with their categories
typeset -A PREFERENCE_SCRIPTS
PREFERENCE_SCRIPTS=(
    "./accessibility.zsh" "Accessibility"
    "./app_store.zsh" "App Store"
    "./bluetooth.zsh" "Bluetooth"
    "./chrome.zsh" "Chrome"
    "./dashboard.zsh" "Dashboard"
    "./date_time.zsh" "Date and Time"
    "./dock.zsh" "Dock"
    "./energy.zsh" "Energy"
    "./finder.zsh" "Finder"
    "./firefox.zsh" "Firefox"
    "./icloud.zsh" "iCloud"
    "./keyboard.zsh" "Keyboard"
    "./language.zsh" "Language"
    "./language_and_region.zsh" "Language and Region"
    "./mail.zsh" "Mail"
    "./maps.zsh" "Maps"
    "./messages.zsh" "Messages"
    "./mission_control.zsh" "Mission Control"
    "./mouse.zsh" "Mouse"
    "./music.zsh" "Music"
    "./network.zsh" "Network"
    "./notifications.zsh" "Notifications"
    "./photos.zsh" "Photos"
    "./safari.zsh" "Safari"
    "./screen.zsh" "Screen"
    "./security.zsh" "Security"
    "./sharing.zsh" "Sharing"
    "./siri.zsh" "Siri"
    "./software_update.zsh" "Software Update"
    "./sound.zsh" "Sound"
    "./spotlight.zsh" "Spotlight"
    "./system.zsh" "System"
    "./terminal.zsh" "Terminal"
    "./textedit.zsh" "TextEdit"
    "./time_machine.zsh" "Time Machine"
    "./trackpad.zsh" "Trackpad"
    "./ui.zsh" "UI"
)

# Special handling for UI and UX script with hostname parameter
if [[ -f "./ui_and_ux.zsh" && -x "./ui_and_ux.zsh" ]]; then
    if is_category_selected "UI"; then
        print_in_yellow "Running ui_and_ux.zsh with hostname parameter...\n"
        ./ui_and_ux.zsh "$HOSTNAME"
        print_success "ui_and_ux.zsh completed"
    else
        print_in_yellow "Skipping ui_and_ux.zsh (not selected)\n"
    fi
fi

# Run users_groups script if selected
if [[ -f "./users_groups.zsh" && -x "./users_groups.zsh" ]]; then
    if is_category_selected "System"; then
        print_in_yellow "Running users_groups.zsh...\n"
        ./users_groups.zsh
        print_success "users_groups.zsh completed"
    else
        print_in_yellow "Skipping users_groups.zsh (not selected)\n"
    fi
fi

# Run selected preference scripts
for script in ${(k)PREFERENCE_SCRIPTS}; do
    category="${PREFERENCE_SCRIPTS[$script]}"
    
    if is_category_selected "$category"; then
        run_preference_script "$script"
    else
        script_name=$(basename "$script")
        print_in_yellow "Skipping $script_name (not selected)\n"
    fi
done

print_in_purple "\n >> System preferences configuration completed\n\n"

# Application Preferences
# Add application preferences scripts here if needed

print_in_purple "\n >> All selected preferences have been configured\n\n"
print_in_yellow "Note: Some changes may require a system restart to take effect.\n"
