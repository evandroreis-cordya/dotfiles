          __                   _       _____            _          _
          \ \  __ _ _ ____   _(_)___  /__   \___   ___ | |___  ___| |_
           \ \/ _` | '__\ \ / / / __|   / /\/ _ \ / _ \| / __|/ _ \ __|
        /\_/ / (_| | |   \ V /| \__ \  / / | (_) | (_) | \__ \  __/ |_
        \___/ \__,_|_|    \_/ |_|___/  \/   \___/ \___/|_|___/\___|\__|

Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition, the complete Mac OS tools and apps installer for AI and Vibe Coders!
Copyright (c) 2025 ARVOS.AI. All rights reserved.

## Introduction

First and foremost, I want to express my gratitude to [Victor Cavalcante](https://github.com/vcavalcante/) (a great friend from Lambda3) who introduced me to the concept of dotfiles and guided me through his tutorial. Thank you, brother. Special thanks also to [Cătălin Mariș](https://github.com/alrra) for the scripts and enhancements. 

**WARNING:** If you want to use this jarvistoolset and configuration scripts, first fork this repository. **DO NOT** use them without understanding what they do.

```zsh
git clone https://github.com/YOUR_USERNAME/jarvistoolset.git ~/.jarvistoolset
```
**WARNING:** If you don't fork this repository, you will not be able to make changes to the configuration files. It must be downloaded from your forked repository. You must clone it in the `~/.jarvistoolset` directory otherwise the script will not work.

## Quick Start

1. Fork this repository
2. Review and modify the configuration files
3. Run the setup script:
```zsh
cd ~/.jarvistoolset
./start_jarvis.zsh
```

## Core Files

Review the code and remove anything you find unnecessary. The main files you should review are:

| File | Purpose |
|------|---------|
| `start_jarvis.zsh` | Main entry script that calls setup.zsh with default arguments |
| `setup.zsh` | Main setup script and hub for calling other scripts |
| `create_local_config_files.zsh` | Creation of local configurations (.local) |

## Enhanced Logging System

The Jarvis Toolset features a comprehensive logging system that:

- Records all installation and configuration activities
- Maintains silent logging for installation messages unless there's an error
- Provides detailed logs for troubleshooting
- Integrates with all print functions for consistent output

All logs are stored in `$HOME/.jarvistoolset/logs/` with timestamps and log levels.

## Modular Configuration Approach

The jarvistoolset now uses a modular configuration approach for all programming languages and development tools. Instead of directly modifying `.zshrc`, `.zprofile`, or `.profile`, each tool or language creates its own configuration file in `$HOME/.jarvistoolset/zsh_configs/`.

Benefits of this approach:
- Prevents duplicate entries in shell configuration files
- Makes it easier to update or modify configurations for specific tools
- Improves organization by keeping related configurations together
- Simplifies troubleshooting by isolating configuration issues

All configuration files are automatically loaded by a single entry in `.zshrc` that sources all files in the `zsh_configs` directory.

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

Before proceeding, back up your existing configuration files:

```zsh
mkdir -p ~/.backup/jarvistoolset
cp -r ~/.* ~/.backup/jarvistoolset/ 2>/dev/null || true
```

### 3. Install Command Line Tools

```zsh
xcode-select --install
```

### 4. Clone the Git Repository

Fork [my jarvistoolset repository](https://github.com/arvosai/jarvistoolset) to your GitHub account. This is important as you'll be making your own modifications to these files and storing them in your GitHub for future reference.

Clone your forked repository to the ~/.jarvistoolset directory:

```zsh
git clone https://github.com/YOUR_USERNAME/jarvistoolset.git ~/.jarvistoolset
```

### 5. Running start_jarvis.zsh

To set up the jarvistoolset, execute the appropriate snippet in your terminal:

(:warning: **DO NOT** execute "start_jarvis.zsh" if you don't fully understand what it does. Seriously, **DO NOT RUN IT** unless you've reviewed the code!)

| OS | Snippet |
|:---|:--------|
| `macOS` | `zsh -c "$(curl -fsSL https://raw.github.com/arvosai/jarvistoolset/main/start_jarvis.zsh)"` |

That's it! :sparkles:

The start_jarvis.zsh script will call setup.zsh which will:

* Download the jarvistoolset to your computer (default location: `~/.jarvistoolset`)
* Create necessary directories following the [XDG Base Directory Specification](scripts/os/create_directories.zsh)
* Create [local configuration files](scripts/os/create_local_config_files.zsh) for git and shell
* Install applications and command-line tools for [`macOS`](scripts/os/install/macos)
* Configure system preferences for [`macOS`](scripts/os/preferences/macos)

## Available Scripts

The jarvistoolset includes a comprehensive set of installation scripts organized by category:

### System Setup Scripts

| Script | Description |
|:-------|:------------|
| `xcode.zsh` | Installs Xcode and command line tools |
| `homebrew.zsh` | Installs Homebrew package manager and core packages |
| `oh_my_zsh.zsh` | Installs and configures Oh My Zsh with custom themes and plugins |


### Development Languages

| Script | Description |
|:-------|:------------|
| `python.zsh` | Installs Python, pip, virtualenv, and essential packages |
| `node.zsh` | Installs Node.js, npm, and core packages |
| `ruby.zsh` | Installs Ruby, RVM, and essential gems |
| `go.zsh` | Installs Go language and tools |
| `java.zsh` | Installs Java JDK, Maven, and Gradle |
| `kotlin.zsh` | Installs Kotlin compiler and tools |
| `rust.zsh` | Installs Rust, Cargo, and development tools |
| `swift.zsh` | Installs Swift compiler and development tools |
| `php.zsh` | Installs PHP, Composer, and extensions |
| `cpp.zsh` | Installs C/C++ compilers, libraries, and build tools |

### AI and ML Tools

| Script | Description |
|:-------|:------------|
| `ai_ml.zsh` | Installs TensorFlow, PyTorch, Jupyter, and other ML tools |

### Development Tools

| Script | Description |
|:-------|:------------|
| `git.zsh` | Configures Git and installs Git-related tools |
| `docker.zsh` | Installs Docker, Docker Compose, and related tools |
| `vscode.zsh` | Installs Visual Studio Code and essential extensions |
| `jetbrains.zsh` | Installs JetBrains IDEs (IntelliJ, PyCharm, etc.) |
| `sublime.zsh` | Installs Sublime Text editor |
| `atom.zsh` | Installs Atom editor |
| `yarn.zsh` | Installs Yarn package manager |

### Productivity Tools

| Script | Description |
|:-------|:------------|
| `productivity.zsh` | Installs productivity applications like Alfred, Rectangle, Notion, 1Password, and Obsidian |

### Communication Tools

| Script | Description |
|:-------|:------------|
| `communication.zsh` | Installs communication tools like Slack, Discord, Zoom, and Microsoft Teams |

### Browsers

| Script | Description |
|:-------|:------------|
| `browsers.zsh` | Installs web browsers (Chrome, Firefox, Brave) |

### Media Tools

| Script | Description |
|:-------|:------------|
| `media.zsh` | Installs media tools like VLC, Spotify, GIMP, FFmpeg, and ImageMagick |

### Utilities

| Script | Description |
|:-------|:------------|
| `utilities.zsh` | Installs utilities like The Unarchiver, AppCleaner, htop, wget, tree, jq, ripgrep, and fd |

### macOS Preferences

| Script | Description |
|:-------|:------------|
| `preferences.zsh` | Configures macOS system preferences for optimal development experience |



## Contributing

Contributions to the Jarvis Toolset are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

* [Victor Cavalcante](https://github.com/vcavalcante/) for the inspiration and guidance
* [Cătălin Mariș](https://github.com/alrra) for the scripts and enhancements
* All the open-source projects that make this toolset possible
