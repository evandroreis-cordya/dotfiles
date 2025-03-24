#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Swift Development Tools\n\n"

# Install Xcode Command Line Tools if not already installed
if ! xcode-select -p &> /dev/null; then
    print_in_purple "\n   Installing Xcode Command Line Tools\n\n"
    xcode-select --install
fi

# Install Swift development tools
print_in_purple "\n   Installing Swift Tools\n\n"

# Install SwiftLint
brew_install "SwiftLint" "swiftlint"

# Install SwiftFormat
brew_install "SwiftFormat" "swiftformat"

# Install Sourcery
brew_install "Sourcery" "sourcery"

# Install Jazzy for documentation
gem install jazzy

# Install development tools
print_in_purple "\n   Installing Development Tools\n\n"

# Install Carthage
brew_install "Carthage" "carthage"

# Install CocoaPods
gem install cocoapods

# Install Mint (Swift package manager)
brew_install "Mint" "mint"

# Install Fastlane
brew_install "Fastlane" "fastlane"

# Configure Swift environment
if ! grep -q 'SWIFT_HOME' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# Swift configuration
export SWIFT_HOME="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain"
export PATH="$SWIFT_HOME/usr/bin:$PATH"

# iOS development paths
export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
export PATH="$DEVELOPER_DIR/usr/bin:$PATH"
EOL
fi

# Add Swift helper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

# Swift development functions
new-swift() {
    if [[ -n "$1" ]]; then
        # Create Swift package
        swift package init --type executable --name "$1"
        cd "$1"
        
        # Update Package.swift with common dependencies
        cat > Package.swift << 'EOF'
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "$1",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    dependencies: [
        // Dependencies here
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "$1",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        .testTarget(
            name: "${1}Tests",
            dependencies: ["$1"]
        ),
    ]
)
EOF

        # Create .gitignore
        cat > .gitignore << 'EOF'
.DS_Store
/.build
/Packages
/*.xcodeproj
xcuserdata/
DerivedData/
.swiftpm/config/registries.json
.swiftpm/xcode/package.xcworkspace/contents.xcworkspacedata
.netrc
.swiftpm
EOF

        # Create SwiftLint configuration
        cat > .swiftlint.yml << 'EOF'
disabled_rules:
  - trailing_whitespace
  - vertical_whitespace

opt_in_rules:
  - empty_count
  - missing_docs

included:
  - Sources
  - Tests

excluded:
  - Carthage
  - Pods
  - .build

line_length:
  warning: 120
  error: 200

function_body_length:
  warning: 50
  error: 100
EOF

        # Initialize git repository
        git init
        git add .
        git commit -m "Initial commit"
        
        print_in_green "\nSwift project '$1' created successfully!\n"
    else
        echo "Please provide a project name"
    fi
}

# Swift aliases
alias swb="swift build"
alias swt="swift test"
alias swr="swift run"
alias swc="swift clean"
alias swx="swift package"
alias swi="swift package init"
alias swu="swift package update"

# Xcode aliases
alias xcb="xcodebuild"
alias xco="xcode-select"
alias xcp="xcodebuild -project"
alias xcw="xcodebuild -workspace"

# CocoaPods aliases
alias pi="pod install"
alias pu="pod update"
alias pc="pod clean"
alias pout="pod outdated"

# Carthage aliases
alias cbu="carthage update"
alias cbb="carthage build"
alias cbx="carthage bootstrap"

# Fastlane aliases
alias fl="fastlane"
alias flb="fastlane beta"
alias flt="fastlane test"
alias fld="fastlane deploy"
EOL

print_result $? "Swift development environment"

# Install additional tools
brew_install "xcbeautify" "xcbeautify"  # xcodebuild formatter
brew_install "xcodegen" "xcodegen"      # Generate Xcode projects
