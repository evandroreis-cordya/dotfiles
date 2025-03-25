#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add warning function if not already defined
print_warning() {
    print_in_yellow "  [!] $1\n"
}

print_in_purple "\n   Development Tools\n\n"

# IDEs and Editors
if brew list --cask | grep -q "visual-studio-code"; then
    print_success "Visual Studio Code (already installed)"
else
    print_in_yellow "  [ ] Visual Studio Code"
    brew install --cask visual-studio-code &> /dev/null
    print_result $? "Visual Studio Code"
fi

if brew list --cask | grep -q "android-studio"; then
    print_success "Android Studio (already installed)"
else
    print_in_yellow "  [ ] Android Studio"
    brew install --cask android-studio &> /dev/null
    print_result $? "Android Studio"
fi

if brew list --cask | grep -q "iterm2"; then
    print_success "iTerm2 (already installed)"
else
    print_in_yellow "  [ ] iTerm2"
    brew install --cask iterm2 &> /dev/null
    print_result $? "iTerm2"
fi

if brew list --cask | grep -q "docker"; then
    print_success "Docker (already installed)"
else
    print_in_yellow "  [ ] Docker"
    brew install --cask docker &> /dev/null
    print_result $? "Docker"
fi

# Development tools
if brew list | grep -q "^git$"; then
    print_success "Git (already installed)"
else
    print_in_yellow "  [ ] Git"
    brew install git &> /dev/null
    print_result $? "Git"
fi

if brew list | grep -q "^gh$"; then
    print_success "GitHub CLI (already installed)"
else
    print_in_yellow "  [ ] GitHub CLI"
    brew install gh &> /dev/null
    print_result $? "GitHub CLI"
fi

if brew list | grep -q "^awscli$"; then
    print_success "AWS CLI (already installed)"
else
    print_in_yellow "  [ ] AWS CLI"
    brew install awscli &> /dev/null
    print_result $? "AWS CLI"
fi

if brew list | grep -q "^azure-cli$"; then
    print_success "Azure CLI (already installed)"
else
    print_in_yellow "  [ ] Azure CLI"
    brew install azure-cli &> /dev/null
    print_result $? "Azure CLI"
fi

if brew list | grep -q "^terraform$"; then
    print_success "Terraform (already installed)"
else
    print_in_yellow "  [ ] Terraform"
    brew install terraform &> /dev/null
    print_result $? "Terraform"
fi

if brew list | grep -q "^kubernetes-cli$"; then
    print_success "kubectl (already installed)"
else
    print_in_yellow "  [ ] kubectl"
    brew install kubernetes-cli &> /dev/null
    print_result $? "kubectl"
fi

# Database tools
if brew list | grep -q "^postgresql@14$"; then
    print_success "PostgreSQL (already installed)"
else
    print_in_yellow "  [ ] PostgreSQL"
    brew install postgresql@14 &> /dev/null
    print_result $? "PostgreSQL"
fi

if brew list | grep -q "^mongodb-community$"; then
    print_success "MongoDB (already installed)"
else
    print_in_yellow "  [ ] MongoDB"
    brew install mongodb-community &> /dev/null
    print_result $? "MongoDB"
fi

if brew list | grep -q "^redis$"; then
    print_success "Redis (already installed)"
else
    print_in_yellow "  [ ] Redis"
    brew install redis &> /dev/null
    print_result $? "Redis"
fi

# API Development
if brew list --cask | grep -q "postman"; then
    print_success "Postman (already installed)"
else
    print_in_yellow "  [ ] Postman"
    brew install --cask postman &> /dev/null
    print_result $? "Postman"
fi

if brew list | grep -q "^httpie$"; then
    print_success "HTTPie (already installed)"
else
    print_in_yellow "  [ ] HTTPie"
    brew install httpie &> /dev/null
    print_result $? "HTTPie"
fi

# Image tools
if brew list | grep -q "^imagemagick$"; then
    print_success "ImageMagick (already installed)"
else
    print_in_yellow "  [ ] ImageMagick"
    brew install imagemagick &> /dev/null
    print_result $? "ImageMagick"
fi

# Package managers and build tools
if brew list | grep -q "^maven$"; then
    print_success "Maven (already installed)"
else
    print_in_yellow "  [ ] Maven"
    brew install maven &> /dev/null
    print_result $? "Maven"
fi

if brew list | grep -q "^gradle$"; then
    print_success "Gradle (already installed)"
else
    print_in_yellow "  [ ] Gradle"
    brew install gradle &> /dev/null
    print_result $? "Gradle"
fi

# Programming languages
if brew list | grep -q "^go$"; then
    print_success "Go (already installed)"
else
    print_in_yellow "  [ ] Go"
    brew install go &> /dev/null
    print_result $? "Go"
fi

if brew list | grep -q "^python@3.11$"; then
    print_success "Python (already installed)"
else
    print_in_yellow "  [ ] Python"
    brew install python@3.11 &> /dev/null
    print_result $? "Python"
fi

if brew list | grep -q "^ruby$"; then
    print_success "Ruby (already installed)"
else
    print_in_yellow "  [ ] Ruby"
    brew install ruby &> /dev/null
    print_result $? "Ruby"
fi

if brew list | grep -q "^rust$"; then
    print_success "Rust (already installed)"
else
    print_in_yellow "  [ ] Rust"
    brew install rust &> /dev/null
    print_result $? "Rust"
fi

# Shell tools
if brew list | grep -q "^tmux$"; then
    print_success "tmux (already installed)"
else
    print_in_yellow "  [ ] tmux"
    brew install tmux &> /dev/null
    print_result $? "tmux"
fi

if brew list | grep -q "^the_silver_searcher$"; then
    print_success "The Silver Searcher (already installed)"
else
    print_in_yellow "  [ ] The Silver Searcher"
    brew install the_silver_searcher &> /dev/null
    print_result $? "The Silver Searcher"
fi

if brew list | grep -q "^fzf$"; then
    print_success "fzf (already installed)"
else
    print_in_yellow "  [ ] fzf"
    brew install fzf &> /dev/null
    print_result $? "fzf"
fi

if brew list | grep -q "^jq$"; then
    print_success "jq (already installed)"
else
    print_in_yellow "  [ ] jq"
    brew install jq &> /dev/null
    print_result $? "jq"
fi

if brew list | grep -q "^yq$"; then
    print_success "yq (already installed)"
else
    print_in_yellow "  [ ] yq"
    brew install yq &> /dev/null
    print_result $? "yq"
fi

print_in_green "\n  Development tools setup complete!\n"

print_in_yellow "\n  Restart your shell to apply all changes.\n"
