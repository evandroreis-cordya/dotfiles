#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Node.js Development Tools\n\n"

# Install Node Version Manager (nvm)
nvm_install "v0.39.5"

# Install Node.js versions
node_install "lts/*" "default"  # Install latest LTS version and set as default
node_install "18"               # Install Node.js 18
node_install "20"               # Install Node.js 20

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

# Linting and formatting
npm_install "Stylelint" "stylelint" "-g"
npm_install "Standard JS" "standard" "-g"
npm_install "XO" "xo" "-g"

# Performance tools
npm_install "Lighthouse" "lighthouse" "-g"
npm_install "Pagespeed Insights" "psi" "-g"

# Security tools
npm_install "Snyk" "snyk" "-g"
npm_install "npm audit" "npm-audit" "-g"

# Monorepo tools
npm_install "Lerna" "lerna" "-g"
npm_install "Nx" "nx" "-g"
npm_install "Turborepo" "turbo" "-g"

print_in_green "\n  Node.js development environment setup complete!\n"
