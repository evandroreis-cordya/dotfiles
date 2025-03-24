#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Bancos de Dados e Tools\n\n"


brew_install "Azure Data Studio" "azure-data-studio" "caskroom/cask" "cask"
brew_install "MongoDB Compass Community" "mongodb-compass-community" "caskroom/cask" "cask"
brew_install "MySQL Shell" "mysql-shell" "caskroom/cask" "cask"
brew_install "MySQL Workbench" "mysqlworkbench" "caskroom/cask" "cask"
brew_install "SQLite Studio" "sqlitestudio" "caskroom/cask" "cask"
