#!/usr/bin/env zsh

# Script to update BASH references to ZSH in all script files
# This will replace ${BASH_SOURCE[0]} with ${0:a:h} and other BASH-specific syntax

print_in_green() {
    printf "\e[0;32m%s\e[0m" "$1"
}

print_in_yellow() {
    printf "\e[0;33m%s\e[0m" "$1"
}

print_in_red() {
    printf "\e[0;31m%s\e[0m" "$1"
}

# Find all zsh files
FILES=$(find /Users/evandroreis/.jarvistoolset/scripts/os -name "*.zsh")

# Counter for modified files
MODIFIED_COUNT=0

for file in $FILES; do
    # Skip this script itself
    if [[ "$file" == *"update_bash_to_zsh.zsh"* ]]; then
        continue
    fi
    
    # Check if file contains BASH references
    if grep -q "BASH_SOURCE" "$file" || grep -q "#!/bin/bash" "$file" || grep -q ".bash" "$file" || grep -q "utils.sh" "$file"; then
        print_in_yellow "\nUpdating file: $file\n"
        
        # Create a backup
        cp "$file" "${file}.bak"
        
        # Replace shebang
        sed -i '' 's|#!/bin/bash|#!/usr/bin/env zsh|g' "$file"
        
        # Replace BASH_SOURCE[0] with ZSH equivalent
        sed -i '' 's|cd "$(dirname "${BASH_SOURCE\[0\]}")"|# Get the directory of the current script\nSCRIPT_DIR=${0:a:h}|g' "$file"
        
        # Replace .bash.local with .zshrc
        sed -i '' 's|\.bash\.local|\.zshrc|g' "$file"
        
        # Replace utils.sh with utils.zsh
        sed -i '' 's|utils\.sh|utils\.zsh|g' "$file"
        
        # Replace && . with source
        sed -i '' 's|\&\& \. \([^\\]*\)|source \1|g' "$file"
        sed -i '' 's|\&\& \. \\\n\s*\([^\\]*\)|source \1|g' "$file"
        
        # Check if we need to add source line
        if grep -q "SCRIPT_DIR=\${0:a:h}" "$file" && ! grep -q "source.*utils.zsh" "$file"; then
            # Determine the relative path to utils.zsh
            if [[ "$file" == *"/install/macos/"* ]]; then
                sed -i '' '/SCRIPT_DIR=${0:a:h}/a\'$'\n''source "${SCRIPT_DIR}/../../utils.zsh"\nsource "${SCRIPT_DIR}/utils.zsh"' "$file"
            elif [[ "$file" == *"/install/"* ]]; then
                sed -i '' '/SCRIPT_DIR=${0:a:h}/a\'$'\n''source "${SCRIPT_DIR}/../utils.zsh"' "$file"
            elif [[ "$file" == *"/preferences/macos/"* ]]; then
                sed -i '' '/SCRIPT_DIR=${0:a:h}/a\'$'\n''source "${SCRIPT_DIR}/../../utils.zsh"' "$file"
            elif [[ "$file" == *"/preferences/"* ]]; then
                sed -i '' '/SCRIPT_DIR=${0:a:h}/a\'$'\n''source "${SCRIPT_DIR}/../utils.zsh"' "$file"
            else
                sed -i '' '/SCRIPT_DIR=${0:a:h}/a\'$'\n''source "${SCRIPT_DIR}/utils.zsh"' "$file"
            fi
        fi
        
        print_in_green "✓ Updated $file\n"
        ((MODIFIED_COUNT++))
    fi
done

print_in_green "\n=== Conversion Complete ===\n"
print_in_green "Modified $MODIFIED_COUNT files\n"
print_in_yellow "Please review the changes and test the scripts\n"
print_in_yellow "Backup files with .bak extension were created\n"
