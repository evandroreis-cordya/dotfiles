#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Visual Studio Code e Extensões\n\n"


brew_install "Visual Studio Code" "visual-studio-code" "caskroom/cask" "cask"
brew_install "Visual Studio for Mac" "visual-studio" "caskroom/cask" "cask"
brew_install "Xamarin for Mac" "xamarin-mac" "caskroom/cask" "cask"
brew_install "Xamarin Profiler" "xamarin-profiler" "caskroom/cask" "cask"
brew_install "Xamarin Studio" "xamarin-studio" "caskroom/cask" "cask"


