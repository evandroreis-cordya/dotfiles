#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Chrome\n\n"

execute "defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false" \
    "Disabilita o backswipe"

execute "defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true" \
    "Expande o painel de print como default"

execute "defaults write com.google.Chrome DisablePrintPreview -bool true" \
    "Usa o painel de Print Preview padrão do sistema"

killall "Google Chrome" &> /dev/null
