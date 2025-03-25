#!/usr/bin/env zsh

# This script targets specific files that need to be updated from BASH to ZSH syntax

# Files to update
FILES=(
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/npm.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/misc_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/xcode.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/image_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/vim.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/communication_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/frontend_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/docker.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/generative_ai.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/creative_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/kaspersky_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/cerebras_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/azure_ai_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/browser_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/vercel_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/cloud_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/ui_and_ux.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/grok_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/textedit.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/autonomous_agents.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/ai_desktop_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/maps.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/openai_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/amazon_ai_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/google_ai_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/nvidia_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/backend_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/anthropic_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/chrome.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/ai_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/security_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/oracle_ai_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/language_and_region.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/ml_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/meta_ai_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/preferences/macos/deepseek_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/office.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/video_tools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/databasetools.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/tmux.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/yarn.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/misc.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/visualstudiocode.zsh"
    "/Users/evandroreis/.jarvistoolset/scripts/os/install/macos/web_font_tools.zsh"
)

# Counter for modified files
MODIFIED_COUNT=0

for file in "${FILES[@]}"; do
    # Check if file exists
    if [[ -f "$file" ]]; then
        echo "Updating file: $file"
        
        # Create a backup
        cp "$file" "${file}.bak"
        
        # Check if file contains BASH references
        if grep -q "BASH_SOURCE" "$file" || grep -q "#!/bin/bash" "$file" || grep -q "utils.sh" "$file"; then
            # Replace shebang
            sed -i '' 's|#!/bin/bash|#!/usr/bin/env zsh|g' "$file"
            
            # Replace BASH_SOURCE[0] with ZSH equivalent
            sed -i '' 's|cd "$(dirname "${BASH_SOURCE\[0\]}")"|# Get the directory of the current script\nSCRIPT_DIR=${0:a:h}|g' "$file"
            
            # Replace utils.sh with utils.zsh
            sed -i '' 's|utils\.sh|utils\.zsh|g' "$file"
            
            # Replace && . with source
            sed -i '' 's|\&\& \. \([^\\]*\)|source \1|g' "$file"
            sed -i '' 's|\&\& \. \\\n\s*\([^\\]*\)|source \1|g' "$file"
            
            # Add appropriate source lines based on file location
            if [[ "$file" == *"/install/macos/"* ]]; then
                if ! grep -q "source.*utils.zsh" "$file"; then
                    # Add after SCRIPT_DIR line or add at the top if not found
                    if grep -q "SCRIPT_DIR=" "$file"; then
                        sed -i '' '/SCRIPT_DIR=/a\'$'\n''source "${SCRIPT_DIR}/../../utils.zsh"\nsource "${SCRIPT_DIR}/utils.zsh"' "$file"
                    else
                        sed -i '' '2i\'$'\n''# Get the directory of the current script\nSCRIPT_DIR=${0:a:h}\nsource "${SCRIPT_DIR}/../../utils.zsh"\nsource "${SCRIPT_DIR}/utils.zsh"\n' "$file"
                    fi
                fi
            elif [[ "$file" == *"/install/"* ]]; then
                if ! grep -q "source.*utils.zsh" "$file"; then
                    if grep -q "SCRIPT_DIR=" "$file"; then
                        sed -i '' '/SCRIPT_DIR=/a\'$'\n''source "${SCRIPT_DIR}/../utils.zsh"' "$file"
                    else
                        sed -i '' '2i\'$'\n''# Get the directory of the current script\nSCRIPT_DIR=${0:a:h}\nsource "${SCRIPT_DIR}/../utils.zsh"\n' "$file"
                    fi
                fi
            elif [[ "$file" == *"/preferences/macos/"* ]]; then
                if ! grep -q "source.*utils.zsh" "$file"; then
                    if grep -q "SCRIPT_DIR=" "$file"; then
                        sed -i '' '/SCRIPT_DIR=/a\'$'\n''source "${SCRIPT_DIR}/../../utils.zsh"' "$file"
                    else
                        sed -i '' '2i\'$'\n''# Get the directory of the current script\nSCRIPT_DIR=${0:a:h}\nsource "${SCRIPT_DIR}/../../utils.zsh"\n' "$file"
                    fi
                fi
            elif [[ "$file" == *"/preferences/"* ]]; then
                if ! grep -q "source.*utils.zsh" "$file"; then
                    if grep -q "SCRIPT_DIR=" "$file"; then
                        sed -i '' '/SCRIPT_DIR=/a\'$'\n''source "${SCRIPT_DIR}/../utils.zsh"' "$file"
                    else
                        sed -i '' '2i\'$'\n''# Get the directory of the current script\nSCRIPT_DIR=${0:a:h}\nsource "${SCRIPT_DIR}/../utils.zsh"\n' "$file"
                    fi
                fi
            fi
            
            echo "✓ Updated $file"
            ((MODIFIED_COUNT++))
        else
            echo "No BASH references found in $file"
        fi
    else
        echo "File not found: $file"
    fi
done

echo "=== Conversion Complete ==="
echo "Modified $MODIFIED_COUNT files"
echo "Please review the changes and test the scripts"
echo "Backup files with .bak extension were created"
