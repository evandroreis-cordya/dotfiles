#!/usr/bin/env zsh

# Test script for GNU Stow implementation
# This script validates the stow functionality without making actual changes

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/cross-platforms/scripts/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n >> GNU Stow Implementation Test\n\n"

# Test 1: Check if stow functions are available
print_in_yellow "Test 1: Checking stow function availability\n"
if type stow_installed &>/dev/null; then
    print_success "stow_installed function is available"
else
    print_error "stow_installed function is NOT available"
fi

if type install_stow &>/dev/null; then
    print_success "install_stow function is available"
else
    print_error "install_stow function is NOT available"
fi

if type stow_simulate &>/dev/null; then
    print_success "stow_simulate function is available"
else
    print_error "stow_simulate function is NOT available"
fi

if type stow_install &>/dev/null; then
    print_success "stow_install function is available"
else
    print_error "stow_install function is NOT available"
fi

# Test 2: Check stow directory structure
print_in_yellow "\nTest 2: Checking stow directory structure\n"
local stow_dir="$HOME/dotfiles/cross-platforms/stow"

if [[ -d "$stow_dir" ]]; then
    print_success "Stow directory exists: $stow_dir"

    # Check for package directories
    local -a packages=(shell git nvim ssh gnupg config)
    for package in "${packages[@]}"; do
        if [[ -d "$stow_dir/$package" ]]; then
            print_success "Package directory exists: $package"
        else
            print_error "Package directory missing: $package"
        fi
    done
else
    print_error "Stow directory does not exist: $stow_dir"
fi

# Test 3: Check if GNU Stow is installed
print_in_yellow "\nTest 3: Checking GNU Stow installation\n"
if stow_installed; then
    print_success "GNU Stow is installed"
    local stow_version=$(stow --version 2>/dev/null | head -n1)
    print_in_green "Version: $stow_version\n"
else
    print_error "GNU Stow is NOT installed"
    print_in_yellow "Run 'install_stow' to install GNU Stow\n"
fi

# Test 4: Test stow simulation (if stow is installed)
if stow_installed && [[ -d "$stow_dir/shell" ]]; then
    print_in_yellow "\nTest 4: Testing stow simulation\n"
    print_in_yellow "Simulating stow operation for 'shell' package...\n"

    if stow_simulate "shell" "$stow_dir" "$HOME" >/dev/null 2>&1; then
        print_success "Stow simulation completed successfully"
    else
        print_error "Stow simulation failed"
    fi
else
    print_in_yellow "\nTest 4: Skipped (stow not installed or shell package missing)\n"
fi

# Test 5: Check that deprecated scripts are removed
print_in_yellow "\nTest 5: Checking deprecated scripts are removed\n"
local deprecated_scripts=(
    "macos/scripts/create_directories.zsh"
    "macos/scripts/create_symbolic_links.zsh"
    "linux/scripts/create_directories.zsh"
    "linux/scripts/create_symbolic_links.zsh"
)

for script in "${deprecated_scripts[@]}"; do
    local script_path="$HOME/dotfiles/$script"
    if [[ ! -f "$script_path" ]]; then
        print_success "Deprecated script properly removed: $script"
    else
        print_error "Deprecated script still exists: $script"
    fi
done

# Test 6: Check setup script integration
print_in_yellow "\nTest 6: Checking setup script integration\n"
local setup_scripts=(
    "macos/scripts/setup.zsh"
    "linux/scripts/setup.zsh"
)

for script in "${setup_scripts[@]}"; do
    local script_path="$HOME/dotfiles/$script"
    if [[ -f "$script_path" ]]; then
        if grep -q "stow_setup" "$script_path"; then
            print_success "Setup script includes stow: $script"
        else
            print_error "Setup script missing stow integration: $script"
        fi
    else
        print_error "Setup script not found: $script"
    fi
done

# Summary
print_in_purple "\n >> Test Summary\n\n"
print_in_green "GNU Stow implementation test completed.\n"
print_in_yellow "If any tests failed, please check the implementation and try again.\n"
print_in_yellow "For detailed information, see STOW_README.md\n"
