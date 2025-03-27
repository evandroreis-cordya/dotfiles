#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   GPG Tools\n\n"

# Core GPG Tools
if brew list | grep -q "gnupg"; then
    print_success "GPG (already installed)"
else
    brew install gnupg &> /dev/null
    print_result $? "GPG"
fi

if brew list | grep -q "pinentry-mac"; then
    print_success "Pinentry Mac (already installed)"
else
    brew install pinentry-mac &> /dev/null
    print_result $? "Pinentry Mac"
fi

if brew list --cask | grep -q "gpg-suite"; then
    print_success "GPG Suite (already installed)"
else
    brew install --cask gpg-suite &> /dev/null
    print_result $? "GPG Suite"
fi

# GPG Utilities
if brew list --cask | grep -q "keybase"; then
    print_success "Keybase (already installed)"
else
    brew install --cask keybase &> /dev/null
    print_result $? "Keybase"
fi

# Note: gpgtools is a tap, not a formula
print_warning "GPG Tools is part of GPG Suite which is already installed"

# GPG Agent is included with gnupg
if command -v gpg-agent &> /dev/null; then
    print_success "GPG Agent (already installed)"
else
    print_warning "GPG Agent is included with gnupg and should already be available"
fi

# Smart Card Support
if command -v pcsc_scan &> /dev/null || brew list | grep -q "pcsclite"; then
    print_success "PCSC-Lite (already installed)"
else
    brew install pcsclite &> /dev/null
    if [ $? -eq 0 ]; then
        print_success "PCSC-Lite"
    else
        print_warning "PCSC-Lite installation failed (optional - skipped)"
    fi
fi

if command -v ykman &> /dev/null || brew list | grep -q "yubikey-manager"; then
    print_success "YubiKey Manager (already installed)"
else
    brew install yubikey-manager &> /dev/null
    if [ $? -eq 0 ]; then
        print_success "YubiKey Manager"
    else
        print_warning "YubiKey Manager installation failed (optional - skipped)"
    fi
fi

if brew list --cask 2>/dev/null | grep -q "yubikey-personalization-gui"; then
    print_success "YubiKey Personalization GUI (already installed)"
else
    brew install --cask yubikey-personalization-gui &> /dev/null
    if [ $? -eq 0 ]; then
        print_success "YubiKey Personalization GUI"
    else
        print_warning "YubiKey Personalization GUI installation failed (optional - skipped)"
    fi
fi

# Configure GPG Agent
print_in_purple "\n   GPG Configuration\n\n"

# Create GPG config directory
if [[ -d ~/.gnupg ]]; then
    print_success "GPG config directory already exists"
else
    mkdir -p ~/.gnupg &> /dev/null
    print_result $? "Create GPG config directory"
fi

# Set secure permissions for GPG directory
chmod 700 ~/.gnupg &> /dev/null
print_result $? "Set secure permissions for GPG directory"

# Configure GPG Agent
cat > ~/.gnupg/gpg-agent.conf << EOL
default-cache-ttl 3600
max-cache-ttl 7200
pinentry-program $(brew --prefix)/bin/pinentry-mac
EOL
print_result $? "Configure GPG agent"

# Set secure permissions for GPG agent config
chmod 600 ~/.gnupg/gpg-agent.conf &> /dev/null
print_result $? "Set secure permissions for GPG agent config"

# Configure GPG
cat > ~/.gnupg/gpg.conf << EOL
use-agent
no-emit-version
no-comments
keyid-format LONG
with-fingerprint
EOL
print_result $? "Configure GPG"

# Set secure permissions for GPG config
chmod 600 ~/.gnupg/gpg.conf &> /dev/null
print_result $? "Set secure permissions for GPG config"

# Restart GPG Agent
gpgconf --kill gpg-agent &> /dev/null
print_result $? "Restart GPG agent"

# Add GPG configuration to shell
if grep -q "GPG_TTY" ~/.zshrc; then
    print_success "GPG_TTY already in .zshrc"
else
    echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
    print_result $? "Add GPG_TTY to .zshrc"
fi

# Configure Git to use GPG signing
git config --global commit.gpgsign true &> /dev/null
print_result $? "Enable GPG signing for Git commits"

git config --global gpg.program $(which gpg) &> /dev/null
print_result $? "Set GPG program for Git"

print_in_green "\n  GPG tools setup complete!\n"
