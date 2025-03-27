          __                   _       _____            _          _
          \ \  __ _ _ ____   _(_)___  /__   \___   ___ | |___  ___| |_
           \ \/ _` | '__\ \ / / / __|   / /\/ _ \ / _ \| / __|/ _ \ __|
        /\_/ / (_| | |   \ V /| \__ \  / / | (_) | (_) | \__ \  __/ |_
        \___/ \__,_|_|    \_/ |_|___/  \/   \___/ \___/|_|___/\___|\__|

Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition, the complete Mac OS tools and apps installer for AI and Vibe Coders!
Copyright (c) 2025 ARVOS.AI. All rights reserved.

## Introduction

First and foremost, I want to express my gratitude to [Victor Cavalcante](https://github.com/vcavalcante/) (a great friend from Lambda3) who introduced me to the concept of dotfiles and guided me through his tutorial. Thank you, brother. Special thanks also to [Cătălin Mariș](https://github.com/alrra) for the scripts and enhancements. The configurations that follow are based on their initial work.

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

## Programming Languages and Development Tools

The jarvistoolset now includes comprehensive support for various programming languages and development tools, each with its own modular configuration file:

| Language/Tool | Script | Configuration File | Features |
|:--------------|:-------|:-------------------|:---------|
| **C/C++** | `cpp.zsh` | `zsh_configs/cpp.zsh` | GCC, Clang, CMake, Boost, debugging tools, project creation |
| **Go** | `go.zsh` | `zsh_configs/go.zsh` | Go compiler, environment variables, project creation |
| **Java** | `java.zsh` | `zsh_configs/java.zsh` | JDK, Maven, Gradle, environment setup |
| **Kotlin** | `kotlin.zsh` | `zsh_configs/kotlin.zsh` | Kotlin compiler, environment variables |
| **Node.js** | `nodejs.zsh` | `zsh_configs/nodejs.zsh` | NVM, npm, yarn, environment setup |
| **PHP** | `php.zsh` | `zsh_configs/php.zsh` | PHP, Composer, environment variables |
| **Python** | `python.zsh` | `zsh_configs/python.zsh` | Python, pip, virtualenv, pyenv |
| **Ruby** | `ruby.zsh` | `zsh_configs/ruby.zsh` | Ruby, RVM, gems, environment setup |
| **Rust** | `rust.zsh` | `zsh_configs/rust.zsh` | Rust, Cargo, environment variables |
| **Swift** | `swift.zsh` | `zsh_configs/swift.zsh` | Swift compiler, development tools, project creation |
| **Xcode** | `xcode.zsh` | `zsh_configs/xcode.zsh` | Xcode CLI tools, iOS/macOS development utilities |

Each script installs the necessary tools and creates a dedicated configuration file with environment variables, aliases, and functions specific to that language or tool.

## AI and Machine Learning Tools

The jarvistoolset now includes comprehensive support for AI and machine learning development with the following categories of tools:

### AI Desktop Applications

The `ai_desktop_tools.zsh` script installs a wide range of AI desktop applications:

| Category | Applications |
|:---------|:------------|
| **Local LLM Platforms** | Ollama, OllamaC, NotesOllama, LM Studio |
| **AI Chat Clients** | ChatGPT Desktop, Cursor AI Code Editor |
| **AI Image Generation** | DiffusionBee, Mochi Diffusion, Topaz Photo AI Suite |
| **AI Video Tools** | Runway, D-ID Studio, Synthesia |
| **AI Writing & Productivity** | Notion, Grammarly, Raindrop.io, ProWritingAid |
| **AI Development Environments** | VS Code, JupyterLab, Jupyter Notebook Viewer, Anaconda |
| **AI Research Tools** | Zotero, Mendeley Reference Manager |
| **AI Generative Art** | ChaiNNer |
| **AI Utilities** | Geekbench AI, MacAI, BoltAI, BackyardAI |

Additionally, the script provides information about AI tools that need to be installed manually, such as ElevenLabs, Stable Diffusion WebUI, ComfyUI, and web-based AI services like Midjourney, Claude, and Gemini.

### AI Development Tools

The `ai_tools.zsh` script installs essential AI development libraries and tools:

- Python-based AI frameworks and libraries
- Machine learning model development tools
- Data processing utilities
- Natural language processing libraries

### Swift Development Tools

The `swift.zsh` script has been updated to provide better installation of Swift development tools:

- SwiftLint for code quality
- SwiftFormat for code formatting
- Sourcery for code generation
- Carthage and Mint for dependency management
- Fastlane for CI/CD
- Other Swift development utilities

## Available Scripts

| Category | Script | Description |
|:---------|:-------|:------------|
| **Core** | |
| | `start_jarvis.zsh` | Main entry script that calls setup.zsh with default arguments |
| | `setup.zsh` | Main setup script to initialize the jarvistoolset |
| | `utils.zsh` | Core utility functions used by other scripts |
| | `create_directories.zsh` | Creates XDG-compliant directory structure |
| | `create_local_config_files.zsh` | Creates local configuration files |
| | `create_symbolic_links.zsh` | Creates symbolic links for configuration files |
| | `initialize_git_repository.zsh` | Initializes Git repository for the jarvistoolset |
| | `update_content.zsh` | Updates jarvistoolset from repository |
| | `restart.zsh` | Safely restarts the system |
| | `set_github_ssh_key.zsh` | Sets up SSH key for GitHub |
| | `activate_datascience.sh` | Activates the Python data science environment with all installed packages |
| | `fix_specific_files.zsh` | Fixes specific files that might need adjustments |
| | `update_bash_to_zsh.zsh` | Updates Bash configuration to Zsh |
| **Installation** | |
| | `install/main.zsh` | Main installation orchestration script |
| | `install/macos/main.zsh` | Main macOS installation script |
| | `install/macos/homebrew.zsh` | Installs Homebrew and core packages |
| | `install/macos/mas.zsh` | Installs Mac App Store applications |
| | `install/macos/xcode.zsh` | Installs Xcode and command line tools |
| | `install/macos/apps.zsh` | Installs general applications |
| | `install/macos/browsers.zsh` | Installs web browsers |
| | `install/macos/browser_tools.zsh` | Installs browser extensions including Raindrop.io |
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
| | `install/macos/generative_ai_productivity.zsh` | Installs top 10 Generative AI productivity tools |
| | `install/macos/ai_desktop_tools.zsh` | Installs AI desktop applications and tools |
| | `install/macos/ai_tools.zsh` | Installs AI development libraries and tools |
| | `install/macos/ai_bookmarks.zsh` | Creates AI tools and models bookmarks in browsers |
| | `install/macos/swift.zsh` | Installs Swift development tools with improved error handling |
| | `install/macos/oh_my_zsh.zsh` | Installs and configures Oh My Zsh with custom themes and plugins |
| | `install/macos/cleanup.zsh` | Cleans up after installation |
| | `install/npm.zsh` | Installs NPM packages |
| | `install/nvm.zsh` | Installs Node Version Manager |
| | `install/vim.zsh` | Installs Vim plugins |
| **Development** | |
| | `install/macos/node.zsh` | Sets up Node.js development environment |
| | `install/macos/php.zsh` | Configures PHP development environment |
| | `install/macos/python.zsh` | Sets up Python development environment |
| | `install/macos/datascience.zsh` | Sets up Data Science environment with ML/AI packages |
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
| | `preferences/macos/mail.zsh` | Mail app settings |
| | `preferences/macos/maps.zsh` | Maps app settings |
| | `preferences/macos/messages.zsh` | Messages app settings |
| | `preferences/macos/mission_control.zsh` | Mission Control settings |
| | `preferences/macos/mouse.zsh` | Mouse settings |
| | `preferences/macos/energy.zsh` | Energy saver settings |
| | `preferences/macos/firefox.zsh` | Firefox browser settings |
| | `preferences/macos/icloud.zsh` | iCloud settings |
| | `preferences/macos/music.zsh` | Music app settings |
| | `preferences/macos/network.zsh` | Network settings |
| | `preferences/macos/notifications.zsh` | Notification settings |
| | `preferences/macos/photos.zsh` | Photos app settings |
| | `preferences/macos/safari.zsh` | Safari browser settings |
| | `preferences/macos/screen.zsh` | Screen settings |
| | `preferences/macos/security_tools.zsh` | Security tools settings |
| | `preferences/macos/sharing.zsh` | Sharing settings |
| | `preferences/macos/siri.zsh` | Siri settings |
| | `preferences/macos/software_update.zsh` | Software update settings |
| | `preferences/macos/sound.zsh` | Sound settings |
| | `preferences/macos/spotlight.zsh` | Spotlight settings |
| | `preferences/macos/system.zsh` | System settings |
| | `preferences/macos/textedit.zsh` | TextEdit settings |
| | `preferences/macos/time_machine.zsh` | Time Machine settings |
| | `preferences/macos/users_groups.zsh` | Users & Groups settings |
| **AI Tools** | |
| | `preferences/macos/ai_tools.zsh` | Installs and configures general AI development tools |
| | `preferences/macos/ai_desktop_tools.zsh` | Installs AI desktop applications |
| | `preferences/macos/generative_ai.zsh` | Sets up generative AI tools and libraries |
| | `preferences/macos/ml_tools.zsh` | Configures machine learning tools and libraries |
| | `preferences/macos/autonomous_agents.zsh` | Sets up autonomous agent frameworks |
| | `preferences/macos/backend_tools.zsh` | Installs backend development tools for AI |
| | `preferences/macos/frontend_tools.zsh` | Installs frontend development tools for AI |
| **Vendor AI Tools** | |
| | `preferences/macos/openai_tools.zsh` | Installs OpenAI-specific tools and SDKs |
| | `preferences/macos/anthropic_tools.zsh` | Installs Anthropic-specific tools and SDKs |
| | `preferences/macos/google_ai_tools.zsh` | Installs Google AI tools and SDKs |
| | `preferences/macos/meta_ai_tools.zsh` | Installs Meta AI tools and SDKs |
| | `preferences/macos/amazon_ai_tools.zsh` | Installs Amazon AI tools and SDKs |
| | `preferences/macos/azure_ai_tools.zsh` | Installs Microsoft Azure AI tools |
| | `preferences/macos/nvidia_tools.zsh` | Installs NVIDIA AI and ML tools |
| | `preferences/macos/oracle_ai_tools.zsh` | Installs Oracle AI tools and SDKs |
| | `preferences/macos/grok_tools.zsh` | Installs Grok AI tools and SDKs |
| | `preferences/macos/kaspersky_tools.zsh` | Installs Kaspersky security AI tools |
| | `preferences/macos/vercel_tools.zsh` | Installs Vercel AI tools and SDKs |

## Browser Extensions and Tools

The jarvistoolset installs and configures a variety of browser extensions to enhance your browsing experience:

### AI Extensions
- ChatGPT for Brave
- Claude AI
- Bard AI (Google Gemini)
- GitHub Copilot

### Productivity Extensions
- Notion Web Clipper
- Grammarly
- Todoist
- Raindrop.io Bookmarks Manager

### Development Extensions
- React Developer Tools
- Redux DevTools
- Vue DevTools
- JSON Viewer
- And more...

### AI Bookmarks

The `ai_bookmarks.zsh` script creates a dedicated "AI Tools and Models" folder in your browser's bookmarks bar, containing links to popular AI tools and services:

- ElevenLabs - Voice AI and text-to-speech
- Hugging Face - AI model repository and community
- Stable Diffusion WebUI - Image generation interface
- ComfyUI - Node-based UI for Stable Diffusion
- Claude - Anthropic's conversational AI
- Weights & Biases - ML experiment tracking
- Midjourney - AI image generation
- Leonardo.AI - Creative AI platform
- Perplexity AI - AI-powered search engine
- ChatGPT - OpenAI's conversational model
- Google Gemini - Google's multimodal AI
- Whisper Studio - Speech recognition playground
- Replicate - Cloud AI model deployment
- Hugging Face Spaces - Hosted AI demos
- RunwayML - Creative AI tools
- Ollama - Run LLMs locally
- LM Studio - Local LLM interface

This makes it easy to access all your AI tools from one organized location in your browser.

## Modular Configuration System

The jarvistoolset uses a modular configuration approach that keeps your shell environment clean and organized:

### How It Works

1. Each tool or language creates its own configuration file in `$HOME/.jarvistoolset/zsh_configs/`
2. A single entry in your `.zshrc` loads all these configuration files automatically
3. No duplicate entries or conflicts between different tools

### Benefits

- **Clean Organization**: Related configurations stay together
- **Easy Maintenance**: Update one tool without affecting others
- **No Duplication**: Prevents multiple entries of the same configuration
- **Simple Troubleshooting**: Isolate issues to specific configuration files

### Supported Tools

The following tools use the modular configuration system:

| Tool/Language | Configuration File | Contents |
|:--------------|:-------------------|:---------|
| Swift | `swift.zsh` | Swift environment variables, aliases, and functions |
| C/C++ | `cpp.zsh` | C/C++ compiler settings, build tools, and project templates |
| Xcode | `xcode.zsh` | Xcode command line tools and iOS/macOS development settings |
| Python | `python.zsh` | Python environment, virtualenv, and package management |
| Node.js | `nodejs.zsh` | Node.js version management and npm configuration |
| Ruby | `ruby.zsh` | Ruby environment, gems, and version management |
| Go | `go.zsh` | Go environment variables and workspace settings |
| Java | `java.zsh` | Java environment variables and build tool configuration |
| Kotlin | `kotlin.zsh` | Kotlin compiler and environment settings |
| Rust | `rust.zsh` | Rust toolchain and Cargo configuration |

## Happy Vibe Coding! :)
