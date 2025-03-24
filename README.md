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
cd ~/.jarvistoolset
./start_jarvis.zsh
```

Alternatively, you can run the setup script directly:
```bash
~/.jarvistoolset/start_jarvis.zsh
```

## Core Files

Review the code and remove anything you find unnecessary. The main files you should review are:

| File | Purpose |
|------|---------|
| `start_jarvis.zsh` | Main entry script that calls setup.zsh with default arguments |
| `setup.zsh` | Main setup script and hub for calling other scripts |
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

### 5. Running start_jarvis.zsh

To set up the dotfiles, execute the appropriate snippet in your terminal:

(:warning: **DO NOT** execute "start_jarvis.zsh" if you don't fully understand what it does. Seriously, **DO NOT RUN IT** unless you've reviewed the code!)

| OS | Snippet |
|:---|:--------|
| `macOS` | `zsh -c "$(curl -LsS https://raw.github.com/YOUR_USERNAME/jarvistoolset/master/start_jarvis.zsh)"` |

That's it! :sparkles:

The start_jarvis.zsh script will call setup.zsh which will:

* Download the dotfiles to your computer (default location: `~/.jarvistoolset`)
* Create necessary directories following the [XDG Base Directory Specification](scripts/os/create_directories.zsh)
* Create [local configuration files](scripts/os/create_local_config_files.zsh) for git and shell
* Install applications and command-line tools for [`macOS`](scripts/os/install/macos)
* Configure system preferences for [`macOS`](scripts/os/preferences/macos)

## Available Scripts

| Category | Script | Description |
|:---------|:-------|:------------|
| **Core** | |
| | `start_jarvis.zsh` | Main entry script that calls setup.zsh with default arguments |
| | `setup.zsh` | Main setup script to initialize the dotfiles |
| | `utils.zsh` | Core utility functions used by other scripts |
| | `create_directories.zsh` | Creates XDG-compliant directory structure |
| | `create_local_config_files.zsh` | Creates local configuration files |
| | `create_symbolic_links.zsh` | Creates symbolic links for configuration files |
| | `initialize_git_repository.zsh` | Initializes Git repository for the dotfiles |
| | `update_content.zsh` | Updates dotfiles from repository |
| | `restart.zsh` | Safely restarts the system |
| | `set_github_ssh_key.zsh` | Sets up SSH key for GitHub |
| **Installation** | |
| | `install/main.zsh` | Main installation orchestration script |
| | `install/macos/main.zsh` | Main macOS installation script |
| | `install/macos/homebrew.zsh` | Installs Homebrew and core packages |
| | `install/macos/mas.zsh` | Installs Mac App Store applications |
| | `install/macos/xcode.zsh` | Installs Xcode and command line tools |
| | `install/macos/apps.zsh` | Installs general applications |
| | `install/macos/browsers.zsh` | Installs web browsers |
| | `install/macos/docker.zsh` | Installs Docker and related tools |
| | `install/macos/git.zsh` | Configures Git and installs related tools |
| | `install/macos/gpg.zsh` | Sets up GPG for secure communications |
| | `install/macos/bash.zsh` | Configures Bash shell |
| | `install/macos/dailytools.zsh` | Installs daily productivity tools |
| | `install/macos/extratools.zsh` | Installs additional productivity tools |
| | `install/macos/office.zsh` | Installs office and productivity applications |
| | `install/macos/jetbrains.zsh` | Installs JetBrains development tools |
| | `install/macos/visualstudiocode.zsh` | Installs Visual Studio Code |
| | `install/macos/vim.zsh` | Installs and configures Vim |
| | `install/macos/tmux.zsh` | Installs and configures Tmux |
| | `install/macos/utils.zsh` | Installs utility tools |
| | `install/macos/misc.zsh` | Installs miscellaneous tools |
| | `install/macos/misc_tools.zsh` | Installs additional miscellaneous tools |
| | `install/macos/cleanup.zsh` | Cleans up after installation |
| | `install/npm.zsh` | Installs NPM packages |
| | `install/nvm.zsh` | Installs Node Version Manager |
| | `install/vim.zsh` | Installs Vim plugins |
| **Development** | |
| | `install/macos/node.zsh` | Sets up Node.js development environment |
| | `install/macos/php.zsh` | Configures PHP development environment |
| | `install/macos/python.zsh` | Sets up Python development environment |
| | `install/macos/ruby.zsh` | Configures Ruby development environment |
| | `install/macos/go.zsh` | Sets up Go development environment |
| | `install/macos/java.zsh` | Configures Java development environment |
| | `install/macos/kotlin.zsh` | Sets up Kotlin development environment |
| | `install/macos/rust.zsh` | Configures Rust development environment |
| | `install/macos/swift.zsh` | Sets up Swift development environment |
| | `install/macos/yarn.zsh` | Installs Yarn package manager |
| | `install/macos/devtools.zsh` | Installs general development tools |
| | `install/macos/databasetools.zsh` | Installs database tools |
| | `install/macos/compression_tools.zsh` | Installs compression utilities |
| | `install/macos/image_tools.zsh` | Installs image processing tools |
| | `install/macos/video_tools.zsh` | Installs video processing tools |
| | `install/macos/web_font_tools.zsh` | Installs web font tools |
| **Preferences** | |
| | `preferences/main.zsh` | Main preferences orchestration script |
| | `preferences/macos/main.zsh` | Main macOS preferences script |
| | `preferences/macos/ui.zsh` | UI preferences |
| | `preferences/macos/ui_and_ux.zsh` | UI/UX preferences |
| | `preferences/macos/dock.zsh` | Dock preferences and layout |
| | `preferences/macos/finder.zsh` | Finder view and behavior settings |
| | `preferences/macos/keyboard.zsh` | Keyboard and input preferences |
| | `preferences/macos/language.zsh` | Language settings |
| | `preferences/macos/language_and_region.zsh` | Language and region settings |
| | `preferences/macos/security.zsh` | Security and privacy settings |
| | `preferences/macos/terminal.zsh` | Terminal appearance and behavior |
| | `preferences/macos/trackpad.zsh` | Trackpad gestures and sensitivity |
| | `preferences/macos/accessibility.zsh` | Accessibility settings |
| | `preferences/macos/app_store.zsh` | App Store preferences |
| | `preferences/macos/bluetooth.zsh` | Bluetooth settings |
| | `preferences/macos/dashboard.zsh` | Dashboard settings |
| | `preferences/macos/date_time.zsh` | Date and time settings |
| | `preferences/macos/energy.zsh` | Energy saving settings |
| | `preferences/macos/firefox.zsh` | Firefox preferences |
| | `preferences/macos/icloud.zsh` | iCloud settings |
| | `preferences/macos/mail.zsh` | Mail app settings |
| | `preferences/macos/maps.zsh` | Maps app settings |
| | `preferences/macos/messages.zsh` | Messages app settings |
| | `preferences/macos/mission_control.zsh` | Mission Control settings |
| | `preferences/macos/mouse.zsh` | Mouse settings |
| | `preferences/macos/music.zsh` | Music app settings |
| | `preferences/macos/network.zsh` | Network settings |
| | `preferences/macos/notifications.zsh` | Notification settings |
| | `preferences/macos/photos.zsh` | Photos app settings |
| | `preferences/macos/safari.zsh` | Safari preferences |
| | `preferences/macos/screen.zsh` | Screen settings |
| | `preferences/macos/sharing.zsh` | Sharing settings |
| | `preferences/macos/siri.zsh` | Siri settings |
| | `preferences/macos/software_update.zsh` | Software update settings |
| | `preferences/macos/sound.zsh` | Sound settings |
| | `preferences/macos/spotlight.zsh` | Spotlight settings |
| | `preferences/macos/system.zsh` | System settings |
| | `preferences/macos/textedit.zsh` | TextEdit settings |
| | `preferences/macos/time_machine.zsh` | Time Machine settings |
| | `preferences/macos/users_groups.zsh` | Users and groups settings |
| **AI Tools** | |
| | `preferences/macos/ai_tools.zsh` | General AI tools settings |
| | `preferences/macos/ai_desktop_tools.zsh` | Desktop AI tools settings |
| | `preferences/macos/amazon_ai_tools.zsh` | Amazon AI tools settings |
| | `preferences/macos/anthropic_tools.zsh` | Anthropic AI tools settings |
| | `preferences/macos/autonomous_agents.zsh` | Autonomous agents settings |
| | `preferences/macos/azure_ai_tools.zsh` | Azure AI tools settings |
| | `preferences/macos/deepseek_tools.zsh` | DeepSeek AI tools settings |
| | `preferences/macos/generative_ai.zsh` | Generative AI tools settings |
| | `preferences/macos/google_ai_tools.zsh` | Google AI tools settings |
| | `preferences/macos/grok_tools.zsh` | Grok AI tools settings |
| | `preferences/macos/meta_ai_tools.zsh` | Meta AI tools settings |
| | `preferences/macos/ml_tools.zsh` | Machine learning tools settings |
| | `preferences/macos/nvidia_tools.zsh` | NVIDIA AI tools settings |
| | `preferences/macos/openai_tools.zsh` | OpenAI tools settings |
| | `preferences/macos/oracle_ai_tools.zsh` | Oracle AI tools settings |
| | `preferences/macos/vercel_tools.zsh` | Vercel AI tools settings |
| **Other Tools** | |
| | `preferences/macos/backend_tools.zsh` | Backend development tools settings |
| | `preferences/macos/cloud_tools.zsh` | Cloud tools settings |
| | `preferences/macos/communication_tools.zsh` | Communication tools settings |
| | `preferences/macos/creative_tools.zsh` | Creative tools settings |
| | `preferences/macos/frontend_tools.zsh` | Frontend development tools settings |
| | `preferences/macos/kaspersky_tools.zsh` | Kaspersky security tools settings |
| | `preferences/macos/security_tools.zsh` | Security tools settings |

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
