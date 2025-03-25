#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh" \
    source "./utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Web Font Tools\n\n"

brew_install "Web Font Tools: TTF/OTF → WOFF (Zopfli)" "sfnt2woff-zopfli" "bramstein/webfonttools"
brew_install "Web Font Tools: TTF/OTF → WOFF" "sfnt2woff" "bramstein/webfonttools"
brew_install "Web Font Tools: WOFF2" "woff2" "bramstein/webfonttools"


print_in_purple "\n   Instalando fonts\n\n"

print_in_yellow "\n   Instalando .TTF fonts\n"
cp -R ./fonts/*.ttf /Library/Fonts

print_in_yellow "\n   Instalando .OTF fonts\n"
cp -R ./fonts/*.otf /Library/Fonts

print_in_yellow "\n   Instalando .WOFF fonts\n"
cp -R ./fonts/*.woff /Library/Fonts
