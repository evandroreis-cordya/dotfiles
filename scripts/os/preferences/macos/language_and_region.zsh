#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Language & Region\n\n"

execute "defaults write -g AppleLanguages -array 'en'" \
    "Definir lingua"

execute "defaults write -g AppleMeasurementUnits -string 'Centimeters'" \
    "Definir as unidades de medida"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Definir a auto-correção"
