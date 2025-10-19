# GNU Stow Implementation for Dotfiles

This document describes the GNU Stow implementation that replaces the manual directory creation and symbolic link functionality in the dotfiles setup.

## Overview

GNU Stow is a symlink farm manager that helps manage configuration files by creating symbolic links from a central location to their target destinations. This implementation replaces the previous manual directory creation and symlink scripts with a more robust and maintainable solution.

## Directory Structure

```
dotfiles/
├── stow/                    # GNU Stow packages directory
│   ├── shell/              # Shell configuration package
│   │   ├── .config/        # Configuration files
│   │   ├── .local/         # Local user files
│   │   ├── .ssh/           # SSH configuration
│   │   ├── .gnupg/         # GPG configuration
│   │   └── ...             # Other shell-related directories
│   ├── git/                # Git configuration package
│   ├── nvim/               # Neovim configuration package
│   ├── ssh/                # SSH configuration package
│   ├── gnupg/              # GPG configuration package
│   └── config/             # General configuration package
├── macos/scripts/
│   └── stow_setup.zsh      # macOS-specific stow setup
├── linux/scripts/
│   └── stow_setup.zsh      # Linux-specific stow setup
└── cross-platforms/scripts/
    └── utils.zsh           # Updated with stow utility functions
```

## Key Features

### 1. Automatic Stow Installation
- Detects the operating system (macOS/Linux)
- Installs GNU Stow using the appropriate package manager
- Supports Homebrew (macOS), apt, yum, dnf, pacman, zypper (Linux)

### 2. Package Management
- **stow_install()**: Install a stow package
- **stow_remove()**: Remove a stow package
- **stow_restore()**: Restore/update a stow package
- **stow_simulate()**: Preview operations without making changes

### 3. Safety Features
- Simulation mode to preview changes before applying
- Confirmation prompts for all operations
- Comprehensive error handling and logging
- Rollback capabilities

### 4. Integration
- Seamless integration with existing logging system
- Backward compatibility with deprecated scripts
- Platform-specific configuration handling

## Usage

### Basic Setup
The stow setup is automatically called during the main dotfiles installation process:

```bash
# macOS
./macos/scripts/setup.zsh

# Linux  
./linux/scripts/setup.zsh
```

### Manual Stow Operations

```bash
# Source the utils script
source cross-platforms/scripts/utils.zsh

# Install stow if not already installed
install_stow

# Setup all stow packages
setup_stow_packages

# Install specific package
stow_install "shell"

# Simulate package installation
stow_simulate "git"

# Remove package
stow_remove "nvim"

# Restore package
stow_restore "shell"
```

## Migration from Old System

### What Changed
1. **Directory Creation**: Manual `mkdir -p` commands replaced with stow package structure
2. **Symbolic Links**: Manual `ln -s` commands replaced with stow operations
3. **Configuration Management**: Centralized package-based approach
4. **Backward Compatibility**: Removed - all scripts now use stow exclusively

### Breaking Changes
- **Removed Functions**: `create_directories()`, `create_symlink()`, `backup_file()` functions removed from utils.zsh
- **Removed Scripts**: All `create_directories.zsh` and `create_symbolic_links.zsh` scripts removed
- **Stow Only**: All configuration management now requires GNU Stow

### Benefits
1. **Consistency**: All configurations managed through stow
2. **Maintainability**: Easier to add/remove configurations
3. **Safety**: Built-in simulation and rollback capabilities
4. **Standards Compliance**: Follows GNU Stow best practices
5. **Cleaner Codebase**: No legacy functions or scripts

## Configuration Packages

### Shell Package (`stow/shell/`)
Contains all shell-related configurations and directories:
- Shell configuration files (`.zshrc`, `.zshenv`, etc.)
- XDG Base Directory structure (`.config`, `.local`, `.cache`)
- Development directories (`Projects`, `Workspace`)
- Package manager directories (`.npm-global`, `.composer`, etc.)

### Git Package (`stow/git/`)
Contains Git configuration files:
- `.gitconfig`
- `.gitattributes`
- `.gitignore`

### Neovim Package (`stow/nvim/`)
Contains Neovim configuration:
- `init.vim`
- Vim configuration files

### Additional Packages
- **SSH Package**: SSH configuration files
- **GPG Package**: GPG configuration files
- **Config Package**: General configuration files

## Error Handling

The implementation includes comprehensive error handling:
- Package existence validation
- Stow installation verification
- Operation result logging
- Graceful failure handling

## Logging

All stow operations are logged using the existing logging system:
- Installation progress
- Success/failure status
- Error messages
- Simulation results

## Troubleshooting

### Common Issues

1. **Stow Not Found**
   - Run `install_stow` to install GNU Stow
   - Verify package manager is available

2. **Package Conflicts**
   - Use `stow_simulate` to preview operations
   - Use `--adopt` flag for force installation
   - Check for existing files that conflict

3. **Permission Issues**
   - Ensure proper permissions on stow directory
   - Run with appropriate privileges if needed

### Debug Mode
Enable verbose output by setting environment variables:
```bash
export STOW_VERBOSE=true
```

## Future Enhancements

Potential improvements for future versions:
1. Package dependency management
2. Configuration validation
3. Automated package updates
4. Cross-platform package compatibility
5. Package versioning system
