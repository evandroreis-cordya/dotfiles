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

## Recent Updates (March 2025)

The following improvements have been made to the Jarvis Toolset:

- **Fixed Script Paths**: Corrected path references in all installation scripts to ensure proper sourcing of utility files
- **Enhanced Error Handling**: Added `nullglob` option to handle cases where glob patterns don't match any files
- **Improved Logging**: Added comprehensive logging throughout the installation process
- **Script Organization**: Restructured the installation scripts for better maintainability
- **Email Configuration**: Fixed email variable handling in setup scripts
- **Cleanup and Validation**: Added proper cleanup and validation scripts to ensure successful installations

## Core Files

Review the code and remove anything you find unnecessary. The main files you should review are:

| File | Purpose |
|------|---------|
| `start_jarvis.zsh` | Main entry script that calls setup.zsh with default arguments |
| `setup.zsh` | Main setup script and hub for calling other scripts |
| `create_local_config_files.zsh` | Creation of local configurations (.local) |

## Directory Structure

The Jarvis Toolset follows a modular organization with scripts grouped by functionality:

| Directory | Purpose |
|-----------|---------|
| `scripts/os/install/macos/system/` | System setup scripts (Xcode, Homebrew, Oh My Zsh) |
| `scripts/os/install/macos/dev_langs/` | Development language installations (Python, Node.js, Ruby, etc.) |
| `scripts/os/install/macos/dev_tools/` | Development tools (Git, Docker, VSCode, JetBrains, etc.) |
| `scripts/os/install/macos/data_science/` | Data science environment setup |
| `scripts/os/install/macos/web_tools/` | Web and frontend development tools |
| `scripts/os/install/macos/daily_tools/` | Daily utilities (browsers, productivity apps, etc.) |
| `scripts/os/install/macos/media_tools/` | Media and creative tools |
| `scripts/os/install/macos/creative_tools/` | Creative and 3D design tools (Blender, Maya, ZBrush, etc.) |
| `scripts/os/install/macos/cloud_tools/` | Cloud and DevOps tools |
| `scripts/os/install/macos/ai_tools/` | AI and productivity tools (including Anthropic libraries and MCP servers/clients) |
| `scripts/os/install/macos/app_store/` | App Store applications and system tools |

## Script Groups

When running the setup script, you can select which groups of tools to install:

| Group | Description |
|-------|-------------|
| `system` | System Setup (Xcode, Homebrew, Oh My Zsh) |
| `dev_langs` | Development Languages (Python, Node, Ruby, Go, Java, Kotlin, Rust, Swift, PHP, C++) |
| `data_science` | Data Science Environment |
| `dev_tools` | Development Tools (Git, Docker, VSCode, JetBrains, Yarn) |
| `web_tools` | Web and Frontend Tools |
| `daily_tools` | Daily Tools and Utilities (Browsers, Compression, Misc, Office) |
| `media_tools` | Media and Creative Tools |
| `creative_tools` | Creative and 3D Design Tools (Blender, Maya, ZBrush, Unity, Unreal) |
| `cloud_tools` | Cloud and DevOps Tools |
| `ai_tools` | AI and Productivity Tools (including Anthropic Libraries and MCP Servers/Clients) |
| `app_store` | App Store and System Tools |

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

## Installed Tools by Category

Below is a comprehensive list of tools installed by the Jarvis Toolset, organized by script group.

### System Setup

| Tool | Description |
|------|-------------|
| **Xcode Command Line Tools** | Essential development tools for macOS, including compilers, libraries, and header files required for building software on macOS. |
| **Homebrew** | The missing package manager for macOS that simplifies the installation of software and tools. |
| **Oh My Zsh** | A delightful, open source, community-driven framework for managing your Zsh configuration, bundled with thousands of helpful functions, plugins, and themes. |
| **Powerlevel10k** | A Zsh theme that emphasizes speed, flexibility, and out-of-the-box experience with beautiful UI components. |
| **Zsh Plugins** | Various plugins for Zsh including syntax highlighting, autosuggestions, and completions to enhance your terminal experience. |

### Development Languages

| Tool | Description |
|------|-------------|
| **Python** | A powerful programming language that lets you work quickly and integrate systems more effectively. Includes pip and virtual environments. |
| **Node.js** | A JavaScript runtime built on Chrome's V8 JavaScript engine for building scalable network applications. |
| **Ruby** | A dynamic, open source programming language with a focus on simplicity and productivity. |
| **Go** | An open source programming language designed for building simple, reliable, and efficient software. |
| **Java** | A class-based, object-oriented programming language designed for portability and cross-platform development. |
| **Kotlin** | A modern programming language that makes developers happier. Concise, safe, interoperable with Java. |
| **Rust** | A language empowering everyone to build reliable and efficient software with memory safety guarantees. |
| **Swift** | A powerful and intuitive programming language for macOS, iOS, watchOS, and tvOS. |
| **PHP** | A popular general-purpose scripting language especially suited for web development. |
| **C++** | A general-purpose programming language with a bias toward systems programming and embedded, resource-constrained software. |

### Data Science Environment

| Tool | Description |
|------|-------------|
| **Jupyter** | An open-source web application that allows you to create and share documents containing live code, equations, visualizations, and narrative text. |
| **Pandas** | A fast, powerful, flexible and easy to use open source data analysis and manipulation tool built on top of Python. |
| **NumPy** | The fundamental package for scientific computing with Python, providing support for arrays, matrices, and mathematical functions. |
| **SciPy** | An open-source Python library used for scientific computing and technical computing, containing modules for optimization, linear algebra, integration, and statistics. |
| **Matplotlib** | A comprehensive library for creating static, animated, and interactive visualizations in Python. |
| **scikit-learn** | A machine learning library for Python that features various classification, regression and clustering algorithms. |
| **R** | A language and environment for statistical computing and graphics, providing a wide variety of statistical and graphical techniques. |
| **RStudio** | An integrated development environment (IDE) for R, with a console, syntax-highlighting editor, and tools for plotting, history, debugging, and workspace management. |

### Development Tools

| Tool | Description |
|------|-------------|
| **Git** | A distributed version control system for tracking changes in source code during software development. |
| **Docker** | A platform for developing, shipping, and running applications in containers, enabling isolation and portability. |
| **Visual Studio Code** | A lightweight but powerful source code editor with built-in support for JavaScript, TypeScript and Node.js and a rich ecosystem of extensions for other languages. |
| **JetBrains Tools** | A suite of integrated development environments including IntelliJ IDEA, PyCharm, WebStorm, and more. |
| **Vim** | A highly configurable text editor built to make creating and changing any kind of text very efficient. |
| **Tmux** | A terminal multiplexer that allows you to access multiple separate terminal sessions inside a single terminal window or remote terminal session. |
| **Yarn** | A fast, reliable, and secure dependency management tool for JavaScript projects. |
| **Database Tools** | Various database management tools for MySQL, PostgreSQL, MongoDB, and other database systems. |

### Web and Frontend Tools

| Tool | Description |
|------|-------------|
| **Node.js** | A JavaScript runtime built on Chrome's V8 JavaScript engine for building scalable network applications. |
| **npm** | A package manager for JavaScript, allowing developers to install and manage package dependencies. |
| **Webpack** | A static module bundler for modern JavaScript applications, creating a dependency graph of modules. |
| **Babel** | A JavaScript compiler that converts ECMAScript 2015+ code into a backwards compatible version of JavaScript. |
| **ESLint** | A pluggable and configurable linter tool for identifying and reporting on patterns in JavaScript. |
| **Prettier** | An opinionated code formatter that enforces a consistent style by parsing your code and re-printing it. |
| **React Developer Tools** | Browser DevTools extension for inspecting the React component hierarchies in the Chrome Developer Tools. |
| **Vue DevTools** | Browser DevTools extension for debugging Vue.js applications. |

### Daily Tools and Utilities

| Tool | Description |
|------|-------------|
| **Google Chrome** | A fast, secure, and free web browser built for the modern web. |
| **Firefox** | A free and open-source web browser developed by the Mozilla Foundation. |
| **Brave** | A free and open-source web browser focused on privacy and security. |
| **Slack** | A business communication platform offering many IRC-style features, including persistent chat rooms organized by topic, private groups, and direct messaging. |
| **Zoom** | A video conferencing tool with a local, desktop client and a mobile app that allows users to meet online. |
| **Alfred** | A productivity application for macOS, helping you to search your Mac and the web, and control your Mac using custom actions. |
| **Rectangle** | A window management app based on Spectacle, written in Swift, allowing you to move and resize windows using keyboard shortcuts or snap areas. |
| **The Unarchiver** | A small and easy to use program that can unarchive many different kinds of archive files. |

### Media and Creative Tools

| Tool | Description |
|------|-------------|
| **Adobe Creative Cloud** | A collection of applications for graphic design, video editing, web development, photography, and cloud services. |
| **GIMP** | A free and open-source raster graphics editor used for image retouching and editing, free-form drawing, and more. |
| **Inkscape** | A free and open-source vector graphics editor used to create vector images, primarily in Scalable Vector Graphics (SVG) format. |
| **Audacity** | A free, open source, cross-platform audio software for multi-track recording and editing. |
| **VLC** | A free and open source cross-platform multimedia player and framework that plays most multimedia files. |
| **Blender** | A free and open-source 3D computer graphics software toolset used for creating animated films, visual effects, art, 3D printed models, and more. |
| **OBS Studio** | Free and open source software for video recording and live streaming. |

### Creative and 3D Design Tools

| Tool | Description |
|------|-------------|
| **Blender** | A free and open-source 3D computer graphics software toolset used for creating animated films, visual effects, art, 3D printed models, and more. |
| **Maya** | A 3D computer animation, modeling, simulation, and rendering software used in the film, television, and video game industries. |
| **ZBrush** | A digital sculpting and painting software that combines 3D modeling, texturing, and painting. |
| **Unity** | A cross-platform game engine and development environment for creating 2D and 3D games, simulations, and interactive experiences. |
| **Unreal Engine** | A game engine developed by Epic Games, providing a comprehensive set of tools for building high-performance, visually stunning games and applications. |

### Cloud and DevOps Tools

| Tool | Description |
|------|-------------|
| **AWS CLI** | A unified tool to manage your AWS services from the command line. |
| **Google Cloud SDK** | A set of tools for Google Cloud Platform, including the gcloud, gsutil, and bq command-line tools. |
| **Azure CLI** | A command-line tool for managing Azure resources. |
| **Terraform** | An open-source infrastructure as code software tool that provides a consistent CLI workflow to manage cloud services. |
| **Kubernetes CLI (kubectl)** | A command-line tool for controlling Kubernetes clusters. |
| **Helm** | A package manager for Kubernetes that helps you manage Kubernetes applications. |
| **Ansible** | An open-source software provisioning, configuration management, and application-deployment tool. |
| **Vercel CLI** | A command-line interface to interact with Vercel's platform for frontend deployment. |

### AI and Productivity Tools

| Tool | Description |
|------|-------------|
| **TensorFlow** | An end-to-end open source platform for machine learning, providing a comprehensive ecosystem of tools, libraries, and community resources. |
| **PyTorch** | An open source machine learning library based on the Torch library, used for applications such as computer vision and natural language processing. |
| **Hugging Face Transformers** | A library of state-of-the-art pre-trained models for Natural Language Processing (NLP). |
| **OpenAI Tools** | Various tools and libraries for working with OpenAI's models and APIs. |
| **Anthropic Claude SDK** | Tools and libraries for integrating with Anthropic's Claude AI assistant. |
| **MCP Server** | Anthropic's Model Control Protocol server for managing AI model deployments. |
| **MCP Client** | Client libraries for interacting with MCP servers and AI models. |
| **Jupyter AI** | Extensions for Jupyter notebooks that integrate AI capabilities into your data science workflow. |
| **LangChain** | A framework for developing applications powered by language models, focusing on composition and modularity. |

### App Store and System Tools

| Tool | Description |
|------|-------------|
| **Xcode** | Apple's integrated development environment for macOS, containing a suite of software development tools. |
| **Keynote** | Apple's presentation software, part of the iWork productivity suite. |
| **Pages** | Apple's word processor, part of the iWork productivity suite. |
| **Numbers** | Apple's spreadsheet application, part of the iWork productivity suite. |
| **1Password** | A password manager that stores sensitive information in a secure vault locked with a master password. |
| **CleanMyMac X** | A macOS cleaning, optimization, and maintenance application. |
| **Little Snitch** | A host-based application firewall for macOS that monitors and controls applications' outgoing network connections. |
| **Magnet** | A window manager that keeps your workspace organized by allowing you to snap windows to different positions. |

## Available Scripts

The jarvistoolset includes a comprehensive set of installation scripts organized by category:

### System Setup Scripts

| Script | Description |
|-------|-------------|
| `xcode.zsh` | Installs Xcode and command line tools |
| `homebrew.zsh` | Installs Homebrew package manager and core packages |
| `oh_my_zsh.zsh` | Installs and configures Oh My Zsh with custom themes and plugins |

### Development Languages

| Script | Description |
|-------|-------------|
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
|-------|-------------|
| `ai_ml.zsh` | Installs TensorFlow, PyTorch, Jupyter, and other ML tools |

### Development Tools

| Script | Description |
|-------|-------------|
| `git.zsh` | Configures Git and installs Git-related tools |
| `docker.zsh` | Installs Docker, Docker Compose, and related tools |
| `vscode.zsh` | Installs Visual Studio Code and essential extensions |
| `jetbrains.zsh` | Installs JetBrains IDEs (IntelliJ, PyCharm, etc.) |
| `sublime.zsh` | Installs Sublime Text editor |
| `atom.zsh` | Installs Atom editor |
| `yarn.zsh` | Installs Yarn package manager |

### Productivity Tools

| Script | Description |
|-------|-------------|
| `productivity.zsh` | Installs productivity applications like Alfred, Rectangle, Notion, 1Password, and Obsidian |

### Communication Tools

| Script | Description |
|-------|-------------|
| `communication.zsh` | Installs communication tools like Slack, Discord, Zoom, and Microsoft Teams |

### Browsers

| Script | Description |
|-------|-------------|
| `browsers.zsh` | Installs web browsers (Chrome, Firefox, Brave) |

### Media Tools

| Script | Description |
|-------|-------------|
| `media.zsh` | Installs media tools like VLC, Spotify, GIMP, FFmpeg, and ImageMagick |

### Creative and 3D Design Tools

| Script | Description |
|-------|-------------|
| `creative_3d_tools.zsh` | Installs professional 3D design and creative tools like Blender, Maya, ZBrush, Unity, Unreal Engine, and more |

### Utilities

| Script | Description |
|-------|-------------|
| `utilities.zsh` | Installs utilities like The Unarchiver, AppCleaner, htop, wget, tree, jq, ripgrep, and fd |

### macOS Preferences

| Script | Description |
|-------|-------------|
| `preferences.zsh` | Configures macOS system preferences for optimal development experience |

## Troubleshooting

If you encounter issues during the installation process, here are some common solutions:

### Path-related Errors

If you see errors like `no such file or directory: .../utils.zsh`, it may be due to incorrect path references. The recent update should have fixed these issues, but if they persist:

1. Check that the script is correctly sourcing utility files with the right relative paths
2. Ensure all scripts have the proper `SCRIPT_DIR` variable defined
3. Verify that the directory structure matches what the scripts expect

### Installation Failures

If specific tools fail to install:

1. Check the logs in `~/.jarvistoolset/logs/` for detailed error information
2. Try running the specific installation script manually to see more detailed output
3. Ensure you have proper internet connectivity and sufficient disk space

### Configuration Issues

If tools install but don't work properly:

1. Check that the configuration files were created correctly in your home directory
2. Verify that the `.zshrc` file is properly sourcing the modular configurations
3. Try running `source ~/.zshrc` to reload your shell configuration

For additional help, please open an issue on the GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

* [Victor Cavalcante](https://github.com/vcavalcante/) for the inspiration and guidance
* [Cătălin Mariș](https://github.com/alrra) for the scripts and enhancements
* All the open-source projects that make this toolset possible

## Contributing

Contributions to the Jarvis Toolset are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
