#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   TextEdit\n\n"

execute "defaults write com.apple.TextEdit PlainTextEncoding -int 4 && \
         defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4" \
    "Abra e salve arquivos como UTF-8 codificado"

execute "defaults write com.apple.TextEdit RichText 0" \
    "Use o modo de texto simples para novos documentos"

killall "TextEdit" &> /dev/null
