#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_directories() {
    # Define directories to create using zsh array syntax
    local -a DIRECTORIES=(
        # XDG Base Directory Specification
        "$HOME/.config"           # User-specific configuration
        "$HOME/.local/bin"       # User-specific executables
        "$HOME/.local/share"     # User-specific data files
        "$HOME/.local/state"     # User-specific state files
        "$HOME/.cache"           # User-specific cache files
        
        # Custom directories
        "$HOME/.personalize"     # Personal customization files
        "$HOME/Projects"         # Development projects
        "$HOME/Workspace"        # Work-related files
        "$HOME/.ssh"            # SSH configuration
        "$HOME/.gnupg"          # GPG configuration
        
        # Development directories
        "$HOME/.npm-global"     # Global npm packages
        "$HOME/.composer"       # Composer packages
        "$HOME/.gradle"         # Gradle configuration
        "$HOME/.m2"            # Maven configuration
        
        # Backup directories
        "$HOME/Backups"        # General backups
        "$HOME/Backups/Apps" \
        "$HOME/Backups/Configs" \
        "$HOME/Backups/jarvistoolset" # jarvistoolset backups
        
        # Application directories
        "$HOME/.config/nvim"   # Neovim configuration
        "$HOME/.config/git"    # Git configuration
        "$HOME/.config/zsh"    # Zsh configuration
    )

    print_in_purple "\n   Creating directories\n\n"

    # Create directories with proper permissions
    for dir in $DIRECTORIES; do
        if mkd "$dir"; then
            # Set restrictive permissions for sensitive directories
            case "$dir" in
                */.ssh|*/.gnupg)
                    chmod 700 "$dir"
                    ;;
                *)
                    chmod 755 "$dir"
                    ;;
            esac
        fi
    done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n • Creating directories\n\n"
    create_directories
}

main
