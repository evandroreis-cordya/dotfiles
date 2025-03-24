#!/bin/zsh

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.zsh"

print_in_purple "\n   Anthropic Tools\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Core Anthropic SDK and Client
execute "pip3 install anthropic" \
    "Installing Anthropic Python SDK"

# Constitutional AI Tools
execute "pip3 install anthropic-bedrock" \
    "Installing Anthropic Bedrock"

execute "pip3 install anthropic-tools" \
    "Installing Anthropic Tools"

# Machine Control Protocol (MCP)
execute "pip3 install anthropic-mcp" \
    "Installing Anthropic MCP Core"

execute "pip3 install anthropic-mcp-client" \
    "Installing Anthropic MCP Client"

execute "pip3 install anthropic-mcp-server" \
    "Installing Anthropic MCP Server"

execute "pip3 install anthropic-mcp-tools" \
    "Installing Anthropic MCP Tools"

execute "pip3 install anthropic-mcp-monitor" \
    "Installing Anthropic MCP Monitor"

execute "pip3 install anthropic-mcp-debug" \
    "Installing Anthropic MCP Debug Tools"

execute "pip3 install anthropic-mcp-security" \
    "Installing Anthropic MCP Security"

execute "pip3 install anthropic-mcp-validator" \
    "Installing Anthropic MCP Validator"

# Claude Integration
execute "pip3 install claude-api" \
    "Installing Claude API"

execute "pip3 install claude-client" \
    "Installing Claude Client"

# Prompt Engineering Tools
execute "pip3 install constitutional-ai" \
    "Installing Constitutional AI"

execute "pip3 install anthropic-prompt-toolkit" \
    "Installing Anthropic Prompt Toolkit"

# Development Tools
execute "pip3 install anthropic-tokenizer" \
    "Installing Anthropic Tokenizer"

execute "pip3 install anthropic-eval" \
    "Installing Anthropic Evaluation Tools"

# Integration Tools
execute "pip3 install langchain-anthropic" \
    "Installing LangChain Anthropic Integration"

execute "pip3 install anthropic-functions" \
    "Installing Anthropic Functions"

# Safety and Monitoring
execute "pip3 install anthropic-safety" \
    "Installing Anthropic Safety Tools"

execute "pip3 install anthropic-monitor" \
    "Installing Anthropic Monitoring"

# Utilities
execute "pip3 install anthropic-ratelimit" \
    "Installing Anthropic Rate Limiter"

execute "pip3 install anthropic-cache" \
    "Installing Anthropic Cache"

# Web Tools
execute "pip3 install anthropic-proxy" \
    "Installing Anthropic Proxy"

execute "pip3 install anthropic-webhook" \
    "Installing Anthropic Webhook"

# Authentication and Security
execute "pip3 install anthropic-auth" \
    "Installing Anthropic Auth"

execute "pip3 install anthropic-vault" \
    "Installing Anthropic Vault"
