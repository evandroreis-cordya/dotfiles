#!/bin/zsh
#
# Go configuration for zsh
# This file contains all Go-related configurations
#

# Go environment variables
export GOROOT=$(brew --prefix go)/libexec
export GOPATH=$HOME/go
export GOBIN="$GOPATH/bin"
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH
export PATH=/usr/local/share/dotnet/sdk:$PATH
export GO111MODULE=on

# Go aliases
alias gr="go run"
alias gt="go test"
alias gta="go test ./..."
alias gb="go build"
alias gget="go get"
alias gmod="go mod"
alias gi="go install"
alias gf="go fmt"
alias gv="go vet"
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
