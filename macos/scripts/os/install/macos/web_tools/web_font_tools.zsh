#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh" \
    source "./utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Installing fonts\n\n"

print_in_yellow "\n   Installing .TTF fonts\n"
cp -R "$SCRIPT_DIR/fonts/*.ttf" /Library/Fonts

print_in_yellow "\n   Installing .OTF fonts\n"
cp -R "$SCRIPT_DIR/fonts/*.otf" /Library/Fonts

print_in_yellow "\n   Installing .WOFF fonts\n"
cp -R "$SCRIPT_DIR/fonts/*.woff" /Library/Fonts

print_in_green "\n   Fonts installation complete!\n"
