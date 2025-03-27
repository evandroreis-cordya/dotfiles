#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n >> Starting macOS setup\n\n"

# Create zsh_configs directory for modular configurations
mkdir -p "$HOME/.jarvistoolset/zsh_configs"
print_in_green "Created modular configuration directory at $HOME/.jarvistoolset/zsh_configs\n"

# System setup scripts
if [[ "${SELECTED_GROUPS[system]}" == "true" ]]; then
    print_in_purple "\n >> Installing System Setup\n\n"
    source "${SCRIPT_DIR}/xcode.zsh"
    source "${SCRIPT_DIR}/homebrew.zsh"
    source "${SCRIPT_DIR}/oh_my_zsh.zsh"
    # #source "${SCRIPT_DIR}/bash.zsh"
    # source "${SCRIPT_DIR}/tmux.zsh"
    # source "${SCRIPT_DIR}/vim.zsh"
else
    print_in_red "\n >> Skipping System Setup\n\n"
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
    source "${SCRIPT_DIR}/cpp.zsh"
else
    print_in_red "\n >> Skipping Development Languages\n\n"
fi

# Data Science environment
if [[ "${SELECTED_GROUPS[data_science]}" == "true" ]]; then
    print_in_purple "\n >> Installing Data Science Environment\n\n"
    source "${SCRIPT_DIR}/datascience.zsh"
    
    # Activate the Data Science environment if the activation script exists
    ACTIVATE_SCRIPT="${DIRECTORY}/scripts/activate_datascience.sh"
    if [[ -f "$ACTIVATE_SCRIPT" ]]; then
        print_in_purple "\n >> Activating Data Science Environment\n\n"
        print_in_yellow "  To use the Data Science environment with all installed packages, run:\n"
        print_in_green "  source $ACTIVATE_SCRIPT\n"
        print_in_yellow "  This will activate the Python virtual environment with Jupyter, Pandas, TensorFlow, and other data science packages.\n"
    fi
else
    print_in_red "\n >> Skipping Data Science Environment\n\n"
fi

# Development tools
if [[ "${SELECTED_GROUPS[dev_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Development Tools\n\n"
    source "${SCRIPT_DIR}/devtools.zsh"
    source "${SCRIPT_DIR}/databasetools.zsh"
    source "${SCRIPT_DIR}/docker.zsh"
    source "${SCRIPT_DIR}/git.zsh"
    source "${SCRIPT_DIR}/gpg.zsh"
    source "${SCRIPT_DIR}/security.zsh"
    source "${SCRIPT_DIR}/jetbrains.zsh"
    source "${SCRIPT_DIR}/visualstudiocode.zsh"
    source "${SCRIPT_DIR}/yarn.zsh"
else
    print_in_red "\n >> Skipping Development Tools\n\n"
fi

# Web and frontend tools
if [[ "${SELECTED_GROUPS[web_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Web and Frontend Tools\n\n"
    source "${SCRIPT_DIR}/frontend_tools.zsh"
    source "${SCRIPT_DIR}/backend_tools.zsh"
    source "${SCRIPT_DIR}/web_font_tools.zsh"
else
    print_in_red "\n >> Skipping Web and Frontend Tools\n\n"
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
else
    print_in_red "\n >> Skipping Daily Tools and Utilities\n\n"
fi

# Media and creative tools
if [[ "${SELECTED_GROUPS[media_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Media and Creative Tools\n\n"
    source "${SCRIPT_DIR}/video_tools.zsh"
    source "${SCRIPT_DIR}/image_tools.zsh"
    source "${SCRIPT_DIR}/creative_tools.zsh"
else
    print_in_red "\n >> Skipping Media and Creative Tools\n\n"
fi

# Cloud and DevOps tools
if [[ "${SELECTED_GROUPS[cloud_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Cloud and DevOps Tools\n\n"
    source "${SCRIPT_DIR}/cloud_tools.zsh"
    source "${SCRIPT_DIR}/security_tools.zsh"
    source "${SCRIPT_DIR}/vercel_tools.zsh"
else
    print_in_red "\n >> Skipping Cloud and DevOps Tools\n\n"
fi

# AI and productivity tools
if [[ "${SELECTED_GROUPS[ai_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing AI and Productivity Tools\n\n"
    source "${SCRIPT_DIR}/ai_tools.zsh"
    source "${SCRIPT_DIR}/ai_desktop_tools.zsh"
    source "${SCRIPT_DIR}/ai_bookmarks.zsh"
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
else
    print_in_red "\n >> Skipping AI and Productivity Tools\n\n"
fi

# App Store and system tools
if [[ "${SELECTED_GROUPS[app_store]}" == "true" ]]; then
    print_in_purple "\n >> Installing App Store and System Tools\n\n"
    source "${SCRIPT_DIR}/app_store.zsh"
    source "${SCRIPT_DIR}/mas.zsh"
else
    print_in_red "\n >> Skipping App Store and System Tools\n\n"
fi

# Always run cleanup
source "${SCRIPT_DIR}/cleanup.zsh"

print_in_purple "\n >> macOS setup completed!\n\n"

# Load modular configurations
print_in_purple "\n >> Setting up modular configurations\n\n"
if ! grep -q "# Load modular configurations from jarvistoolset" "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# Load modular configurations from jarvistoolset
for config_file in "$HOME/.jarvistoolset/zsh_configs/"*.zsh; do
    if [ -f "$config_file" ]; then
        source "$config_file"
    fi
done
EOL
    print_in_green "Added modular configuration loader to .zshrc\n"
fi

# Ask user if they want to configure macOS preferences
print_in_purple "\n >> Configure macOS Preferences\n\n"
print_in_yellow "Would you like to configure macOS preferences now? (y/n): "
configure_preferences=""
vared -p $'' configure_preferences

if [[ "$configure_preferences" =~ ^[Yy]$ ]]; then
    # Path to the preferences script
    PREFERENCES_SCRIPT="${DIRECTORY}/scripts/os/preferences/macos/main.zsh"
    
    if [[ -f "$PREFERENCES_SCRIPT" && -x "$PREFERENCES_SCRIPT" ]]; then
        # Run the preferences script
        "$PREFERENCES_SCRIPT"
    else
        print_error "Preferences script not found or not executable: $PREFERENCES_SCRIPT"
    fi
else
    print_in_yellow "Skipping preferences configuration.\n"
fi

print_in_purple "\n >> Installation and configuration completed!\n\n"
