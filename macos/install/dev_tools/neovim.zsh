#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "
   NeoVim

"

# Install NeoVim
if brew list | grep -q "^neovim$"; then
    print_success "NeoVim (already installed)"
else
    brew install neovim &> /dev/null
    print_result $? "NeoVim"
fi

# Create NeoVim configuration directory
if [[ ! -d "$HOME/.config/nvim" ]]; then
    mkdir -p "$HOME/.config/nvim"
    print_result $? "Create NeoVim config directory"
fi

# Copy configuration files
if [[ -f "${SCRIPT_DIR}/../../../configs/neovim/init.vim" ]]; then
    cp "${SCRIPT_DIR}/../../../configs/neovim/init.vim" "$HOME/.config/nvim/"
    print_result $? "Copy NeoVim configuration"
fi

# Create NeoVim data directories
mkdir -p "$HOME/.local/share/nvim/backups"
mkdir -p "$HOME/.local/share/nvim/swaps"
mkdir -p "$HOME/.local/share/nvim/undos"
mkdir -p "$HOME/.local/share/nvim/plugged"
mkdir -p "$HOME/.local/share/nvim/snippets"
print_result $? "Create NeoVim data directories"

# Install vim-plug if not already installed
if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    print_result $? "Install vim-plug"
fi

# Create emmet.json snippet file if it doesn't exist
if [[ ! -f "$HOME/.local/share/nvim/snippets/emmet.json" ]]; then
    cat > "$HOME/.local/share/nvim/snippets/emmet.json" << 'EOL'
{
  "html": {
    "abbreviations": {
      "a": "<a href=\"|\">|</a>",
      "link": "<link rel=\"stylesheet\" href=\"|\">",
      "script": "<script src=\"|\"></script>",
      "img": "<img src=\"|\" alt=\"\">",
      "div": "<div class=\"|\">|</div>",
      "span": "<span class=\"|\">|</span>",
      "p": "<p>|</p>",
      "h1": "<h1>|</h1>",
      "h2": "<h2>|</h2>",
      "h3": "<h3>|</h3>",
      "ul": "<ul>|</ul>",
      "li": "<li>|</li>",
      "form": "<form action=\"|\">|</form>",
      "input": "<input type=\"|\" name=\"\" value=\"\">",
      "button": "<button type=\"|\">|</button>"
    }
  },
  "css": {
    "abbreviations": {
      "m": "margin: |;",
      "p": "padding: |;",
      "w": "width: |;",
      "h": "height: |;",
      "bg": "background: |;",
      "c": "color: |;",
      "f": "font: |;",
      "d": "display: |;",
      "pos": "position: |;"
    }
  }
}
EOL
    print_result $? "Create emmet.json snippet file"
fi

print_in_green "
  NeoVim setup complete!
"

print_in_yellow "
  Restart your shell to apply all changes.
  Run 'nvim' to start NeoVim.
"
