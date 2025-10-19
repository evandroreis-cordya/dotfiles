#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Validating Installations\n\n"

# Function to check if a command is available
check_command() {
    local cmd="$1"
    local name="${2:-$cmd}"

    if command -v "$cmd" &> /dev/null; then
        print_success "$name is installed"
        return 0
    else
        print_error "$name is not installed"
        return 1
    fi
}

# Function to check if an application is installed
check_app() {
    local app="$1"

    if [ -d "/Applications/$app.app" ] || [ -d "$HOME/Applications/$app.app" ]; then
        print_success "$app is installed"
        return 0
    else
        print_error "$app is not installed"
        return 1
    fi
}

# Validate system tools
print_in_purple "\n   System Tools\n"
check_command "brew" "Homebrew"
check_command "git"
check_command "curl"
check_command "wget"
check_command "nvim"

# Validate shell setup
print_in_purple "\n   Shell Setup\n"
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_success "Oh My Zsh is installed"
else
    print_error "Oh My Zsh is not installed"
fi

# Validate development tools
if [[ "${SELECTED_GROUPS[dev_tools]}" == "true" ]]; then
    print_in_purple "\n   Development Tools\n"
    check_command "node" "Node.js"
    check_command "npm"
    check_command "python3" "Python"
    check_command "pip3" "pip"
    check_command "docker"
    check_command "code" "Visual Studio Code"
fi

# Validate creative tools
if [[ "${SELECTED_GROUPS[creative_tools]}" == "true" ]]; then
    print_in_purple "\n   Creative Tools\n"
    check_app "Figma"
    check_app "Blender"
    check_app "Sketch"
fi

# Validate web tools
if [[ "${SELECTED_GROUPS[web_tools]}" == "true" ]]; then
    print_in_purple "\n   Web Tools\n"
    check_command "firebase" "Firebase CLI"
    check_command "netlify" "Netlify CLI"
fi

# Validate cloud tools
if [[ "${SELECTED_GROUPS[cloud_tools]}" == "true" ]]; then
    print_in_purple "\n   Cloud Tools\n"
    check_command "aws" "AWS CLI"
    check_command "gcloud" "Google Cloud SDK"
    check_command "az" "Azure CLI"
fi

# Validate AI tools
if [[ "${SELECTED_GROUPS[ai_tools]}" == "true" ]]; then
    print_in_purple "\n   AI Tools\n"
    check_command "jupyter" "Jupyter"
    check_command "conda" "Anaconda"
fi

print_success "Validation completed"
