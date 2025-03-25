#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh" \
    source "./utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Image Tools\n\n"

brew_install "GIMP" "lisanet-gimp" "caskroom/cask" "cask"
brew_install "ImageAlpha" "imagealpha" "caskroom/cask" "cask"
brew_install "ImageMagick" "imagemagick"
brew_install "ImageOptim" "imageoptim" "caskroom/cask" "cask"
brew_install "LICEcap" "licecap" "caskroom/cask" "cask"
brew_install "Webp" "webp"
