#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh" \
    source "./utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Bancos de Dados e Tools\n\n"


brew_install "Azure Data Studio" "azure-data-studio" "caskroom/cask" "cask"
brew_install "MongoDB Compass Community" "mongodb-compass-community" "caskroom/cask" "cask"
brew_install "MySQL Shell" "mysql-shell" "caskroom/cask" "cask"
brew_install "MySQL Workbench" "mysqlworkbench" "caskroom/cask" "cask"
brew_install "SQLite Studio" "sqlitestudio" "caskroom/cask" "cask"
