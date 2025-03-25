#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Maps\n\n"

execute "defaults write com.apple.Maps LastClosedWindowViewOptions '{
            localizeLabels = 1;   // show labels in English
            mapType = 11;         // show hybrid map
            trafficEnabled = 0;   // do not show traffic
         }'" \
    "Definir as opções de visualização"

killall "Maps" &> /dev/null
