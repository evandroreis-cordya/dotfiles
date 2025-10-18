          __                   _       _____            _          _
          \ \  __ _ _ ____   _(_)___  /__   \___   ___ | |___  ___| |_
           \ \/ _` | '__\ \ / / / __|   / /\/ _ \ / _ \| / __|/ _ \ __|
        /\_/ / (_| | |   \ V /| \__ \  / / | (_) | (_) | \__ \  __/ |_
        \___/ \__,_|_|    \_/ |_|___/  \/   \___/ \___/|_|___/\___|\__|

Welcome to ARVOS.AI Jarvis Toolset 25H1 Edition, the complete multi-platform tools and apps installer for AI and Vibe Coders!
Copyright (c) 2025 ARVOS.AI. All rights reserved.

## Introduction

First and foremost, I want to express my gratitude to [Victor Cavalcante](https://github.com/vcavalcante/) (a great friend from Lambda3) who introduced me to the concept of dotfiles and guided me through his tutorial. Thank you, brother. Special thanks also to [Cătălin Mariș](https://github.com/alrra) for the scripts and enhancements. 

**WARNING:** If you want to use this jarvistoolset and configuration scripts, first fork this repository. **DO NOT** use them without understanding what they do.

```bash
git clone https://github.com/YOUR_USERNAME/jarvistoolset.git ~/.jarvistoolset
```
**WARNING:** If you don't fork this repository, you will not be able to make changes to the configuration files. It must be downloaded from your forked repository. You must clone it in the `~/.jarvistoolset` directory otherwise the script will not work.

## Supported Platforms

The Jarvis Toolset now supports multiple operating systems:

| Platform | Shell | Package Manager | Terminal | Status |
|----------|-------|----------------|----------|--------|
| **macOS** | Zsh | Homebrew | WezTerm | ✅ Fully Supported |
| **Linux** | Zsh (with Bash fallback) | apt/yum/dnf/pacman/zypper | WezTerm | ✅ Fully Supported |
| **Windows** | PowerShell 7+ | winget/chocolatey | WezTerm | ✅ Fully Supported |

### Prerequisites

#### macOS
- macOS 10.15 (Catalina) or later
- Command Line Tools (will be installed if missing)
- Internet connection

#### Linux
- Ubuntu 18.04+, CentOS 7+, Fedora 30+, Arch Linux, or openSUSE
- Bash shell (Zsh will be installed and set as default)
- Internet connection
- sudo privileges

#### Windows
- Windows 10 version 1903 or later / Windows 11
- PowerShell 7.0 or later
- Internet connection
- Administrator privileges

## Quick Start

1. Fork this repository
2. Review and modify the configuration files
3. Run the setup script:

### macOS
```zsh
cd ~/.jarvistoolset
./start_jarvis.zsh
```

### Linux
```bash
cd ~/.jarvistoolset
./start_jarvis.zsh
```

### Windows
```powershell
cd $env:USERPROFILE\.jarvistoolset
.\start_jarvis.ps1
```

## Recent Updates (March 2025)

The following major improvements have been made to the Jarvis Toolset:

### Core System Improvements
- **Fixed Script Paths**: Corrected path references in all installation scripts to ensure proper sourcing of utility files
- **Enhanced Error Handling**: Added `nullglob` option to handle cases where glob patterns don't match any files
- **Improved Logging**: Added comprehensive logging throughout the installation process
- **Script Organization**: Restructured the installation scripts for better maintainability
- **Email Configuration**: Fixed email variable handling in setup scripts
- **Cleanup and Validation**: Added proper cleanup and validation scripts to ensure successful installations

### New Configuration Management System
- **Load Order Management**: Implemented `00_load_order.zsh` to control the sequence of configuration file loading
- **Dependency Resolution**: Added automatic dependency detection and resolution for language configurations
- **Alias Conflict Detection**: Built-in system to detect and document alias conflicts between different tools
- **Modular Configuration**: Enhanced modular approach with better organization and conflict prevention

### Advanced AI and ML Tools
- **Anthropic MCP Integration**: Complete Model Control Protocol (MCP) server and client setup
- **Generative AI Tools**: Comprehensive suite of image generation and AI productivity tools
- **Multi-Platform AI Support**: Tools for OpenAI, Anthropic, Google AI, AWS, Azure, and Meta AI platforms
- **Vector Database Integration**: Support for ChromaDB, Pinecone, Qdrant, and Weaviate
- **AI Security Tools**: Cybersecurity tools with AI-powered threat detection and analysis

### Enhanced Development Environment
- **Conda Integration**: Full Anaconda/Miniconda support with automatic environment management
- **Google Cloud SDK**: Complete Google Cloud Platform development tools
- **IPFS Support**: InterPlanetary File System tools for decentralized development
- **Enhanced Language Support**: Improved configurations for Java, Python, Rust, Go, and other languages

## Core Files

Review the code and remove anything you find unnecessary. The main files you should review are:

| File | Purpose |
|------|---------|
| `start_jarvis.zsh` | Main entry script that calls setup.zsh with default arguments |
| `setup.zsh` | Main setup script and hub for calling other scripts |
| `create_local_config_files.zsh` | Creation of local configurations (.local) |

## Directory Structure

The Jarvis Toolset follows a modular, multi-platform organization with scripts grouped by functionality and platform:

```
.jarvistoolset/
├── generic/                    # Generic configurations and scripts
│   ├── configs/
│   │   ├── shell/             # Generic shell configurations
│   │   └── terminal/          # Generic terminal configurations
│   ├── scripts/
│   │   ├── os/                # Generic OS scripts
│   │   └── shell/             # Generic shell scripts
│   └── install/               # Generic installation scripts
├── macos/                     # macOS-specific configurations
│   ├── configs/
│   │   ├── shell/             # macOS shell configurations
│   │   └── terminal/          # macOS terminal configurations
│   ├── scripts/
│   │   ├── os/                # macOS OS scripts
│   │   └── shell/             # macOS shell scripts
│   ├── install/               # macOS installation scripts
│   └── preferences/           # macOS system preferences
├── linux/                     # Linux-specific configurations
│   ├── configs/
│   │   ├── shell/             # Linux shell configurations
│   │   └── terminal/          # Linux terminal configurations
│   ├── scripts/
│   │   ├── os/                # Linux OS scripts
│   │   └── shell/             # Linux shell scripts
│   ├── install/               # Linux installation scripts
│   └── preferences/           # Linux system preferences
├── windows/                   # Windows-specific configurations
│   ├── configs/
│   │   ├── shell/             # Windows shell configurations
│   │   └── terminal/          # Windows terminal configurations
│   ├── scripts/
│   │   ├── os/                # Windows OS scripts
│   │   └── shell/             # Windows shell scripts
│   ├── install/               # Windows installation scripts
│   └── preferences/           # Windows system preferences
└── logs/                      # Installation and runtime logs
```

### Platform-Specific Features

#### macOS
- **Shell**: Zsh with Oh My Zsh and PowerLevel10k
- **Package Manager**: Homebrew
- **Terminal**: WezTerm
- **System Integration**: macOS preferences, Xcode tools, App Store apps

#### Linux
- **Shell**: Zsh with Oh My Zsh and PowerLevel10k (Bash fallback)
- **Package Manager**: apt, yum, dnf, pacman, or zypper (auto-detected)
- **Terminal**: WezTerm
- **System Integration**: systemd services, Linux-specific tools

#### Windows
- **Shell**: PowerShell 7+ with Oh My Posh
- **Package Manager**: winget or Chocolatey
- **Terminal**: WezTerm
- **System Integration**: Windows features, WSL, Windows-specific tools

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

## Advanced Configuration Management System

The jarvistoolset features a sophisticated configuration management system that ensures optimal loading order and prevents conflicts between different tools and languages.

### Load Order Management

The system uses `00_load_order.zsh` to control the sequence of configuration file loading:

1. **Framework First**: Oh My Zsh loads first to establish the shell framework
2. **Core Exports**: General environment variables are loaded early
3. **Language Dependencies**: Languages load in dependency order (Java before Kotlin, etc.)
4. **Tool Configurations**: Development tools load after languages
5. **Aliases**: General aliases load last to allow overrides
6. **Cloud Services**: External services load after core tools
7. **Final Initializations**: Miscellaneous tools load last

### Dependency Resolution

The system automatically handles dependencies between configurations:
- **Java → Kotlin**: Kotlin configuration loads after Java since it depends on the JVM
- **Python → Conda**: Conda loads after Python for environment management
- **Node.js → NPM/Yarn**: Package managers load after Node.js installation

### Conflict Detection and Resolution

Built-in alias conflict detection system:
- Documents known conflicts between tools
- Provides resolution strategies
- Prevents duplicate alias definitions
- Maintains clean shell environment

### Configuration Files Structure

All configuration files are stored in `$HOME/.jarvistoolset/macos/configs/shell/zsh_configs/`:

| File | Purpose | Load Order |
|------|---------|------------|
| `00_load_order.zsh` | Load order management and conflict detection | 1 |
| `ohmyzsh.zsh` | Oh My Zsh framework initialization | 2 |
| `exports.zsh` | General environment variables | 3 |
| `java.zsh` | Java, SDKMAN, Maven, Gradle | 4 |
| `python.zsh` | Python, pyenv, UV package manager | 5 |
| `ruby.zsh` | Ruby, rbenv, bundler | 6 |
| `rust.zsh` | Rust, Cargo | 7 |
| `go.zsh` | Go language and tools | 8 |
| `swift.zsh` | Swift compiler and tools | 9 |
| `kotlin.zsh` | Kotlin (depends on Java) | 10 |
| `node.zsh` | Node.js, NVM | 11 |
| `php.zsh` | PHP, Composer | 12 |
| `cpp.zsh` | C/C++, LLVM | 13 |
| `homebrew.zsh` | Homebrew package manager | 14 |
| `xcode.zsh` | Xcode development tools | 15 |
| `docker.zsh` | Docker and Docker Compose | 16 |
| `gpg.zsh` | GPG encryption tools | 17 |
| `anthropic.zsh` | Anthropic MCP server and tools | 18 |
| `ipfs.zsh` | IPFS decentralized storage | 19 |
| `aliases.zsh` | General aliases and shortcuts | 20 |
| `gcloud.zsh` | Google Cloud SDK | 21 |
| `conda.zsh` | Conda package manager | 22 |
| `misc.zsh` | Final initializations (WezTerm, etc.) | 23 |

### Benefits of This Approach

- **Prevents Conflicts**: Load order prevents tool conflicts and duplicate definitions
- **Dependency Management**: Automatic handling of tool dependencies
- **Easy Maintenance**: Individual configuration files are easy to modify or disable
- **Performance Optimization**: Optimal loading sequence for fastest shell startup
- **Debugging Support**: Clear load order makes troubleshooting easier
- **Modular Design**: Each tool has its own isolated configuration space

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

## Installation Instructions

### macOS Installation

1. **Prerequisites**:
   ```zsh
   # Install Xcode Command Line Tools
   xcode-select --install
   ```

2. **Clone and Setup**:
   ```zsh
   # Fork and clone the repository
   git clone https://github.com/YOUR_USERNAME/jarvistoolset.git ~/.jarvistoolset
   cd ~/.jarvistoolset
   
   # Run the setup script
   ./start_jarvis.zsh
   ```

3. **Post-Installation**:
   - Restart your terminal or run `source ~/.zshrc`
   - WezTerm will be installed and configured as the default terminal
   - PowerLevel10k will prompt you to configure your prompt

### Linux Installation

1. **Prerequisites**:
   ```bash
   # Update package list
   sudo apt update  # Ubuntu/Debian
   # or
   sudo yum update   # CentOS/RHEL
   # or
   sudo dnf update   # Fedora
   # or
   sudo pacman -Syu  # Arch Linux
   # or
   sudo zypper update # openSUSE
   ```

2. **Clone and Setup**:
   ```bash
   # Fork and clone the repository
   git clone https://github.com/YOUR_USERNAME/jarvistoolset.git ~/.jarvistoolset
   cd ~/.jarvistoolset
   
   # Run the setup script
   ./start_jarvis.zsh
   ```

3. **Post-Installation**:
   - Log out and log back in for Zsh to become the default shell
   - Or run `exec zsh` to switch to Zsh immediately
   - WezTerm will be installed and configured as the default terminal
   - PowerLevel10k will prompt you to configure your prompt

### Windows Installation

1. **Prerequisites**:
   ```powershell
   # Install PowerShell 7+ (if not already installed)
   winget install Microsoft.PowerShell
   
   # Install Windows Package Manager (if not already installed)
   winget install Microsoft.WindowsPackageManager
   ```

2. **Clone and Setup**:
   ```powershell
   # Fork and clone the repository
   git clone https://github.com/YOUR_USERNAME/jarvistoolset.git $env:USERPROFILE\.jarvistoolset
   cd $env:USERPROFILE\.jarvistoolset
   
   # Run the setup script (as Administrator)
   .\start_jarvis.ps1
   ```

3. **Post-Installation**:
   - Restart your terminal or run `refreshenv` to reload environment variables
   - WezTerm will be installed and configured as the default terminal
   - Oh My Posh will be configured with a beautiful theme
   - WSL will be installed if not already present

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

The Jarvis Toolset includes a comprehensive suite of AI and machine learning tools covering all major platforms and use cases:

#### Core AI Platforms

| Tool | Description |
|------|-------------|
| **OpenAI SDK** | Complete Python SDK for OpenAI's GPT models, DALL-E, Whisper, and embeddings |
| **Anthropic Claude SDK** | Official SDK for Claude AI with constitutional AI capabilities |
| **Google Generative AI** | Google's Gemini and PaLM models with multimodal capabilities |
| **AWS AI Services** | SageMaker, Textract, and other AWS machine learning services |
| **Azure AI Platform** | Computer Vision, Text Analytics, and Azure ML services |
| **Meta AI Tools** | PyTorch, Meta's AI research tools and frameworks |

#### Anthropic Model Control Protocol (MCP)

| Tool | Description |
|------|-------------|
| **MCP Server** | Anthropic's Model Control Protocol server for managing AI model deployments |
| **MCP Client** | Client libraries for interacting with MCP servers and AI models |
| **MCP Monitor** | Real-time monitoring and debugging tools for MCP deployments |
| **MCP Security** | Security tools and validation for MCP environments |
| **MCP Dashboard** | Web-based dashboard for MCP server management |

#### Generative AI and Image Processing

| Tool | Description |
|------|-------------|
| **Diffusers** | Hugging Face's library for Stable Diffusion and other diffusion models |
| **Accelerate** | Optimized inference and training acceleration for transformers |
| **Imaginairy** | Advanced image generation and manipulation tools |
| **Real-ESRGAN** | AI-powered image upscaling and restoration |
| **K-Diffusion** | Advanced diffusion model implementations |
| **Compel** | Prompt engineering tools for better AI interactions |

#### Machine Learning Frameworks

| Tool | Description |
|------|-------------|
| **TensorFlow** | Google's end-to-end machine learning platform |
| **PyTorch** | Meta's flexible deep learning framework |
| **Hugging Face Transformers** | State-of-the-art pre-trained models for NLP |
| **LangChain** | Framework for developing applications powered by language models |
| **LlamaIndex** | Data framework for LLM applications |
| **Semantic Kernel** | Microsoft's AI orchestration framework |

#### Vector Databases and Embeddings

| Tool | Description |
|------|-------------|
| **ChromaDB** | Open-source vector database for AI applications |
| **Pinecone** | Managed vector database service |
| **Qdrant** | High-performance vector search engine |
| **Weaviate** | Open-source vector database with GraphQL API |

#### AI Development and Testing

| Tool | Description |
|------|-------------|
| **Jupyter AI** | AI-powered extensions for Jupyter notebooks |
| **Ragas** | Framework for evaluating RAG (Retrieval-Augmented Generation) applications |
| **DeepEval** | Comprehensive evaluation framework for LLM applications |
| **Evaluate** | Hugging Face's evaluation library for ML models |

#### AI Security and Cybersecurity

| Tool | Description |
|------|-------------|
| **AI Security Copilot** | AI-powered security analysis and threat detection |
| **Deepfence** | Cloud-native security platform with AI capabilities |
| **Snyk** | Developer-first security platform with AI-powered vulnerability detection |
| **Security Scorecard** | AI-driven security risk assessment tools |
| **Darktrace** | AI-powered cybersecurity platform |

#### Specialized AI Tools

| Tool | Description |
|------|-------------|
| **Whisper** | OpenAI's automatic speech recognition system |
| **Tiktoken** | Fast BPE tokenizer for OpenAI models |
| **Guidance** | Prompt engineering and control flow for LLMs |
| **Function Calling** | Tools for OpenAI's function calling capabilities |
| **Fine-tuning Tools** | Complete suite for model fine-tuning and customization |

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

## Available Installation Scripts

The jarvistoolset includes a comprehensive set of installation scripts organized by category. Each script group can be installed independently or as part of the complete setup.

### System Setup Scripts

| Script | Description |
|-------|-------------|
| `xcode.zsh` | Installs Xcode and command line tools |
| `homebrew.zsh` | Installs Homebrew package manager and core packages |
| `oh_my_zsh.zsh` | Installs and configures Oh My Zsh with custom themes and plugins |

### Development Languages

| Script | Description |
|-------|-------------|
| `python.zsh` | Installs Python, pip, pyenv, UV package manager, and essential packages |
| `node.zsh` | Installs Node.js, npm, NVM, and core packages |
| `ruby.zsh` | Installs Ruby, rbenv, bundler, and essential gems |
| `go.zsh` | Installs Go language and development tools |
| `java.zsh` | Installs Java JDK, SDKMAN, Maven, and Gradle |
| `kotlin.zsh` | Installs Kotlin compiler and development tools |
| `rust.zsh` | Installs Rust, Cargo, and development tools |
| `swift.zsh` | Installs Swift compiler and development tools |
| `php.zsh` | Installs PHP, Composer, and extensions |
| `cpp.zsh` | Installs C/C++ compilers, LLVM, and build tools |

### AI and Machine Learning Tools

| Script | Description |
|-------|-------------|
| `ai_tools.zsh` | Core AI development tools and frameworks |
| `openai_tools.zsh` | OpenAI SDK, Whisper, DALL-E, and related tools |
| `anthropic_tools.zsh` | Anthropic Claude SDK and MCP server/client tools |
| `google_ai_tools.zsh` | Google Generative AI, Cloud AI Platform tools |
| `amazon_ai_tools.zsh` | AWS AI services, SageMaker, Textract |
| `azure_ai_tools.zsh` | Azure AI Platform, Computer Vision, Text Analytics |
| `meta_ai_tools.zsh` | Meta AI tools, PyTorch, and research frameworks |
| `generative_ai.zsh` | Image generation tools, Stable Diffusion, Diffusers |
| `ml_tools.zsh` | Machine learning frameworks and libraries |
| `autonomous_agents.zsh` | Tools for building autonomous AI agents |

### Development Tools

| Script | Description |
|-------|-------------|
| `git.zsh` | Configures Git and installs Git-related tools |
| `docker.zsh` | Installs Docker, Docker Compose, and related tools |
| `vscode.zsh` | Installs Visual Studio Code and essential extensions |
| `jetbrains.zsh` | Installs JetBrains IDEs (IntelliJ, PyCharm, etc.) |
| `vim.zsh` | Installs Vim with enhanced configuration |
| `tmux.zsh` | Installs Tmux terminal multiplexer |
| `yarn.zsh` | Installs Yarn package manager |
| `databasetools.zsh` | Database management tools (MySQL, PostgreSQL, MongoDB) |

### Web Development Tools

| Script | Description |
|-------|-------------|
| `frontend_tools.zsh` | Frontend development tools (Webpack, Babel, ESLint, Prettier) |
| `backend_tools.zsh` | Backend development tools and frameworks |

### Daily Tools and Utilities

| Script | Description |
|-------|-------------|
| `browsers.zsh` | Web browsers (Chrome, Firefox, Brave, Safari) |
| `communication.zsh` | Communication tools (Slack, Discord, Zoom, Teams) |
| `productivity.zsh` | Productivity apps (Alfred, Rectangle, Notion, 1Password) |
| `office.zsh` | Office and document tools |
| `utilities.zsh` | System utilities (htop, wget, tree, jq, ripgrep, fd) |
| `compression_tools.zsh` | File compression and archiving tools |

### Media and Creative Tools

| Script | Description |
|-------|-------------|
| `media.zsh` | Media tools (VLC, Spotify, GIMP, FFmpeg, ImageMagick) |
| `image_tools.zsh` | Image processing and manipulation tools |
| `video_tools.zsh` | Video editing and processing tools |
| `creative_tools.zsh` | Creative applications and design tools |

### 3D Design and Game Development

| Script | Description |
|-------|-------------|
| `creative_3d_tools.zsh` | Professional 3D design tools (Blender, Maya, ZBrush) |
| `game_dev_tools.zsh` | Game development tools (Unity, Unreal Engine) |

### Cloud and DevOps Tools

| Script | Description |
|-------|-------------|
| `cloud_tools.zsh` | Cloud platform tools (AWS CLI, Azure CLI, Google Cloud SDK) |
| `vercel_tools.zsh` | Vercel deployment and development tools |
| `nvidia_tools.zsh` | NVIDIA GPU development tools |
| `kaspersky_tools.zsh` | Security and antivirus tools |

### Data Science Environment

| Script | Description |
|-------|-------------|
| `datascience.zsh` | Complete data science environment (Jupyter, Pandas, NumPy, SciPy, Matplotlib, scikit-learn, R, RStudio) |

### App Store and System Tools

| Script | Description |
|-------|-------------|
| `app_store.zsh` | App Store applications and system tools |
| `security_tools.zsh` | Cybersecurity tools (Nmap, Wireshark, Burp Suite, Metasploit) |
| `extratools.zsh` | Additional system tools and utilities |
| `mas.zsh` | Mac App Store command line interface |

### macOS System Preferences

| Script | Description |
|-------|-------------|
| `preferences.zsh` | Configures macOS system preferences for optimal development experience |
| `accessibility.zsh` | Accessibility and assistive technology settings |
| `security.zsh` | Security and privacy preferences |
| `dock.zsh` | Dock appearance and behavior |
| `finder.zsh` | Finder view and behavior settings |
| `keyboard.zsh` | Keyboard and input preferences |
| `terminal.zsh` | Terminal appearance and behavior |

## New Features and Capabilities

### Anthropic MCP Integration

The Jarvis Toolset now includes comprehensive support for Anthropic's Model Control Protocol (MCP):

- **MCP Server Setup**: Automated installation and configuration of MCP servers
- **Client Libraries**: Complete client-side tools for interacting with MCP servers
- **Monitoring Tools**: Real-time monitoring and debugging capabilities
- **Security Features**: Built-in security validation and threat detection
- **Project Templates**: Pre-configured project templates for rapid MCP development

### Enhanced Security Tools

A comprehensive cybersecurity toolkit has been added:

- **Network Security**: Nmap, Wireshark, Burp Suite for network analysis
- **Vulnerability Scanning**: OWASP ZAP, Nikto, SQLMap for security testing
- **Password Security**: John the Ripper, Hashcat for password analysis
- **Forensics Tools**: Autopsy, Volatility for digital forensics
- **Malware Analysis**: Ghidra, IDA Free, Radare2 for reverse engineering
- **AI-Powered Security**: AI Security Copilot, Deepfence for intelligent threat detection

### Advanced Development Environment

Enhanced support for modern development workflows:

- **Conda Integration**: Full Anaconda/Miniconda support with environment management
- **Google Cloud SDK**: Complete GCP development tools and services
- **IPFS Support**: Decentralized storage and development tools
- **Enhanced Language Support**: Improved configurations for all major programming languages
- **Package Managers**: Support for UV (Python), SDKMAN (Java), rbenv (Ruby), and more

### Generative AI and Creative Tools

Comprehensive suite for AI-powered creativity:

- **Image Generation**: Stable Diffusion, DALL-E, and other diffusion models
- **Video Processing**: Advanced video editing and AI-powered enhancement tools
- **Audio Processing**: Whisper for speech recognition, TTS tools
- **Creative Applications**: Professional-grade creative and design tools
- **3D Design**: Blender, Maya, ZBrush for 3D modeling and animation

### Performance and Optimization

Built-in performance optimization features:

- **Load Order Management**: Optimized configuration loading for fastest shell startup
- **Memory Management**: Efficient memory usage for large development environments
- **GPU Acceleration**: NVIDIA tools and CUDA support for AI/ML workloads
- **Caching Systems**: Intelligent caching for package managers and tools
- **Resource Monitoring**: Built-in monitoring for system resources and performance

## Troubleshooting

If you encounter issues during the installation process, here are common solutions and debugging steps:

### Configuration Loading Issues

**Problem**: Shell configurations not loading properly or conflicts between tools.

**Solutions**:
1. Check the load order in `~/.jarvistoolset/zsh_configs/00_load_order.zsh`
2. Verify that configuration files exist and are executable
3. Use `source ~/.zshrc` to reload configurations
4. Check for alias conflicts using the built-in conflict detection system
5. Disable problematic configurations by renaming them with `.disabled` extension

### Path-related Errors

**Problem**: Scripts cannot find utility files or configuration paths.

**Solutions**:
1. Ensure all scripts have proper `SCRIPT_DIR` variable defined
2. Verify that the directory structure matches script expectations
3. Check that relative paths are correct in installation scripts
4. Run `fix_utils_paths.zsh` to automatically fix common path issues

### Installation Failures

**Problem**: Specific tools fail to install or configure.

**Solutions**:
1. Check detailed logs in `~/.jarvistoolset/logs/` for error information
2. Ensure internet connectivity and sufficient disk space
3. Try running installation scripts manually for more detailed output
4. Verify that prerequisites are installed (Xcode Command Line Tools, Homebrew)
5. Check for permission issues with `sudo` commands

### AI Tools and MCP Issues

**Problem**: Anthropic MCP server/client not working properly.

**Solutions**:
1. Verify `ANTHROPIC_API_KEY` environment variable is set
2. Check MCP server configuration in `~/.jarvistoolset/zsh_configs/anthropic.zsh`
3. Ensure MCP server is running on the correct host and port
4. Use `mcp-status` alias to check server status
5. Review MCP logs using `mcp-logs` alias

### Language Environment Issues

**Problem**: Programming languages not working correctly after installation.

**Solutions**:
1. Check that language-specific configuration files are loaded in correct order
2. Verify package managers (pip, npm, cargo, etc.) are properly configured
3. Ensure PATH variables include language-specific binaries
4. Try reinstalling language tools using their respective installation scripts
5. Check for version conflicts between different language versions

### Performance Issues

**Problem**: Slow shell startup or poor performance.

**Solutions**:
1. Review configuration load order to optimize startup time
2. Disable unnecessary configurations or tools
3. Check for memory usage with large development environments
4. Use `htop` or Activity Monitor to identify resource-heavy processes
5. Consider using lighter alternatives for specific tools

### Security Tool Issues

**Problem**: Security tools not functioning or permission denied errors.

**Solutions**:
1. Ensure proper permissions for security tools (some require `sudo`)
2. Check that security tools are not blocked by macOS security policies
3. Verify that required dependencies are installed
4. Check firewall settings if network security tools are not working
5. Review macOS security preferences for tool-specific issues

### Cloud and DevOps Tools

**Problem**: Cloud CLI tools not authenticating or working properly.

**Solutions**:
1. Run authentication commands for each cloud platform (AWS, Azure, GCP)
2. Verify API keys and credentials are properly configured
3. Check network connectivity and proxy settings
4. Ensure cloud SDKs are properly installed and configured
5. Review cloud-specific configuration files

### Getting Additional Help

If you continue to experience issues:

1. **Check the Logs**: All installation activities are logged in `~/.jarvistoolset/logs/`
2. **Review Documentation**: Check individual tool documentation for specific requirements
3. **Community Support**: Open an issue on the GitHub repository with detailed error information
4. **Debug Mode**: Enable debug mode in scripts by uncommenting debug lines in configuration files
5. **Clean Installation**: Consider starting with a clean macOS installation for complex issues

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
