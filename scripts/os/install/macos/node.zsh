#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Node.js Development Tools\n\n"

# Install Node Version Manager (nvm)
if [[ ! -d "$HOME/.nvm" ]]; then
    print_in_purple "\n   Installing NVM\n\n"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

    # Add NVM to shell configuration
    cat >> "$HOME/.zshrc" << 'EOL'

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOL

    # Load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Install latest LTS version of Node.js
print_in_purple "\n   Installing Node.js LTS\n\n"
nvm install --lts
nvm use --lts

# Set default Node.js version
nvm alias default 'lts/*'

# Install global npm packages
print_in_purple "\n   Installing Global npm Packages\n\n"

# Development Tools
npm install -g npm@latest
npm install -g yarn
npm install -g pnpm
npm install -g typescript
npm install -g ts-node
npm install -g nodemon
npm install -g pm2

# CLI Tools
npm install -g npx
npm install -g nx
npm install -g @angular/cli
npm install -g create-react-app
npm install -g create-next-app
npm install -g @vue/cli
npm install -g gatsby-cli
npm install -g serve

# Testing and Linting
npm install -g jest
npm install -g eslint
npm install -g prettier
npm install -g typescript-eslint
npm install -g stylelint

# Build Tools
npm install -g webpack
npm install -g rollup
npm install -g vite
npm install -g esbuild

# Documentation
npm install -g documentation
npm install -g typedoc

# Optional Development Tools
# Uncomment if needed
# npm install -g @nestjs/cli
# npm install -g firebase-tools
# npm install -g vercel
# npm install -g netlify-cli
# npm install -g serverless
# npm install -g @aws-amplify/cli

# Configure npm
npm config set init.author.name "Evandro Paes"
npm config set init.author.email "evandro.reis@avos.ai"
npm config set init.license "MIT"

# Configure yarn
yarn config set init-author-name "Evandro Paes"
yarn config set init-author-email "evandro.reis@avos.ai"
yarn config set init-license "MIT"

print_result $? "Node.js development environment"
