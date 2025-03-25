#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Language & Region\n\n"

execute "defaults write -g AppleLanguages -array 'en'" \
    "Definir lingua"

execute "defaults write -g AppleMeasurementUnits -string 'Centimeters'" \
    "Definir as unidades de medida"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Definir a auto-correção"
