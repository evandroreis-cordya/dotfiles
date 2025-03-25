#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Default values
HOSTNAME="$1"
USERNAME="$2"
EMAIL="$3"

print_in_purple "\n >> Preferências...\n"

"./$(get_os)/main.sh" "$HOSTNAME" "$USERNAME" "$EMAIL"
