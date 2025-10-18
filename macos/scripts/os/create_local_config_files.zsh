#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_zsh_local() {
    local FILE_PATH="$HOME/.zsh.local"

    if [[ ! -e "$FILE_PATH" ]] || [[ -z "$FILE_PATH" ]]; then
        printf "%s\n\n" "#!/usr/bin/env zsh" >> "$FILE_PATH"
    fi

    print_result $? "$FILE_PATH"
}

create_gitconfig_local() {
    local FILE_PATH="$HOME/.gitconfig.local"

    if [[ ! -e "$FILE_PATH" ]] || [[ -z "$FILE_PATH" ]]; then
        cat > "$FILE_PATH" << 'EOL'
[commit]
    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/
    gpgsign = true

[user]
    name = Evandro Paes
    email = evandro.reis@avos.ai
    # Add your GPG key ID here
    # signingkey = YOUR_GPG_KEY_ID

[core]
    excludesfile = ~/.gitignore
    attributesfile = ~/.gitattributes
    whitespace = space-before-tab,-indent-with-non-tab,trailing-space
    trustctime = false
    untrackedCache = true

[color]
    ui = auto

[diff]
    renames = copies
    indentHeuristic = true

[help]
    autocorrect = 1

[merge]
    log = true

[push]
    default = simple
    followTags = true
EOL
    fi

    print_result $? "$FILE_PATH"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n >> Create local config files\n\n"
    
    create_zsh_local
    create_gitconfig_local
}

main
