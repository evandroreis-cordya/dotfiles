#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
declare -r HOSTNAME="$1"
declare -r USERNAME="$2"
declare -r EMAIL="$3"

print_in_purple "\n >> Preferências...\n"

"./$(get_os)/main.sh" "$HOSTNAME" "$USERNAME" "$EMAIL"
