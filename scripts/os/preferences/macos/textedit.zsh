#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   TextEdit\n\n"

execute "defaults write com.apple.TextEdit PlainTextEncoding -int 4 && \
         defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4" \
    "Abra e salve arquivos como UTF-8 codificado"

execute "defaults write com.apple.TextEdit RichText 0" \
    "Use o modo de texto simples para novos documentos"

killall "TextEdit" &> /dev/null
