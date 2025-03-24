#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Office 365\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"

brew_install "Office 365" "microsoft-office" "caskroom/cask" "cask"
brew_install "Microsoft Teams" "microsoft-teams" "caskroom/versions" "cask"
brew_install "Xmind:ZEN" "xmind-zen" "caskroom/versions" "cask"
