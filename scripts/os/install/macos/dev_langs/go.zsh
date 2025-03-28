#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../../utils.zsh"
source "${SCRIPT_DIR}/../../utils.zsh" 2>/dev/null || true  # Source local utils if available

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../../utils.zsh" \
    && source "./utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Go\n\n"

brew_install "Go" "go"

# Create modular configuration file for Go
create_go_config() {
    local config_dir="$HOME/.jarvistoolset/zsh_configs"
    local config_file="$config_dir/go.zsh"
    
    # Create directory if it doesn't exist
    mkdir -p "$config_dir"
    
    # Create Go configuration file
    cat > "$config_file" << 'EOL'
#!/bin/zsh
#
# Go configuration for zsh
# This file contains all Go-related configurations
#

# Go environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Go aliases
alias gofmt="gofmt -w"
alias govet="go vet"
alias gotest="go test ./..."
alias gocover="go test -cover ./..."
alias gobench="go test -bench=. ./..."

# Go project creation function
new-go() {
    if [ $# -lt 1 ]; then
        echo "Usage: new-go <project-name> [module-name]"
        return 1
    fi
    
    local project_name=$1
    local module_name=${2:-"github.com/$(whoami)/$project_name"}
    
    # Create project directory
    mkdir -p "$project_name"
    cd "$project_name" || return
    
    # Initialize Go module
    go mod init "$module_name"
    
    # Create main.go
    cat > main.go << EOF
package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, $project_name!")
}
EOF
    
    # Create .gitignore
    cat > .gitignore << EOF
# Binaries for programs and plugins
*.exe
*.exe~
*.dll
*.so
*.dylib

# Test binary, built with 'go test -c'
*.test

# Output of the go coverage tool
*.out

# Dependency directories
/vendor/
EOF
    
    # Initialize git repository if git is available
    if command -v git >/dev/null 2>&1; then
        git init
        git add .
        git commit -m "Initial commit"
    fi
    
    echo "Go project '$project_name' created successfully!"
}
EOL
    
    print_result $? "Created Go configuration file"
}

# Create Go workspace directories
mkdir -p "$HOME/go/src"
mkdir -p "$HOME/go/bin"
mkdir -p "$HOME/go/pkg"

# Install Go tools
print_in_purple "\n   Installing Go Tools\n\n"

# Install essential Go tools
go_install() {
    declare -r PACKAGE="$1"
    declare -r PACKAGE_READABLE_NAME="$2"

    if command -v "$PACKAGE" &> /dev/null; then
        print_success "$PACKAGE_READABLE_NAME"
    else
        execute "go install $PACKAGE@latest" "$PACKAGE_READABLE_NAME"
    fi
}

go_install "golang.org/x/tools/gopls@latest" "Go Language Server"
go_install "github.com/go-delve/delve/cmd/dlv@latest" "Go Debugger"
go_install "golang.org/x/lint/golint@latest" "Go Linter"
go_install "github.com/golangci/golangci-lint/cmd/golangci-lint@latest" "GolangCI Lint"
go_install "github.com/fatih/gomodifytags@latest" "Go Modify Tags"
go_install "github.com/josharian/impl@latest" "Go Implementation Generator"
go_install "github.com/cweill/gotests/gotests@latest" "Go Test Generator"
go_install "github.com/haya14busa/goplay/cmd/goplay@latest" "Go Playground"
go_install "github.com/stamblerre/gocode@latest" "Go Code"
go_install "github.com/ramya-rao-a/go-outline@latest" "Go Outline"
go_install "github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest" "Go Packages"

# Create modular configuration
create_go_config

print_in_green "\n  Go development environment setup complete!\n"
