# Evandro Reis Dotfiles (macOS Sequoia Edition, 2025) - Complete Revamp using Vibe Coding [![Build Status](https://travis-ci.org/evandropaes/dotfiles.svg?branch=master)](https://travis-ci.org/evandropaes/dotfiles)

## Introduction

First and foremost, I want to express my gratitude to [Victor Cavalcante](https://github.com/vcavalcante/) (a great friend from Lambda3) who introduced me to the concept of Dotfiles and guided me through his tutorial. Thank you, brother. Special thanks also to [Cătălin Mariș](https://github.com/alrra) for the scripts and enhancements. The configurations that follow are based on their initial work.

**WARNING:** If you want to use these dotfiles and configuration scripts, first fork this repository. **DO NOT** use them without understanding what they do.

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
```

## Quick Start

1. Fork this repository
2. Review and modify the configuration files
3. Run the setup script:
```bash
cd ~/.dotfiles
./scripts/os/setup.zsh
```

## Core Files

Review the code and remove anything you find unnecessary. The main files you should review are:

| File | Purpose |
|------|---------|
| `setup.zsh` | Entry point and hub for calling other scripts |
| `.travis.yml` | CI environment configuration |
| `create_local_config_files.zsh` | Creation of local configurations (.local) |

## System Preferences

Review the configuration parameters (and your preferences) in `~/scripts/os/preferences/macos`:

| Script | Description |
|--------|-------------|
| `app_store.zsh` | App Store preferences |
| `chrome.zsh` | Google Chrome preferences |
| `dock.zsh` | Dock preferences and layout |
| `finder.zsh` | Finder view and behavior settings |
| `keyboard.zsh` | Keyboard and input preferences |
| `language.zsh` | Language and region settings |
| `security.zsh` | Security and privacy settings |
| `terminal.zsh` | Terminal appearance and behavior |
| `trackpad.zsh` | Trackpad gestures and sensitivity |
| `ui_ux.zsh` | General UI/UX preferences |

Feel free to send suggestions, corrections, and feedback. I'll accept pull requests that add value to the project, as long as they're constructive and respectful.

## What Will Be Installed

The setup process will:

1. Fork this repository (at your own risk)
2. Clone the repository
3. Install command-line tools and applications
4. Set up development environments
5. Configure system preferences

### 1. Requirements

* A clean installation of macOS (preferably the latest version)
* Command Line Tools (will be installed if missing)
* Internet connection

### 2. Backup

Before proceeding, back up your existing dotfiles:

```bash
mkdir -p ~/.backup/dotfiles
cp -r ~/.* ~/.backup/dotfiles/
```

### 3. Install Command Line Tools

```bash
xcode-select --install
```

### 4. Clone the Git Repository

Fork [my dotfiles repository](https://github.com/evandropaes/dotfiles) to your GitHub account. This is important as you'll be making your own modifications to these files and storing them in your GitHub for future reference.

Clone your forked repository to the ~/.dotfiles directory:

```sh
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
```

### 5. Running setup.zsh

To set up the dotfiles, execute the appropriate snippet in your terminal:

(:warning: **DO NOT** execute "setup.zsh" if you don't fully understand what it does [](scripts/os/setup.zsh). Seriously, **DO NOT RUN IT** unless you've reviewed the code!)

| OS | Snippet |
|:---|:--------|
| `macOS` | `zsh -c "$(curl -LsS https://raw.github.com/YOUR_USERNAME/dotfiles/master/scripts/os/setup.zsh)"` |

That's it! :sparkles:

The setup.zsh script will:

* Download the dotfiles to your computer (default location: `~/.dotfiles`)
* Create necessary directories following the [XDG Base Directory Specification](scripts/os/create_directories.zsh)
* Create [local configuration files](scripts/os/create_local_config_files.zsh) for git and shell
* Install applications and command-line tools for [`macOS`](scripts/os/install/macos)
* Configure system preferences for [`macOS`](scripts/os/preferences/macos)

## Available Scripts

| Category | Script | Description |
|:---------|:-------|:------------|
| **Core** | |
| | `setup.zsh` | Main setup script to initialize the dotfiles |
| | `utils.zsh` | Core utility functions used by other scripts |
| | `main.zsh` | Orchestrates the installation process |
| **Installation** | |
| | `docker.zsh` | Installs Docker and related tools |
| | `extratools.zsh` | Installs additional productivity tools |
| | `git.zsh` | Configures Git and installs related tools |
| | `gpg.zsh` | Sets up GPG for secure communications |
| | `homebrew.zsh` | Installs Homebrew and core packages |
| | `jetbrains.zsh` | Installs JetBrains development tools |
| | `mas.zsh` | Installs Mac App Store applications |
| **Development** | |
| | `node.zsh` | Sets up Node.js development environment |
| | `php.zsh` | Configures PHP development environment |
| | `python.zsh` | Sets up Python development environment |
| | `ruby.zsh` | Configures Ruby development environment |
| | `go.zsh` | Sets up Go development environment |
| | `java.zsh` | Configures Java development environment |
| | `kotlin.zsh` | Sets up Kotlin development environment |
| | `rust.zsh` | Configures Rust development environment |
| | `swift.zsh` | Sets up Swift development environment |
| **Configuration** | |
| | `create_directories.zsh` | Creates XDG-compliant directory structure |
| | `create_local_config_files.zsh` | Creates local configuration files |
| | `update_content.zsh` | Updates dotfiles from repository |
| | `restart.zsh` | Safely restarts the system |

## Customization

All scripts are designed to be modular and easily customizable. Here's how you can personalize your setup:

1. **Local Configurations**: Edit files in `~/.local` for machine-specific settings:
   - `~/.local/shell/zsh.local`: Custom shell configurations
   - `~/.local/git/config.local`: Local Git settings

2. **Development Environments**: Modify language-specific scripts in `scripts/os/install/macos/` to:
   - Add/remove packages
   - Configure environment variables
   - Set up development tools

3. **System Preferences**: Customize `preferences/macos` for:
   - UI/UX settings
   - Security preferences
   - Application defaults

4. **Package Selection**: Edit installation scripts to:
   - Choose which applications to install
   - Add custom Homebrew formulas
   - Configure development tools

## Maintenance

Keep your dotfiles up to date with these commands:

```sh
# Update dotfiles repository
~/.dotfiles/scripts/os/update_content.zsh

# Update installed packages
brew update && brew upgrade
```

## Directory Structure

The dotfiles follow the XDG Base Directory Specification:

```
~/.config/          # User configuration files
~/.local/bin/       # User executables
~/.local/share/     # User data files
~/.local/state/     # User state files
~/.cache/           # User cache files
```

Development environments are organized in:

```
~/Projects/         # Development projects
~/Workspace/        # Work-related files
~/.npm-global/      # Global npm packages
~/.composer/        # Composer packages
~/.gradle/         # Gradle configuration
~/.m2/             # Maven configuration
```

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin feature/my-new-feature`
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

* [Victor Cavalcante](https://github.com/vcavalcante/) for introducing me to dotfiles
* [Cătălin Mariș](https://github.com/alrra) for the initial scripts
* The open-source community for all the amazing tools

## Happy Vibe Coding! :)
