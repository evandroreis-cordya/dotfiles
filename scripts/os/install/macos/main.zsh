#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# Enable nullglob to handle the case where there are no matches for a glob pattern
setopt nullglob

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n >> Starting macOS setup\n\n"

# Log the available script groups
if type log_info &>/dev/null; then
    log_info "Available script groups in macos/main.zsh: ${(k)SELECTED_GROUPS}"
    for group in ${(k)SELECTED_GROUPS}; do
        log_info "Group $group: ${SELECTED_GROUPS[$group]}"
    done
fi

# Create zsh_configs directory for modular configurations
mkdir -p "$HOME/.jarvistoolset/macos/configs/shell/zsh_configs"
print_success "Created modular configuration directory at $HOME/.jarvistoolset/macos/configs/shell/zsh_configs\n"

SCRIPT_DIR_INSTALL_MACOS="$SCRIPT_DIR/install/macos"

# System setup scripts
if [[ "${SELECTED_GROUPS[system]}" == "true" ]]; then
    log_info "Installing System Setup"
    print_in_purple "\n >> Installing System Setup\n\n"
    
    # Source all scripts in the system directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/system"/*.zsh; do
        if [ -f "$script" ]; then
            log_info "Sourcing script: $script"
            source "$script"
        fi
    done
    log_success "System Setup installation complete"
else
    log_info "Skipping System Setup"
    print_in_red "\n >> Skipping System Setup\n\n"
fi

# Development languages
if [[ "${SELECTED_GROUPS[dev_langs]}" == "true" ]]; then
    print_in_purple "\n >> Installing Development Languages\n\n"
    
    # Source all scripts in the dev_langs directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/dev_langs"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping Development Languages\n\n"
fi

# Data Science Environment
if [[ "${SELECTED_GROUPS[data_science]}" == "true" ]]; then
    print_in_purple "\n >> Installing Data Science Environment\n\n"
    
    # Source all scripts in the data_science directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/data_science"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping Data Science Environment\n\n"
fi

# AI and ML Tools
if [[ "${SELECTED_GROUPS[ai_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing AI and Productivity Tools\n\n"
    
    # Source all scripts in the ai_tools directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/ai_tools"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping AI and Productivity Tools\n\n"
fi

# Development Tools
if [[ "${SELECTED_GROUPS[dev_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Development Tools\n\n"
    
    # Source all scripts in the dev_tools directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/dev_tools"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping Development Tools\n\n"
fi

# Web and Frontend Tools
if [[ "${SELECTED_GROUPS[web_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Web and Frontend Tools\n\n"
    
    # Source all scripts in the web_tools directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/web_tools"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping Web and Frontend Tools\n\n"
fi

# Daily Tools and Utilities
if [[ "${SELECTED_GROUPS[daily_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Daily Tools and Utilities\n\n"
    
    # Source all scripts in the daily_tools directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/daily_tools"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping Daily Tools and Utilities\n\n"
fi

# Media and Creative Tools
if [[ "${SELECTED_GROUPS[media_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Media and Creative Tools\n\n"
    
    # Source all scripts in the media_tools directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/media_tools"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping Media and Creative Tools\n\n"
fi

# Creative and 3D Design Tools
if [[ "${SELECTED_GROUPS[creative_tools]}" == "true" ]]; then
    log_info "Installing Creative and 3D Design Tools"
    print_in_purple "\n >> Installing Creative and 3D Design Tools\n\n"
    
    # Source all scripts in the creative_tools directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/creative_tools"/*.zsh; do
        if [ -f "$script" ]; then
            log_info "Sourcing script: $script"
            source "$script"
        fi
    done
    log_success "Creative and 3D Design Tools installation complete"
else
    log_info "Skipping Creative and 3D Design Tools installation"
    print_in_red "\n >> Skipping Creative and 3D Design Tools\n\n"
fi

# Cloud and DevOps Tools
if [[ "${SELECTED_GROUPS[cloud_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Cloud and DevOps Tools\n\n"
    
    # Source all scripts in the cloud_tools directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/cloud_tools"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping Cloud and DevOps Tools\n\n"
fi

# App Store and System Tools
if [[ "${SELECTED_GROUPS[app_store]}" == "true" ]]; then
    print_in_purple "\n >> Installing App Store and System Tools\n\n"
    
    # Source all scripts in the app_store directory
    for script in "${SCRIPT_DIR_INSTALL_MACOS}/app_store"/*.zsh; do
        if [ -f "$script" ]; then
            source "$script"
        fi
    done
else
    print_in_red "\n >> Skipping App Store and System Tools\n\n"
fi

# Run cleanup and validation
print_in_purple "\n >> Running cleanup and validation\n\n"
source "${SCRIPT_DIR_INSTALL_MACOS}/utils/cleanup.zsh"
source "${SCRIPT_DIR_INSTALL_MACOS}/utils/validate_installations.zsh"

print_in_green "\n >> macOS setup completed!\n\n"
