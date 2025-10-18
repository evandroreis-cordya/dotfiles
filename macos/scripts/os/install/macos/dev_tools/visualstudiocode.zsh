#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh" \
    source "./utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Visual Studio Code e Extensões\n\n"


brew_install "Visual Studio Code" "visual-studio-code" "caskroom/cask" "cask"
brew_install "Visual Studio for Mac" "visual-studio" "caskroom/cask" "cask"
brew_install "Xamarin for Mac" "xamarin-mac" "caskroom/cask" "cask"
brew_install "Xamarin Profiler" "xamarin-profiler" "caskroom/cask" "cask"
brew_install "Xamarin Studio" "xamarin-studio" "caskroom/cask" "cask"


