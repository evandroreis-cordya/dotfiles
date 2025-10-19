#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh" \
    source "./utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
print_in_purple "
   Installing fonts

"

print_in_yellow "
   Installing .TTF fonts
"
cp -R "$HOME/dotfiles/resources/fonts/*.ttf" /Library/Fonts

print_in_yellow "
   Installing .OTF fonts
"
cp -R "$HOME/dotfiles/resources/fonts/*.otf" /Library/Fonts

print_in_yellow "
   Installing .WOFF fonts
"
cp -R "$HOME/dotfiles/resources/fonts/*.woff" /Library/Fonts

print_in_green "
   Fonts installation complete!
"
