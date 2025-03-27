#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n >> Starting macOS setup\n\n"

# System setup scripts
if [[ "${SELECTED_GROUPS[system]}" == "true" ]]; then
    print_in_purple "\n >> Installing System Setup\n\n"
    source "${SCRIPT_DIR}/xcode.zsh"
    source "${SCRIPT_DIR}/homebrew.zsh"
    # #source "${SCRIPT_DIR}/bash.zsh"
    # source "${SCRIPT_DIR}/tmux.zsh"
    # source "${SCRIPT_DIR}/vim.zsh"
fi

# Development environments
if [[ "${SELECTED_GROUPS[dev_langs]}" == "true" ]]; then
    print_in_purple "\n >> Installing Development Languages\n\n"
    source "${SCRIPT_DIR}/python.zsh"
    source "${SCRIPT_DIR}/node.zsh"
    source "${SCRIPT_DIR}/ruby.zsh"
    source "${SCRIPT_DIR}/go.zsh"
    source "${SCRIPT_DIR}/java.zsh"
    source "${SCRIPT_DIR}/kotlin.zsh"
    source "${SCRIPT_DIR}/rust.zsh"
    source "${SCRIPT_DIR}/swift.zsh"
    source "${SCRIPT_DIR}/php.zsh"
fi

# Data Science environment
if [[ "${SELECTED_GROUPS[data_science]}" == "true" ]]; then
    print_in_purple "\n >> Installing Data Science Environment\n\n"
    source "${SCRIPT_DIR}/datascience.zsh"
fi

# Development tools
if [[ "${SELECTED_GROUPS[dev_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Development Tools\n\n"
    source "${SCRIPT_DIR}/devtools.zsh"
    source "${SCRIPT_DIR}/databasetools.zsh"
    source "${SCRIPT_DIR}/docker.zsh"
    source "${SCRIPT_DIR}/git.zsh"
    source "${SCRIPT_DIR}/gpg.zsh"
    source "${SCRIPT_DIR}/jetbrains.zsh"
    source "${SCRIPT_DIR}/visualstudiocode.zsh"
    source "${SCRIPT_DIR}/yarn.zsh"
fi

# Web and frontend tools
if [[ "${SELECTED_GROUPS[web_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Web and Frontend Tools\n\n"
    source "${SCRIPT_DIR}/frontend_tools.zsh"
    source "${SCRIPT_DIR}/backend_tools.zsh"
    source "${SCRIPT_DIR}/web_font_tools.zsh"
fi

# Daily tools and utilities
if [[ "${SELECTED_GROUPS[daily_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Daily Tools and Utilities\n\n"
    source "${SCRIPT_DIR}/browsers.zsh"
    source "${SCRIPT_DIR}/browser_tools.zsh"
    source "${SCRIPT_DIR}/compression_tools.zsh"
    source "${SCRIPT_DIR}/dailytools.zsh"
    source "${SCRIPT_DIR}/extratools.zsh"
    source "${SCRIPT_DIR}/misc.zsh"
    source "${SCRIPT_DIR}/misc_tools.zsh"
    source "${SCRIPT_DIR}/office.zsh"
    source "${SCRIPT_DIR}/apps.zsh"
fi

# Media and creative tools
if [[ "${SELECTED_GROUPS[media_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Media and Creative Tools\n\n"
    source "${SCRIPT_DIR}/video_tools.zsh"
    source "${SCRIPT_DIR}/image_tools.zsh"
    source "${SCRIPT_DIR}/creative_tools.zsh"
fi

# Cloud and DevOps tools
if [[ "${SELECTED_GROUPS[cloud_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Cloud and DevOps Tools\n\n"
    source "${SCRIPT_DIR}/cloud_tools.zsh"
    source "${SCRIPT_DIR}/security_tools.zsh"
    source "${SCRIPT_DIR}/vercel_tools.zsh"
fi

# AI and productivity tools
if [[ "${SELECTED_GROUPS[ai_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing AI and Productivity Tools\n\n"
    source "${SCRIPT_DIR}/ai_tools.zsh"
    source "${SCRIPT_DIR}/ai_desktop_tools.zsh"
    source "${SCRIPT_DIR}/amazon_ai_tools.zsh"
    source "${SCRIPT_DIR}/anthropic_tools.zsh"
    source "${SCRIPT_DIR}/autonomous_agents.zsh"
    source "${SCRIPT_DIR}/azure_ai_tools.zsh"
    source "${SCRIPT_DIR}/cerebras_tools.zsh"
    source "${SCRIPT_DIR}/communication_tools.zsh"
    source "${SCRIPT_DIR}/deepseek_tools.zsh"
    source "${SCRIPT_DIR}/generative_ai.zsh"
    source "${SCRIPT_DIR}/generative_ai_productivity.zsh"
    source "${SCRIPT_DIR}/google_ai_tools.zsh"
    source "${SCRIPT_DIR}/grok_tools.zsh"
    source "${SCRIPT_DIR}/kaspersky_tools.zsh"
    source "${SCRIPT_DIR}/meta_ai_tools.zsh"
    source "${SCRIPT_DIR}/ml_tools.zsh"
    source "${SCRIPT_DIR}/nvidia_tools.zsh"
    source "${SCRIPT_DIR}/openai_tools.zsh"
    source "${SCRIPT_DIR}/oracle_ai_tools.zsh"
fi

# App Store and system tools
if [[ "${SELECTED_GROUPS[app_store]}" == "true" ]]; then
    print_in_purple "\n >> Installing App Store and System Tools\n\n"
    source "${SCRIPT_DIR}/app_store.zsh"
    source "${SCRIPT_DIR}/mas.zsh"
fi

# Activate the Data Science environment if the activation script exists
if [[ "${SELECTED_GROUPS[data_science]}" == "true" ]]; then
    ACTIVATE_SCRIPT="$HOME/.jarvistoolset/scripts/activate_datascience.sh"
    if [[ -f "$ACTIVATE_SCRIPT" ]]; then
        print_in_purple "\n >> Activating Data Science Environment\n\n"
        print_in_yellow "  To use the Data Science environment with all installed packages, run:\n"
        print_in_green "  source $ACTIVATE_SCRIPT\n"
        print_in_yellow "  This will activate the Python virtual environment with Jupyter, Pandas, TensorFlow, and other data science packages.\n"
    fi
fi

# Always run cleanup
source "${SCRIPT_DIR}/cleanup.zsh"

print_in_purple "\n >> macOS setup completed!\n\n"

# Ask user if they want to configure macOS preferences
print_in_purple "\n >> Configure macOS Preferences\n\n"
print_in_yellow "Would you like to configure macOS preferences now? (y/n): "
read -r configure_preferences

if [[ "$configure_preferences" =~ ^[Yy]$ ]]; then
    # Path to the preferences script
    PREFERENCES_SCRIPT="$HOME/.jarvistoolset/scripts/os/preferences/macos/main.zsh"
    
    if [[ -f "$PREFERENCES_SCRIPT" && -x "$PREFERENCES_SCRIPT" ]]; then
        print_in_yellow "\nSelect which preference categories to configure:\n"
        
        # Define preference categories
        typeset -A PREF_CATEGORIES
        PREF_CATEGORIES=(
            "accessibility" "Accessibility settings"
            "app_store" "App Store settings"
            "bluetooth" "Bluetooth settings"
            "chrome" "Chrome browser settings"
            "dashboard" "Dashboard settings"
            "date_time" "Date and time settings"
            "dock" "Dock settings"
            "energy" "Energy and battery settings"
            "finder" "Finder settings"
            "firefox" "Firefox browser settings"
            "icloud" "iCloud settings"
            "keyboard" "Keyboard settings"
            "language" "Language settings"
            "mail" "Mail app settings"
            "mission_control" "Mission Control settings"
            "mouse" "Mouse settings"
            "network" "Network settings"
            "notifications" "Notification settings"
            "safari" "Safari browser settings"
            "screen" "Screen and display settings"
            "security" "Security and privacy settings"
            "sharing" "Sharing settings"
            "siri" "Siri settings"
            "software_update" "Software update settings"
            "sound" "Sound settings"
            "spotlight" "Spotlight settings"
            "system" "System settings"
            "terminal" "Terminal settings"
            "textedit" "TextEdit settings"
            "time_machine" "Time Machine settings"
            "trackpad" "Trackpad settings"
            "ui" "UI and UX settings"
        )
        
        # Create array to store selected categories
        typeset -A SELECTED_PREFS
        
        # Initialize all to false
        for category in ${(k)PREF_CATEGORIES}; do
            SELECTED_PREFS[$category]="false"
        done
        
        # Option for all categories
        print_in_yellow "0) All categories\n"
        
        # Display menu options
        i=1
        for category in ${(k)PREF_CATEGORIES}; do
            print_in_yellow "$i) ${PREF_CATEGORIES[$category]}\n"
            i=$((i+1))
        done
        
        # Add option for custom selection
        print_in_yellow "$i) Custom selection\n"
        custom_option=$i
        
        # Get user selection
        print_in_yellow "\nEnter your choice (0-$i): "
        read -r choice
        
        # Process user selection
        if [[ "$choice" == "0" ]]; then
            # Select all categories
            for category in ${(k)PREF_CATEGORIES}; do
                SELECTED_PREFS[$category]="true"
            done
            print_in_green "All preference categories selected.\n"
        elif [[ "$choice" == "$custom_option" ]]; then
            # Custom selection
            print_in_yellow "\nSelect preference categories (enter y/n for each):\n"
            
            for category in ${(k)PREF_CATEGORIES}; do
                print_in_yellow "Configure ${PREF_CATEGORIES[$category]}? (y/n): "
                read -r category_choice
                
                if [[ "$category_choice" =~ ^[Yy]$ ]]; then
                    SELECTED_PREFS[$category]="true"
                fi
            done
        elif [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice < custom_option )); then
            # Single category selected
            i=1
            for category in ${(k)PREF_CATEGORIES}; do
                if [[ "$i" == "$choice" ]]; then
                    SELECTED_PREFS[$category]="true"
                    print_in_green "${PREF_CATEGORIES[$category]} selected.\n"
                    break
                fi
                i=$((i+1))
            done
        else
            print_in_red "Invalid choice. No preferences will be configured.\n"
            exit 1
        fi
        
        # Convert selected preferences to a comma-separated list
        SELECTED_CATEGORIES=""
        for category in ${(k)SELECTED_PREFS}; do
            if [[ "${SELECTED_PREFS[$category]}" == "true" ]]; then
                if [[ -z "$SELECTED_CATEGORIES" ]]; then
                    SELECTED_CATEGORIES="$category"
                else
                    SELECTED_CATEGORIES="$SELECTED_CATEGORIES,$category"
                fi
            fi
        done
        
        # Run the preferences script with selected categories
        if [[ -n "$SELECTED_CATEGORIES" ]]; then
            print_in_yellow "\nConfiguring selected preferences...\n"
            "$PREFERENCES_SCRIPT" "" "" "" "$SELECTED_CATEGORIES"
        else
            print_in_yellow "No preferences selected. Skipping configuration.\n"
        fi
    else
        print_in_red "Preferences script not found or not executable: $PREFERENCES_SCRIPT\n"
    fi
else
    print_in_yellow "Skipping preferences configuration.\n"
fi

print_in_purple "\n >> Installation and configuration completed!\n\n"
