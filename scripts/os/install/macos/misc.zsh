#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscelânea\n\n"

brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"
brew_install "Spectacle" "spectacle" "caskroom/cask" "cask"
brew_install "The Unarchiver" "the-unarchiver" "caskroom/cask" "cask"
brew_install "Transmission" "transmission" "caskroom/cask" "cask"

