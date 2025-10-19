#!/bin/zsh

# This script fixes the utils.zsh paths in all zsh scripts in the macos directory

# Base directory
BASE_DIR="/Users/evandroreis/dotfiles/macos/install"

# Find all zsh files
find "$BASE_DIR" -name "*.zsh" | while read -r file; do
    echo "Processing $file..."

    # Skip main.zsh as it's already been fixed
    if [[ "$file" == *"/main.zsh" ]]; then
        echo "Skipping main.zsh"
        continue
    fi

    # Calculate the relative path to the utils.zsh files
    # Get the directory depth relative to BASE_DIR
    rel_path="${file#$BASE_DIR/}"
    depth=$(echo "$rel_path" | tr -cd '/' | wc -c)

    # Create the correct path string based on depth
    utils_path=""
    for ((i=0; i<depth; i++)); do
        utils_path="../$utils_path"
    done

    # Create the sed commands to replace the paths
    sed_cmd1="s|source \"\\${SCRIPT_DIR}/../../utils.zsh\"|source \"\\${SCRIPT_DIR}/${utils_path}../../utils.zsh\"|g"
    sed_cmd2="s|source \"\\${SCRIPT_DIR}/utils.zsh\"|source \"\\${SCRIPT_DIR}/${utils_path}../utils.zsh\"|g"

    # Apply the replacements
    sed -i '' "$sed_cmd1" "$file"
    sed -i '' "$sed_cmd2" "$file"

    # Check if the file contains the SCRIPT_DIR variable
    if ! grep -q "SCRIPT_DIR=" "$file"; then
        # Add the SCRIPT_DIR variable and source commands at the beginning of the file
        temp_file=$(mktemp)
        {
            echo "#!/usr/bin/env zsh"
            echo ""
            echo "# Get the directory of the current script"
            echo "SCRIPT_DIR=\${0:a:h}"
            echo "source \"\${SCRIPT_DIR}/${utils_path}../../utils.zsh\""
            echo "source \"\${SCRIPT_DIR}/${utils_path}../utils.zsh\" 2>/dev/null || true  # Source local utils if available"
            echo ""
            echo "# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
            echo ""
            tail -n +2 "$file"  # Skip the first line (shebang) as we already added it
        } > "$temp_file"
        mv "$temp_file" "$file"
        chmod +x "$file"
    fi

    echo "Fixed $file"
done

echo "All files processed!"
