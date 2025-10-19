# Cursor IDE Configuration

This directory contains the complete Cursor IDE configuration for the dotfiles setup, including settings, keybindings, and MCP server configurations.

## Files Overview

### Core Configuration Files

- **`settings.json`** - Main Cursor settings including themes, extensions, and editor preferences
- **`keybindings.json`** - Custom keybindings for Cursor IDE
- **`mcp.json`** - Basic MCP server configuration
- **`mcp-comprehensive.json`** - Comprehensive MCP server configuration with all available servers

### MCP Server Configuration

The MCP (Model Context Protocol) configuration includes support for:

#### Core Development Tools
- **Filesystem MCP** - File system operations and navigation
- **Git MCP** - Git operations and repository management
- **GitHub MCP** - GitHub integration and operations
- **Docker MCP** - Docker container management

#### Database & Storage
- **SQLite MCP** - SQLite database operations
- **PostgreSQL MCP** - PostgreSQL database management
- **MongoDB MCP** - MongoDB operations
- **Redis MCP** - Redis cache operations

#### Cloud Platforms
- **AWS MCP** - Amazon Web Services integration
- **Google Cloud MCP** - Google Cloud Platform services
- **Kubernetes MCP** - Kubernetes cluster management
- **Terraform MCP** - Infrastructure as Code management

#### AI & Machine Learning
- **OpenAI MCP** - OpenAI API integration
- **Anthropic MCP** - Anthropic Claude API
- **LangChain MCP** - LangChain framework integration
- **CrewAI MCP** - CrewAI multi-agent framework
- **MLflow MCP** - MLflow experiment tracking
- **Weights & Biases MCP** - W&B experiment tracking

#### Development Tools
- **ESLint MCP** - Code linting
- **Prettier MCP** - Code formatting
- **Jest MCP** - JavaScript testing
- **PyTest MCP** - Python testing
- **Playwright MCP** - End-to-end testing
- **Selenium MCP** - Web automation testing

#### Package Management
- **NPM MCP** - Node.js package management
- **Yarn MCP** - Yarn package manager
- **Poetry MCP** - Python dependency management
- **Pip MCP** - Python package installer

#### Security & Compliance
- **Vault MCP** - HashiCorp Vault integration
- **Snyk MCP** - Security vulnerability scanning
- **GitGuardian MCP** - Secrets detection
- **OpenPolicyAgent MCP** - Policy enforcement

## Installation

The Cursor configuration is automatically installed when you run the dotfiles setup with the `dev_tools` group enabled:

```bash
./start_dotfiles.zsh
```

Or install Cursor specifically:

```bash
source macos/install/dev_tools/cursor.zsh
```

## Configuration Structure

### Settings Configuration

The settings include:
- **Editor Preferences**: Font family, size, theme, and display options
- **Git Integration**: GitLens configuration and Git settings
- **Terminal Integration**: iTerm.app integration and terminal settings
- **Language Support**: Python, TypeScript, and other language configurations
- **Extension Settings**: Various extension configurations
- **Workspace Settings**: Project and workspace management

### Keybindings

Custom keybindings include:
- **Cmd+I**: Opens Cursor's Composer Mode for AI assistance

### MCP Servers

MCP servers are configured to provide AI assistance with various development tasks:
- Code analysis and suggestions
- Database operations
- Cloud resource management
- Testing and quality assurance
- Package management

## Usage

### Basic Usage

1. **Open Cursor**: Use the `cursor` command or `cur` alias
2. **Open specific files**: `cursor_open <file_or_directory>`
3. **Create workspace**: `cursor_new_workspace <workspace_name>`
4. **List workspaces**: `cursor_list_workspaces`

### MCP Server Usage

MCP servers are automatically available when Cursor starts. They provide context-aware assistance for:
- Code generation and completion
- Database queries and operations
- Cloud resource management
- Testing and debugging
- Package management

### Configuration Management

- **Backup settings**: `cursor_backup_settings`
- **Restore settings**: `cursor_restore_settings`
- **Check installation**: `cursor_check_install`
- **Debug MCP**: `cursor_debug_mcp`

## Customization

### Adding New MCP Servers

To add new MCP servers, edit the `mcp.json` file:

```json
{
    "mcpServers": {
        "your-server": {
            "command": "npx",
            "args": ["-y", "@your-org/your-mcp-server"]
        }
    }
}
```

### Modifying Settings

Edit the `settings.json` file to customize:
- Editor appearance and behavior
- Extension settings
- Language-specific configurations
- Workspace preferences

### Custom Keybindings

Add new keybindings in `keybindings.json`:

```json
[
    {
        "key": "cmd+shift+p",
        "command": "your.custom.command"
    }
]
```

## Troubleshooting

### Common Issues

1. **MCP servers not starting**: Check that Node.js and npm are installed
2. **Settings not applying**: Restart Cursor after configuration changes
3. **Extensions not working**: Verify extension compatibility with Cursor

### Debug Mode

Enable debug mode for MCP servers:

```bash
cursor_debug_m34p
```

### Logs

Check Cursor logs for debugging:
- macOS: `~/Library/Logs/Cursor/`
- Configuration: `~/.cursor/`

## Integration with Dotfiles

The Cursor configuration integrates seamlessly with the dotfiles setup:
- Automatic installation via Homebrew
- Configuration management via Stow
- Shell integration via zsh configuration
- Backup and restore functionality

## Support

For issues with Cursor configuration:
1. Check the troubleshooting section
2. Review Cursor documentation
3. Check MCP server documentation
4. Open an issue in the dotfiles repository
