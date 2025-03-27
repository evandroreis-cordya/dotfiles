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
go_install "Go Language Server" "golang.org/x/tools/gopls"
go_install "Go Imports" "golang.org/x/tools/cmd/goimports"
go_install "Go Doc" "golang.org/x/tools/cmd/godoc"
go_install "Go Guru" "golang.org/x/tools/cmd/guru"
go_install "Go Rename" "golang.org/x/tools/cmd/gorename"
go_install "Go Lint" "golang.org/x/lint/golint"
go_install "GolangCI Lint" "github.com/golangci/golangci-lint/cmd/golangci-lint"

# Testing and Debugging
go_install "Delve Debugger" "github.com/go-delve/delve/cmd/dlv"
go_install "Go Mock" "github.com/golang/mock/mockgen"
go_install "Go Test" "github.com/rakyll/gotest"
go_install "Go Test Deep" "github.com/vdemeester/k8s-pkg-credentialprovider/pkg/go-testdeep"
go_install "Go Benchstat" "golang.org/x/perf/cmd/benchstat"

# Code Generation
go_install "Go Generate" "golang.org/x/tools/cmd/stringer"
go_install "Go Swagger" "github.com/go-swagger/go-swagger/cmd/swagger"
go_install "Go Wire" "github.com/google/wire/cmd/wire"
go_install "Go Protobuf" "github.com/golang/protobuf/protoc-gen-go"
go_install "Go GRPC" "google.golang.org/grpc/cmd/protoc-gen-go-grpc"

# Web Development
go_install "Air Live Reload" "github.com/cosmtrek/air"
go_install "Go Fiber CLI" "github.com/gofiber/cli/fiber"
go_install "Go Buffalo" "github.com/gobuffalo/buffalo/cmd/buffalo"

# Database Tools
go_install "Go Migrate" "github.com/golang-migrate/migrate/cmd/migrate"
go_install "SQL Boiler" "github.com/volatiletech/sqlboiler/v4"
go_install "SQL Boiler MySQL" "github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-mysql"
go_install "SQL Boiler PostgreSQL" "github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql"

# Utility Tools
go_install "Go Critic" "github.com/go-critic/go-critic/cmd/gocritic"
go_install "Go Callvis" "github.com/ofabry/go-callvis"
go_install "Go Releaser" "github.com/goreleaser/goreleaser"
go_install "Go Licenses" "github.com/google/go-licenses"

# Performance Tools
go_install "Go Benchcmp" "golang.org/x/tools/cmd/benchcmp"
go_install "Go Torch" "github.com/uber/go-torch"
go_install "Go Pprof" "github.com/google/pprof"

# Security Tools
go_install "Go Sec" "github.com/securego/gosec/v2/cmd/gosec"
go_install "Nancy" "github.com/sonatype-nexus-community/nancy"

# Documentation Tools
go_install "Go Doc Site" "github.com/shurcooL/goexec"
go_install "Go Readme" "github.com/posener/goreadme/cmd/goreadme"

# Kubernetes Development
go_install "Kubectl" "k8s.io/kubectl"
go_install "Kustomize" "sigs.k8s.io/kustomize/kustomize/v4"
go_install "Helm" "helm.sh/helm/v3/cmd/helm"

# Cloud Development
go_install "Terraform" "github.com/hashicorp/terraform"
go_install "AWS CLI" "github.com/aws/aws-cli/v2"
go_install "GCP CLI" "cloud.google.com/go/cmd/gcp"

# Containerization
go_install "Docker Compose" "github.com/docker/compose/v2"
go_install "Buildah" "github.com/containers/buildah/cmd/buildah"
go_install "Podman" "github.com/containers/podman/v4/cmd/podman"

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

# Fix graphviz installation
brew install graphviz &> /dev/null
print_result $? "graphviz"

print_in_green "\n  Go development environment setup complete!\n"
