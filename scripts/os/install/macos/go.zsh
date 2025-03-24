#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Go Development Tools\n\n"

# Install Go
brew_install "Go" "go"

# Set up Go environment
if ! grep -q 'GOPATH' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# Go configuration
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export GO111MODULE=on
EOL
fi

# Create Go workspace directories
mkdir -p "$HOME/go"/{bin,pkg,src}

# Install Go tools
print_in_purple "\n   Installing Go Tools\n\n"

# Development Tools
go install golang.org/x/tools/gopls@latest                     # Language server
go install golang.org/x/tools/cmd/goimports@latest            # Import manager
go install golang.org/x/tools/cmd/godoc@latest               # Documentation
go install golang.org/x/tools/cmd/guru@latest               # Source code navigator
go install golang.org/x/tools/cmd/gorename@latest          # Rename symbols
go install golang.org/x/lint/golint@latest                # Linter
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest  # Meta linter

# Code Generation
go install golang.org/x/tools/cmd/stringer@latest        # String generators
go install github.com/cweill/gotests/gotests@latest     # Test generator
go install github.com/fatih/gomodifytags@latest        # Struct tag modifier

# Debugging
go install github.com/go-delve/delve/cmd/dlv@latest   # Debugger

# Testing
go install github.com/rakyll/gotest@latest           # Colorized test output
go install github.com/jstemmer/go-junit-report@latest # JUnit reports

# Documentation
go install github.com/princjef/gomarkdoc/cmd/gomarkdoc@latest # Markdown docs

# Database
go install github.com/pressly/goose/v3/cmd/goose@latest      # DB migrations

# Web Development
go install github.com/cosmtrek/air@latest                    # Live reload

# Performance
go install github.com/google/pprof@latest                   # Profiling

# Optional Development Tools
# Uncomment if needed
# go install github.com/spf13/cobra-cli@latest             # CLI framework
# go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest  # gRPC client
# go install google.golang.org/protobuf/cmd/protoc-gen-go@latest # Protocol buffers
# go install github.com/golang/mock/mockgen@latest        # Mock generator

# Configure Go environment
cat > "$HOME/.golangci.yml" << 'EOL'
linters:
  enable:
    - gofmt
    - golint
    - govet
    - errcheck
    - staticcheck
    - gosimple
    - ineffassign
    - unconvert
    - misspell
    - prealloc

run:
  deadline: 5m
  tests: true
  skip-dirs:
    - vendor/
    - third_party/

issues:
  exclude-use-default: false
EOL

# Add Go helper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

# Go development functions
new-go() {
    if [[ -n "$1" ]]; then
        mkdir -p "$1"
        cd "$1"
        go mod init "$1"
        mkdir -p cmd pkg internal
        cat > cmd/main.go << 'EOF'
package main

import (
    "fmt"
    "log"
)

func main() {
    log.Println("Starting application...")
    fmt.Println("Hello, World!")
}
EOF
        git init
        cat > .gitignore << 'EOF'
# Binaries
/bin/
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

# Go workspace file
go.work
EOF
        go mod tidy
        git add .
        git commit -m "Initial commit"
    else
        echo "Please provide a project name"
    fi
}

# Go aliases
alias gr="go run"
alias gt="go test"
alias gta="go test ./..."
alias gb="go build"
alias gf="go fmt"
alias gv="go vet"
alias gm="go mod"
alias gmt="go mod tidy"
alias gmv="go mod vendor"
EOL

print_result $? "Go development environment"

# Install additional dependencies
brew_install "protobuf" "protobuf"  # Protocol Buffers
brew_install "graphviz" "graphviz"  # Dependency graphs
