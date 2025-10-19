#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Cleanup\n\n"

# Remove .DS_Store files
find "$HOME" -name ".DS_Store" -depth -type f -delete 2>/dev/null
print_success "Removed .DS_Store files"

# Clean Homebrew cache
if command -v brew &> /dev/null; then
    brew cleanup
    print_success "Cleaned Homebrew cache"
fi

# Clean up temporary files
rm -rf /tmp/* &>/dev/null
print_success "Cleaned temporary files"

# Clean up system logs (requires sudo)
# Uncomment if needed and user has sudo privileges
# sudo rm -rf /var/log/*
# print_success "Cleaned system logs"

print_success "Cleanup completed"
