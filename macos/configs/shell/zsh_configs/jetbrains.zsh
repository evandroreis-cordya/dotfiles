#!/bin/zsh
#
# JetBrains Configuration
# This file contains all JetBrains-related configurations
#

# Environment Variables
export JETBRAINS_CONFIG_DIR="$HOME/.config/JetBrains"
export JETBRAINS_VMOPTIONS="$HOME/.jetbrains.vmoptions"

# JetBrains IDE Paths
export INTELLIJ_CONFIG_DIR="$HOME/Library/Application Support/JetBrains/IntelliJIdea"
export PYCHARM_CONFIG_DIR="$HOME/Library/Application Support/JetBrains/PyCharm"
export WEBSTORM_CONFIG_DIR="$HOME/Library/Application Support/JetBrains/WebStorm"
export PHPSTORM_CONFIG_DIR="$HOME/Library/Application Support/JetBrains/PhpStorm"

# Aliases
alias intellij="open -a 'IntelliJ IDEA'"
alias pycharm="open -a 'PyCharm'"
alias webstorm="open -a 'WebStorm'"
alias phpstorm="open -a 'PhpStorm'"
alias clion="open -a 'CLion'"
alias goland="open -a 'GoLand'"
alias rubymine="open -a 'RubyMine'"
alias datagrip="open -a 'DataGrip'"

# Functions
jetbrains_setup() {
    # Create VM options file if it doesn't exist
    if [[ ! -f "$JETBRAINS_VMOPTIONS" ]]; then
        cat > "$JETBRAINS_VMOPTIONS" << 'EOF'
# JetBrains VM Options
-Xmx2048m
-XX:+UseG1GC
-XX:MaxGCPauseMillis=200
-XX:+UnlockExperimentalVMOptions
-XX:+UseCGroupMemoryLimitForHeap
EOF
        echo "Created JetBrains VM options file."
    fi
    echo "JetBrains configuration is complete."
}

# Tool-specific setup
jetbrains_setup
