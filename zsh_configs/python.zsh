#!/bin/zsh
#
# Python configuration for zsh
# This file contains all Python-related configurations
#

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# if command -v direnv &> /dev/null; then
#     eval "$(direnv hook zsh 2>&1 | grep -v 'direnv:')" 2>&1 >/dev/null
#     export DIRENV_WARN_TIMEOUT="0s"
#     export DIRENV_LOG_FORMAT=""
# fi

# Uncomment if you want to use pyenv
if command -v pyenv 1>/dev/null 2>&1; then
   eval "$(pyenv init --path)"
   eval "$(pyenv virtualenv-init -)"
fi

# Python aliases
alias py="python3"
alias py3="python3"
alias pip="pip3"
alias pip-upgrade="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U"
alias pip3-upgrade="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"

# Virtual environment configuration
if [ -d "$VIRTUAL_ENV" ]; then
  export PATH="$VIRTUAL_ENV/bin:$PATH"
fi

#==============================================================================
# UV VIRTUAL ENVIRONMENT FUNCTIONS
#==============================================================================

# Function to check for and activate UV virtual environment
activate_uv_venv() {
    # Check if UV is available
    if ! command -v uv &>/dev/null; then
        echo "UV is not installed. Install it with: curl -LsSf https://astral.sh/uv/install.sh | sh"
        return 1
    fi

    # Start from current directory and search upwards
    local current_dir="$PWD"
    local venv_path=""

    while [[ "$current_dir" != "/" ]]; do
        # Check for .venv directory (standard UV location)
        if [[ -d "$current_dir/.venv" ]]; then
            venv_path="$current_dir/.venv"
            break
        fi

        # Check for .uv directory (alternative UV location)
        if [[ -d "$current_dir/.uv" ]]; then
            venv_path="$current_dir/.uv"
            break
        fi

        # Move up one directory
        current_dir="$(dirname "$current_dir")"
    done

    # If no virtual environment found
    if [[ -z "$venv_path" ]]; then
        echo "No UV virtual environment found in current directory tree."
        echo "Create one with: uv venv"
        return 1
    fi

    # Check if we're already in a virtual environment
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Check if it's the same venv we found
        if [[ "$VIRTUAL_ENV" == "$venv_path" ]]; then
            echo "UV virtual environment already activated: $venv_path"
            return 0
        else
            echo "Deactivating current virtual environment: $VIRTUAL_ENV"
            deactivate 2>/dev/null || unset VIRTUAL_ENV
        fi
    fi

    # Activate the virtual environment
    local activate_script="$venv_path/bin/activate"

    if [[ -f "$activate_script" ]]; then
        # Source the activation script (this does NOT create a venv, only activates)
        source "$activate_script"

        # Ensure VIRTUAL_ENV is set and exported globally
        if [[ -z "$VIRTUAL_ENV" ]]; then
            # If activation script didn't set it, set it manually
            export VIRTUAL_ENV="$venv_path"
        fi

        # Update PATH to include venv bin directory
        export PATH="$VIRTUAL_ENV/bin:$PATH"

        echo "Activated UV virtual environment: $venv_path"
        echo "  VIRTUAL_ENV: $VIRTUAL_ENV"

        # Display Python version
        if command -v python &>/dev/null; then
            echo "  Python: $(python --version 2>&1)"
        fi

        # Display UV version
        if command -v uv &>/dev/null; then
            echo "  UV: $(uv --version 2>&1)"
        fi

        return 0
    else
        echo "Virtual environment found but activation script is missing: $activate_script"
        echo "The environment might be corrupted. Try recreating it with: uv venv"
        return 1
    fi
}

# Alias for convenience
alias uvenv="activate_uv_venv"
alias uvactivate="activate_uv_venv"
# Note: 'uva' is used by Oh My Zsh UV plugin for 'uv add', so we use 'uvactivate' instead

# Function to automatically activate UV venv when entering a directory
# Function to automatically activate UV venv when entering a directory
auto_activate_uv_venv() {
    # Only run if UV is installed
    if ! command -v uv &>/dev/null; then
        return
    fi

    # Search upward for .venv or .uv directory (like activate_uv_venv does)
    local current_dir="$PWD"
    local venv_path=""

    while [[ "$current_dir" != "/" ]]; do
        if [[ -d "$current_dir/.venv" ]]; then
            venv_path="$current_dir/.venv"
            break
        elif [[ -d "$current_dir/.uv" ]]; then
            venv_path="$current_dir/.uv"
            break
        fi
        current_dir="$(dirname "$current_dir")"
    done

    # If venv found, activate it
    if [[ -n "$venv_path" ]]; then
        # Only activate if not already in this venv
        if [[ "$VIRTUAL_ENV" != "$venv_path" ]]; then
            # Silently activate - just source the activation script directly
            local activate_script="$venv_path/bin/activate"
            if [[ -f "$activate_script" ]]; then
                # Deactivate current venv if any
                if [[ -n "$VIRTUAL_ENV" ]]; then
                    deactivate 2>/dev/null || unset VIRTUAL_ENV
                fi
                # Activate silently
                source "$activate_script" 2>/dev/null

                # Ensure VIRTUAL_ENV is set and exported globally (in case activate script failed)
                if [[ -z "$VIRTUAL_ENV" ]]; then
                    export VIRTUAL_ENV="$venv_path"
                fi

                # Update PATH to include venv bin directory
                export PATH="$VIRTUAL_ENV/bin:$PATH"
            fi
        fi
    elif [[ -n "$VIRTUAL_ENV" ]]; then
        # Deactivate when leaving a directory with venv
        # Check if we're no longer in a subdirectory of the venv project
        local venv_project_dir="${VIRTUAL_ENV%/.venv}"
        venv_project_dir="${venv_project_dir%/.uv}"
        if [[ "$PWD" != "$venv_project_dir"* ]]; then
            deactivate 2>/dev/null || unset VIRTUAL_ENV
        fi
    fi
}
# Optional: Auto-activation enabled
# This will automatically activate UV venvs when entering directories
# autoload -U add-zsh-hook
# add-zsh-hook chpwd auto_activate_uv_venv

# # Also activate on shell startup if in a directory with .venv
# auto_activate_uv_venv
