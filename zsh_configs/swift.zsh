#!/bin/zsh
#
# Swift configuration for zsh
# This file contains all Swift-related configurations
#

# Swift environment variables
export PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:$PATH"
export TOOLCHAINS=swift

# Swift aliases
alias sb="swift build"
alias sr="swift run"
alias st="swift test"
alias sp="swift package"
alias spi="swift package init"
alias spu="swift package update"
alias swiftc="swiftc -O"

# Swift development functions
new-swift() {
    if [[ -n "$1" ]]; then
        mkdir -p "$1"
        cp -r "$HOME/.swift_project_template/"* "$1/"
        cd "$1"
        # Replace placeholder with actual project name
        sed -i '' "s/SwiftApp/$1/g" Package.swift
        git init
        git add .
        git commit -m "Initial commit"
        echo "Swift project $1 created successfully!"
    else
        echo "Please provide a project name"
    fi
}
