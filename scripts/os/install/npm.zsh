#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

USERNAME="$1"

install_npm_package() {

    execute \
        ". $HOME/.bash.local \
            && npm install --global --silent $2" \
        "$1"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local USERNAME="$1"

    print_in_purple "\n   npm\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "npm (update)" "npm"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    install_npm_package "!nstant-markdown-d" "instant-markdown-d"
    install_npm_package "Babel" "babel-cli"
    install_npm_package "JSHint" "jshint"
    install_npm_package "Trash-cli" "trash-cli"
    install_npm_package "Angular CLI" "@angular/cli"

    # print_in_purple "\n   Configurando o npm\n\n"

    # execute "npm add user '$USERNAME'" "Adicionando '$USERNAME'"



}
