#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n >> Starting macOS setup\n\n"

# Create zsh_configs directory for modular configurations
mkdir -p "$HOME/.jarvistoolset/zsh_configs"
print_success "Created modular configuration directory at $HOME/.jarvistoolset/zsh_configs\n"

# System setup scripts
if [[ "${SELECTED_GROUPS[system]}" == "true" ]]; then
    print_in_purple "\n >> Installing System Setup\n\n"
    source "${SCRIPT_DIR}/xcode.zsh"
    source "${SCRIPT_DIR}/homebrew.zsh"
    source "${SCRIPT_DIR}/oh_my_zsh.zsh"

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
    source "${SCRIPT_DIR}/rust.zsh"
    source "${SCRIPT_DIR}/java.zsh"
    source "${SCRIPT_DIR}/kotlin.zsh"
    source "${SCRIPT_DIR}/swift.zsh"
    source "${SCRIPT_DIR}/php.zsh"
    source "${SCRIPT_DIR}/cpp.zsh"
else
    print_in_red "\n >> Skipping Development Languages\n\n"
fi

# AI and ML tools
if [[ "${SELECTED_GROUPS[ai_ml]}" == "true" ]]; then
    print_in_purple "\n >> Installing AI and ML Tools\n\n"
    source "${SCRIPT_DIR}/ai_ml.zsh"
else
    print_in_red "\n >> Skipping AI and ML Tools\n\n"
fi

# Development tools
if [[ "${SELECTED_GROUPS[dev_tools]}" == "true" ]]; then
    print_in_purple "\n >> Installing Development Tools\n\n"
    source "${SCRIPT_DIR}/git.zsh"
    source "${SCRIPT_DIR}/docker.zsh"
    source "${SCRIPT_DIR}/vscode.zsh"
    source "${SCRIPT_DIR}/jetbrains.zsh"
    source "${SCRIPT_DIR}/sublime.zsh"
    source "${SCRIPT_DIR}/atom.zsh"
    source "${SCRIPT_DIR}/yarn.zsh"
    
else
    print_in_red "\n >> Skipping Development Tools\n\n"
fi

# Productivity tools
if [[ "${SELECTED_GROUPS[productivity]}" == "true" ]]; then
    print_in_purple "\n >> Installing Productivity Tools\n\n"
    source "${SCRIPT_DIR}/productivity.zsh"
else
    print_in_red "\n >> Skipping Productivity Tools\n\n"
fi

# Communication tools
if [[ "${SELECTED_GROUPS[communication]}" == "true" ]]; then
    print_in_purple "\n >> Installing Communication Tools\n\n"
    source "${SCRIPT_DIR}/communication.zsh"
else
    print_in_red "\n >> Skipping Communication Tools\n\n"
fi

# Browsers
if [[ "${SELECTED_GROUPS[browsers]}" == "true" ]]; then
    print_in_purple "\n >> Installing Browsers\n\n"
    source "${SCRIPT_DIR}/browsers.zsh"
else
    print_in_red "\n >> Skipping Browsers\n\n"
fi

# Media tools
if [[ "${SELECTED_GROUPS[media]}" == "true" ]]; then
    print_in_purple "\n >> Installing Media Tools\n\n"
    source "${SCRIPT_DIR}/media.zsh"
else
    print_in_red "\n >> Skipping Media Tools\n\n"
fi

# Utilities
if [[ "${SELECTED_GROUPS[utilities]}" == "true" ]]; then
    print_in_purple "\n >> Installing Utilities\n\n"
    source "${SCRIPT_DIR}/utilities.zsh"
else
    print_in_red "\n >> Skipping Utilities\n\n"
fi

# macOS preferences
if [[ "${SELECTED_GROUPS[macos_prefs]}" == "true" ]]; then
    print_in_purple "\n >> Setting macOS Preferences\n\n"
    source "${SCRIPT_DIR}/preferences.zsh"
else
    print_in_red "\n >> Skipping macOS Preferences\n\n"
fi

# Run validation script to ensure all selected tools are properly installed
print_in_purple "\n   Validating Installations\n\n"
source "${SCRIPT_DIR}/validate_installations.zsh"

print_in_purple "\n >> macOS setup completed\n\n"
print_in_purple "\n   Installation Complete!\n\n"
