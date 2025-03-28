#!/bin/zsh
#
# Main script for installing and configuring Anthropic libraries and tools
# for MCP Servers and Clients
#

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../scripts/os/utils.zsh" 2>/dev/null || source "${SCRIPT_DIR}/../os/utils.zsh"

print_in_purple "\n ⚡️ Anthropic MCP Tools Installation ⚡️ \n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is not installed. Please install Python 3 first."
    exit 1
fi

# Check Python version
python_version=$(python3 --version | cut -d' ' -f2)
print_info "Detected Python version: $python_version"

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    print_error "pip3 is not installed. Please install pip3 first."
    exit 1
fi

# Get OS type
OS_TYPE=$(get_os)
if [[ "$OS_TYPE" != "macos" ]]; then
    print_error "This script is currently only supported on macOS."
    exit 1
fi

# Run the appropriate setup script
if [[ -f "${SCRIPT_DIR}/../os/install/macos/setup_anthropic.zsh" ]]; then
    source "${SCRIPT_DIR}/../os/install/macos/setup_anthropic.zsh"
elif [[ -f "${SCRIPT_DIR}/../os/install/${OS_TYPE}/setup_anthropic.zsh" ]]; then
    source "${SCRIPT_DIR}/../os/install/${OS_TYPE}/setup_anthropic.zsh"
else
    print_error "Setup script for ${OS_TYPE} not found."
    exit 1
fi

# Create or update the Anthropic configuration file
if [[ ! -f "$HOME/.jarvistoolset/zsh_configs/anthropic.zsh" ]]; then
    if [[ -f "${SCRIPT_DIR}/../../zsh_configs/anthropic.zsh" ]]; then
        mkdir -p "$HOME/.jarvistoolset/zsh_configs"
        cp "${SCRIPT_DIR}/../../zsh_configs/anthropic.zsh" "$HOME/.jarvistoolset/zsh_configs/"
        print_success "Created Anthropic configuration file"
    else
        print_warning "Anthropic configuration template not found"
    fi
else
    print_info "Anthropic configuration file already exists"
fi

# Final instructions
print_in_green "\n ✅ Anthropic MCP Tools Installation Complete! ✅ \n\n"

print_in_yellow "To use the Anthropic MCP tools, you need to:\n"
print_in_yellow "1. Set your Anthropic API key in your environment:\n"
print_in_yellow "   export ANTHROPIC_API_KEY='your-api-key'\n\n"
print_in_yellow "2. Start the MCP server:\n"
print_in_yellow "   mcp-start\n\n"
print_in_yellow "3. Use the MCP client in your applications\n\n"
print_in_yellow "For more information, check the documentation at:\n"
print_in_yellow "https://docs.anthropic.com/\n\n"

exit 0
