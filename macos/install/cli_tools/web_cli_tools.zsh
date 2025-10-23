#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

print_in_purple "
   Web Development CLI Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Node.js Package Managers
brew_install "Node.js" "node"
brew_install "Yarn" "yarn"

# Frontend Framework CLIs
execute "npm install -g @angular/cli" \
    "Installing Angular CLI"

execute "npm install -g @vue/cli" \
    "Installing Vue CLI"

execute "npm install -g create-react-app" \
    "Installing Create React App"

execute "npm install -g next" \
    "Installing Next.js CLI"

execute "npm install -g nuxi" \
    "Installing Nuxt.js CLI"

execute "npm install -g svelte-kit" \
    "Installing SvelteKit CLI"

execute "npm install -g remix-cli" \
    "Installing Remix CLI"

# Build Tools
execute "npm install -g vite" \
    "Installing Vite"

execute "npm install -g webpack-cli" \
    "Installing Webpack CLI"

execute "npm install -g parcel-bundler" \
    "Installing Parcel"

execute "npm install -g rollup" \
    "Installing Rollup"

execute "npm install -g esbuild" \
    "Installing esbuild"

# Testing Tools
execute "npm install -g jest" \
    "Installing Jest"

execute "npm install -g cypress" \
    "Installing Cypress"

execute "npm install -g playwright" \
    "Installing Playwright"

execute "npm install -g vitest" \
    "Installing Vitest"

# Linters and Formatters
execute "npm install -g eslint" \
    "Installing ESLint"

execute "npm install -g prettier" \
    "Installing Prettier"

execute "npm install -g stylelint" \
    "Installing Stylelint"

# Development Tools
execute "npm install -g typescript" \
    "Installing TypeScript"

execute "npm install -g tsx" \
    "Installing TSX"

execute "npm install -g sass" \
    "Installing Sass"

execute "npm install -g postcss-cli" \
    "Installing PostCSS CLI"

execute "npm install -g tailwindcss" \
    "Installing Tailwind CSS"

# Performance Tools
execute "npm install -g lighthouse" \
    "Installing Lighthouse"

execute "npm install -g webpack-bundle-analyzer" \
    "Installing Webpack Bundle Analyzer"

# Development Servers
execute "npm install -g serve" \
    "Installing Serve"

execute "npm install -g http-server" \
    "Installing HTTP Server"

# Mobile Development
execute "npm install -g @capacitor/cli" \
    "Installing Capacitor CLI"

execute "npm install -g @ionic/cli" \
    "Installing Ionic CLI"

# Documentation
execute "npm install -g docsify-cli" \
    "Installing Docsify CLI"

execute "npm install -g typedoc" \
    "Installing TypeDoc"

print_in_green "
  Web CLI tools installation complete!
"
