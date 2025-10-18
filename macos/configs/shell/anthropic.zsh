#!/bin/zsh
#
# Anthropic MCP configuration
# Configuration for Anthropic libraries, MCP Servers and Clients
#

# Anthropic API key handling
export ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY:-""}

# MCP Server configuration
export MCP_SERVER_HOST=${MCP_SERVER_HOST:-"localhost"}
export MCP_SERVER_PORT=${MCP_SERVER_PORT:-"8000"}
export MCP_SERVER_LOG_LEVEL=${MCP_SERVER_LOG_LEVEL:-"info"}

# MCP Client configuration
export MCP_CLIENT_TIMEOUT=${MCP_CLIENT_TIMEOUT:-"60"}
export MCP_CLIENT_RETRY_COUNT=${MCP_CLIENT_RETRY_COUNT:-"3"}
export MCP_CLIENT_LOG_LEVEL=${MCP_CLIENT_LOG_LEVEL:-"info"}

# Add Anthropic tools to PATH if installed in a custom location
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Aliases for common MCP operations
alias mcp-start="anthropic-mcp-server start"
alias mcp-stop="anthropic-mcp-server stop"
alias mcp-status="anthropic-mcp-server status"
alias mcp-logs="anthropic-mcp-monitor logs"
alias mcp-debug="anthropic-mcp-debug"
alias mcp-validate="anthropic-mcp-validator"

# Helper functions
anthropic-setup() {
    echo "Setting up Anthropic environment..."
    if [ -z "$ANTHROPIC_API_KEY" ]; then
        echo "Please set your ANTHROPIC_API_KEY environment variable"
        echo "Example: export ANTHROPIC_API_KEY='your-api-key'"
    else
        echo "Anthropic API key is configured"
    fi
    
    echo "MCP Server will run on $MCP_SERVER_HOST:$MCP_SERVER_PORT"
    echo "MCP Client timeout: $MCP_CLIENT_TIMEOUT seconds, retries: $MCP_CLIENT_RETRY_COUNT"
}

# Function to create a new MCP project
mcp-new-project() {
    local project_name=$1
    if [ -z "$project_name" ]; then
        echo "Please provide a project name"
        echo "Usage: mcp-new-project <project-name>"
        return 1
    fi
    
    mkdir -p "$project_name"
    cd "$project_name" || return
    
    # Create basic project structure
    mkdir -p src tests config
    
    # Create basic configuration file
    cat > config/mcp_config.json << EOF
{
    "server": {
        "host": "${MCP_SERVER_HOST}",
        "port": ${MCP_SERVER_PORT},
        "log_level": "${MCP_SERVER_LOG_LEVEL}"
    },
    "client": {
        "timeout": ${MCP_CLIENT_TIMEOUT},
        "retry_count": ${MCP_CLIENT_RETRY_COUNT},
        "log_level": "${MCP_CLIENT_LOG_LEVEL}"
    }
}
EOF
    
    # Create basic server example
    cat > src/server_example.py << EOF
#!/usr/bin/env python3
from anthropic_mcp_server import MCPServer

def main():
    server = MCPServer()
    server.start()

if __name__ == "__main__":
    main()
EOF
    
    # Create basic client example
    cat > src/client_example.py << EOF
#!/usr/bin/env python3
from anthropic_mcp_client import MCPClient

def main():
    client = MCPClient()
    response = client.send_request({"message": "Hello, MCP!"})
    print(f"Response: {response}")

if __name__ == "__main__":
    main()
EOF
    
    # Make example files executable
    chmod +x src/server_example.py
    chmod +x src/client_example.py
    
    echo "MCP project '$project_name' created successfully"
    echo "Project structure:"
    ls -la
}
