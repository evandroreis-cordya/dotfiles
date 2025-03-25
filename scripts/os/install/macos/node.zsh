#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Node.js Development Tools\n\n"

# First check if Node.js is already installed via Homebrew
if brew list node &> /dev/null; then
    print_success "Node.js (already installed via Homebrew)"
    print_success "npm (already installed via Homebrew)"
else
    # Install Node Version Manager (nvm)
    nvm_install "v0.39.5"
    
    # Ensure NVM is fully loaded in the current shell
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    
    # Install Node.js versions
    node_install "lts/*" "default"  # Install latest LTS version and set as default
    
    # Ensure the default Node.js version is being used
    print_in_yellow "  [ ] Activating Node.js environment"
    nvm use default &> /dev/null
    print_result $? "Node.js environment activation"
    
    # If npm is not available, try a more direct approach
    if ! command -v npm &> /dev/null; then
        print_in_yellow "  [ ] Setting up npm"
        
        # Get the path to the installed Node.js version
        NODE_PATH=$(nvm which default 2>/dev/null)
        if [[ -n "$NODE_PATH" ]]; then
            # Extract the directory containing node
            NODE_DIR=$(dirname "$NODE_PATH")
            # Add it to the PATH
            export PATH="$NODE_DIR:$PATH"
            print_success "Node.js environment activated"
        else
            print_error "Could not find Node.js installation directory"
        fi
    fi
    
    # If npm is still not available, fall back to Homebrew
    if ! command -v npm &> /dev/null; then
        print_error "npm is not available via NVM. Installing Node.js directly with Homebrew as a fallback"
        
        # Fallback to Homebrew installation
        brew_install "Node.js" "node"
        
        if ! command -v npm &> /dev/null; then
            print_error "Failed to make npm available. Please restart your terminal and run the script again."
            exit 1
        else
            print_success "npm is now available (via Homebrew)"
        fi
    else
        print_success "npm is available (via NVM)"
    fi
fi

# Install Node.js 18 and 20 via NVM if it's available
if command -v nvm &> /dev/null; then
    node_install "18"  # Install Node.js 18
    node_install "20"  # Install Node.js 20
fi

# Install global npm packages
print_in_purple "\n   Installing Node.js Packages\n\n"

# Development tools
npm_install "TypeScript" "typescript" "-g"
npm_install "ts-node" "ts-node" "-g"
npm_install "ESLint" "eslint" "-g"
npm_install "Prettier" "prettier" "-g"
npm_install "Nodemon" "nodemon" "-g"

# Build tools
npm_install "Webpack" "webpack" "-g"
npm_install "Webpack CLI" "webpack-cli" "-g"
npm_install "Vite" "vite" "-g"
npm_install "Parcel" "parcel" "-g"
npm_install "Rollup" "rollup" "-g"

# Framework CLIs
npm_install "Angular CLI" "@angular/cli" "-g"
npm_install "Vue CLI" "@vue/cli" "-g"
npm_install "Create React App" "create-react-app" "-g"
npm_install "Next.js" "next" "-g"
npm_install "Nuxt.js" "nuxt" "-g"
npm_install "Svelte" "svelte" "-g"
npm_install "SvelteKit" "@sveltejs/kit" "-g"

# Testing tools
npm_install "Jest" "jest" "-g"
npm_install "Mocha" "mocha" "-g"
npm_install "Cypress" "cypress" "-g"

# Documentation tools
npm_install "JSDoc" "jsdoc" "-g"
npm_install "TypeDoc" "typedoc" "-g"

# Utility tools
npm_install "npm-check-updates" "npm-check-updates" "-g"
npm_install "npm-check" "npm-check" "-g"
npm_install "npkill" "npkill" "-g"
npm_install "serve" "serve" "-g"
npm_install "http-server" "http-server" "-g"
npm_install "json-server" "json-server" "-g"
npm_install "concurrently" "concurrently" "-g"
npm_install "PM2" "pm2" "-g"

# Mobile development
npm_install "React Native CLI" "react-native-cli" "-g"
npm_install "Expo CLI" "expo-cli" "-g"
npm_install "Capacitor" "@capacitor/cli" "-g"
npm_install "Ionic CLI" "@ionic/cli" "-g"

# Static site generators
npm_install "Gatsby" "gatsby-cli" "-g"
npm_install "Hexo" "hexo-cli" "-g"
npm_install "Gridsome" "@gridsome/cli" "-g"

# Database tools
npm_install "Prisma" "prisma" "-g"
npm_install "TypeORM" "typeorm" "-g"
npm_install "Sequelize CLI" "sequelize-cli" "-g"

# GraphQL tools
npm_install "Apollo CLI" "apollo" "-g"
npm_install "GraphQL CLI" "graphql-cli" "-g"

# Code quality tools
npm_install "Stylelint" "stylelint" "-g"
npm_install "Standard JS" "standard" "-g"
npm_install "XO" "xo" "-g"
npm_install "Lighthouse" "lighthouse" "-g"
npm_install "Pagespeed Insights" "psi" "-g"

# Security tools
npm_install "Snyk" "snyk" "-g"
npm_install "npm audit" "npm-audit-html" "-g"

# Monorepo tools
npm_install "Lerna" "lerna" "-g"
npm_install "Nx" "nx" "-g"
npm_install "Turborepo" "turbo" "-g"

print_in_green "\n  Node.js development environment setup complete!\n"
