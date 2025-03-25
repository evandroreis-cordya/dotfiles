#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# Default values
HOSTNAME="$1"
USERNAME="$2"
EMAIL="$3"

print_in_yellow "\n\n"
print_in_yellow "   ------------------------------------------------------\n"
print_in_yellow "   Configuring system and application preferences\n"
print_in_yellow "   ------------------------------------------------------\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Close any open System Preferences panes to prevent
# overriding the preferences that are being changed.

./close_system_preferences_panes.applescript

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# System Preferences
./accessibility.zsh
./ai_desktop_tools.zsh
./ai_tools.zsh
./amazon_ai_tools.zsh
./anthropic_tools.zsh
./app_store.zsh
./autonomous_agents.zsh
./azure_ai_tools.zsh
./backend_tools.zsh
./bluetooth.zsh
./browser_tools.zsh
./cerebras_tools.zsh
./chrome.zsh
./cloud_tools.zsh
./communication_tools.zsh
./creative_tools.zsh
./dashboard.zsh
./date_time.zsh
./deepseek_tools.zsh
./dock.zsh
./energy.zsh
./finder.zsh
./firefox.zsh
./frontend_tools.zsh
./generative_ai.zsh
./google_ai_tools.zsh
./grok_tools.zsh
./icloud.zsh
./kaspersky_tools.zsh
./keyboard.zsh
./language.zsh
./language_and_region.zsh
./mail.zsh
./maps.zsh
./messages.zsh
./meta_ai_tools.zsh
./mission_control.zsh
./ml_tools.zsh
./mouse.zsh
./music.zsh
./network.zsh
./notifications.zsh
./nvidia_tools.zsh
./openai_tools.zsh
./oracle_ai_tools.zsh
./photos.zsh
./safari.zsh
./screen.zsh
./security.zsh
./sharing.zsh
./sidecar.zsh
./siri.zsh
./sound.zsh
./spectacle.zsh
./spotlight.zsh
./terminal.zsh
./textedit.zsh
./time_machine.zsh
./trackpad.zsh
./transmission.zsh
./ui_and_ux.zsh "$HOSTNAME"
./users_groups.zsh
./vercel_tools.zsh
./wallpaper.zsh

# Application Preferences
