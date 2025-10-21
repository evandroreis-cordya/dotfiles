#!/usr/bin/env zsh
#
# Cursor Troubleshooting and Setup Script
# This script helps diagnose and fix common Cursor issues
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to check if Cursor is installed
check_cursor_installation() {
    print_status $BLUE "Checking Cursor installation..."

    if [[ -f "/Applications/Cursor.app/Contents/MacOS/Cursor" ]]; then
        print_status $GREEN "✓ Cursor is installed"
        return 0
    else
        print_status $RED "✗ Cursor is not installed"
        print_status $YELLOW "Install with: brew install --cask cursor"
        return 1
    fi
}

# Function to check Cursor configuration
check_cursor_config() {
    print_status $BLUE "Checking Cursor configuration..."

    local config_dir="$HOME/Library/Application Support/Cursor/User"
    local mcp_dir="$HOME/.cursor"

    if [[ -d "$config_dir" ]]; then
        print_status $GREEN "✓ Cursor config directory exists"
    else
        print_status $YELLOW "! Creating Cursor config directory..."
        mkdir -p "$config_dir"
    fi

    if [[ -d "$mcp_dir" ]]; then
        print_status $GREEN "✓ MCP config directory exists"
    else
        print_status $YELLOW "! Creating MCP config directory..."
        mkdir -p "$mcp_dir"
    fi
}

# Function to check MCP servers
check_mcp_servers() {
    print_status $BLUE "Checking MCP server configuration..."

    local mcp_config="$HOME/.cursor/mcp.json"

    if [[ -f "$mcp_config" ]]; then
        print_status $GREEN "✓ MCP configuration file exists"

        # Check if configuration is valid JSON
        if python3 -m json.tool "$mcp_config" > /dev/null 2>&1; then
            print_status $GREEN "✓ MCP configuration is valid JSON"
        else
            print_status $RED "✗ MCP configuration has invalid JSON"
            return 1
        fi
    else
        print_status $YELLOW "! MCP configuration file not found"
        return 1
    fi
}

# Function to check Node.js and npm
check_node_requirements() {
    print_status $BLUE "Checking Node.js requirements..."

    if command -v node &> /dev/null; then
        local node_version=$(node --version)
        print_status $GREEN "✓ Node.js is installed: $node_version"
    else
        print_status $RED "✗ Node.js is not installed"
        print_status $YELLOW "Install with: brew install node"
        return 1
    fi

    if command -v npm &> /dev/null; then
        local npm_version=$(npm --version)
        print_status $GREEN "✓ npm is installed: $npm_version"
    else
        print_status $RED "✗ npm is not installed"
        return 1
    fi
}

# Function to test MCP server installation
test_mcp_servers() {
    print_status $BLUE "Testing MCP server installation..."

    local servers=(
        "@modelcontextprotocol/server-filesystem"
        "@modelcontextprotocol/server-git"
        "@modelcontextprotocol/server-github"
        "@modelcontextprotocol/server-docker"
        "@modelcontextprotocol/server-sqlite"
        "@modelcontextprotocol/server-openai"
        "@modelcontextprotocol/server-anthropic"
        "@modelcontextprotocol/server-npm"
        "@modelcontextprotocol/server-eslint"
        "@modelcontextprotocol/server-prettier"
    )

    for server in "${servers[@]}"; do
        if npm list -g "$server" &> /dev/null || npx "$server" --help &> /dev/null; then
            print_status $GREEN "✓ $server is available"
        else
            print_status $YELLOW "! $server may need to be installed (will be installed on first use)"
        fi
    done
}

# Function to clean up Cursor logs
cleanup_cursor_logs() {
    print_status $BLUE "Cleaning up Cursor logs..."

    local log_dir="$HOME/Library/Logs/Cursor"

    if [[ -d "$log_dir" ]]; then
        local log_count=$(find "$log_dir" -name "*.log" | wc -l)
        if [[ $log_count -gt 0 ]]; then
            print_status $YELLOW "Found $log_count log files"
            read -p "Do you want to clean up old logs? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                find "$log_dir" -name "*.log" -mtime +7 -delete
                print_status $GREEN "✓ Old logs cleaned up"
            fi
        else
            print_status $GREEN "✓ No log files found"
        fi
    else
        print_status $GREEN "✓ No log directory found"
    fi
}

# Function to restart Cursor
restart_cursor() {
    print_status $BLUE "Restarting Cursor..."

    # Kill any running Cursor processes
    pkill -f "Cursor" 2>/dev/null || true

    # Wait a moment
    sleep 2

    # Start Cursor
    open -a Cursor

    print_status $GREEN "✓ Cursor restarted"
}

# Function to show Cursor status
show_cursor_status() {
    print_status $BLUE "Cursor Status Report"
    print_status $BLUE "=================="

    check_cursor_installation
    check_cursor_config
    check_mcp_servers
    check_node_requirements
    test_mcp_servers

    print_status $BLUE "=================="
}

# Function to fix common issues
fix_cursor_issues() {
    print_status $BLUE "Fixing common Cursor issues..."

    # Fix 1: Ensure directories exist
    mkdir -p "$HOME/Library/Application Support/Cursor/User"
    mkdir -p "$HOME/.cursor"
    mkdir -p "$HOME/.cursor/databases"

    # Fix 2: Set proper permissions
    chmod 755 "$HOME/Library/Application Support/Cursor"
    chmod 755 "$HOME/.cursor"

    # Fix 3: Clear any problematic cache
    rm -rf "$HOME/Library/Application Support/Cursor/CachedData" 2>/dev/null || true

    print_status $GREEN "✓ Common issues fixed"
}

# Function to troubleshoot Cursor issues
cursor_troubleshoot_main() {
    case "${1:-status}" in
        "status")
            show_cursor_status
            ;;
        "fix")
            fix_cursor_issues
            ;;
        "clean")
            cleanup_cursor_logs
            ;;
        "restart")
            restart_cursor
            ;;
        "test")
            test_mcp_servers
            ;;
        *)
            echo "Usage: $0 {status|fix|clean|restart|test}"
            echo ""
            echo "Commands:"
            echo "  status  - Show Cursor status report (default)"
            echo "  fix     - Fix common Cursor issues"
            echo "  clean   - Clean up old logs"
            echo "  restart - Restart Cursor"
            echo "  test    - Test MCP server installation"
            ;;
    esac
}

# Run main function with all arguments
cursor_troubleshoot_main "$@"
