#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

print_in_purple "
   System CLI Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# System Monitoring
brew_install "htop" "htop"
brew_install "btop" "btop"  # Modern htop alternative
brew_install "glances" "glances"  # Cross-platform monitoring

# Disk and Storage Tools
brew_install "ncdu" "ncdu"  # Disk usage analyzer
brew_install "duf" "duf"  # Disk usage/free utility
brew_install "dust" "dust"  # More intuitive version of du

# Network Tools
brew_install "nmap" "nmap"  # Network scanner
brew_install "netcat" "netcat"  # Network utility
brew_install "tcpdump" "tcpdump"  # Packet analyzer
brew_install "wireshark" "wireshark"  # Network protocol analyzer

# System Information
brew_install "neofetch" "neofetch"  # System information
brew_install "screenfetch" "screenfetch"  # System information
brew_install "inxi" "inxi"  # System information

# Process Management
brew_install "procs" "procs"  # Modern ps alternative
brew_install "bottom" "bottom"  # System monitor

# File System Tools
brew_install "rsync" "rsync"  # File synchronization
brew_install "rclone" "rclone"  # Cloud storage sync
brew_install "fpart" "fpart"  # File partitioner

# Terminal Utilities
brew_install "zoxide" "zoxide"  # Smarter cd command
brew_install "starship" "starship"  # Cross-shell prompt
brew_install "oh-my-posh" "oh-my-posh"  # Prompt theme engine

# Clipboard Tools
brew_install "xclip" "xclip"  # Clipboard utility
brew_install "xsel" "xsel"  # Clipboard utility

# Archive Tools
brew_install "p7zip" "p7zip"  # 7-Zip
brew_install "unrar" "unrar"  # RAR extractor

print_in_green "
  System CLI tools installation complete!
"
