#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   GPG Tools\n\n"

# Core GPG Tools
brew_install "GPG" "gnupg"
brew_install "Pinentry Mac" "pinentry-mac"
brew_install "GPG Suite" "gpg-suite" "--cask"

# GPG Utilities
brew_install "Keybase" "keybase" "--cask"
brew_install "GPG Tools" "gpgtools"
brew_install "GPG Agent" "gpg-agent"

# Smart Card Support
brew_install "PCSC-Lite" "pcsclite"
brew_install "YubiKey Manager" "yubikey-manager"
brew_install "YubiKey Personalization GUI" "yubikey-personalization-gui" "--cask"

# Optional GPG Tools
# Uncomment if needed
# brew_install "Kleopatra" "kleopatra"
# brew_install "Seahorse" "seahorse"
# brew_install "GPG Tools Beta" "gpgtools-beta"

# Configure GPG Agent
execute "mkdir -p ~/.gnupg" \
    "Create GPG config directory"

execute "chmod 700 ~/.gnupg" \
    "Set secure permissions for GPG directory"

# Configure GPG Agent
cat > ~/.gnupg/gpg-agent.conf << EOL
default-cache-ttl 3600
max-cache-ttl 7200
pinentry-program /usr/local/bin/pinentry-mac
EOL

execute "chmod 600 ~/.gnupg/gpg-agent.conf" \
    "Set secure permissions for GPG agent config"

# Configure GPG
cat > ~/.gnupg/gpg.conf << EOL
use-agent
no-emit-version
no-comments
keyid-format LONG
with-fingerprint
EOL

execute "chmod 600 ~/.gnupg/gpg.conf" \
    "Set secure permissions for GPG config"

# Restart GPG Agent
execute "gpgconf --kill gpg-agent" \
    "Restart GPG agent"

# Add GPG configuration to shell
if ! grep -q "GPG_TTY" ~/.zshrc; then
    echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
    echo "Added GPG_TTY to .zshrc"
fi

# Configure Git to use GPG signing
execute "git config --global commit.gpgsign true" \
    "Enable GPG signing for Git commits"

execute "git config --global gpg.program $(which gpg)" \
    "Set GPG program for Git"
