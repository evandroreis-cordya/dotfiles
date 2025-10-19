#!/bin/zsh
#
# Install and configure Oh My Zsh
#
# This script installs Oh My Zsh and configures it with recommended settings
# It also installs popular plugins and themes
#

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../../utils.zsh"
source "${SCRIPT_DIR}/../utils.zsh"
source "${SCRIPT_DIR}/../utils.zsh" 2>/dev/null || true  # Source local utils if available

# Check if Oh My Zsh is already installed
check_oh_my_zsh_installed() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        return 0
    else
        return 1
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    print_info "Installing Oh My Zsh..."

    # Backup existing .zshrc if it exists
    if [[ -f "$HOME/.zshrc" ]]; then
        print_info "Backing up existing .zshrc to .zshrc.backup"
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    fi

    # Install Oh My Zsh silently
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1

    print_result $? "Oh My Zsh"
}

# Install custom plugins
install_custom_plugins() {
    print_info "Installing custom Oh My Zsh plugins..."

    # Create custom plugins directory if it doesn't exist
    mkdir -p "$HOME/.oh-my-zsh/custom/plugins"

    # Install zsh-syntax-highlighting
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" --quiet
        print_result $? "zsh-syntax-highlighting plugin"
    fi

    # Install zsh-autosuggestions
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" --quiet
        print_result $? "zsh-autosuggestions plugin"
    fi

    # Install zsh-completions
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]]; then
        git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" --quiet
        print_result $? "zsh-completions plugin"
    fi

    # Install history-substring-search
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/history-substring-search" ]]; then
        git clone https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/.oh-my-zsh/custom/plugins/history-substring-search" --quiet
        print_result $? "history-substring-search plugin"
    fi

    # Install thefuck
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/thefuck" ]]; then
        git clone https://github.com/nvbn/thefuck.git "$HOME/.oh-my-zsh/custom/plugins/thefuck" --quiet
        print_result $? "thefuck plugin"
    fi

    # Install fzf-tab (enhanced tab completion)
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/fzf-tab" ]]; then
        git clone https://github.com/Aloxaf/fzf-tab.git "$HOME/.oh-my-zsh/custom/plugins/fzf-tab" --quiet
        print_result $? "fzf-tab plugin"
    fi

    # Install fast-syntax-highlighting (alternative to zsh-syntax-highlighting)
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]]; then
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" --quiet
        print_result $? "fast-syntax-highlighting plugin"
    fi

    # Install zsh-autocomplete (alternative to zsh-autosuggestions)
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete" ]]; then
        git clone https://github.com/marlonrichert/zsh-autocomplete.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete" --quiet
        print_result $? "zsh-autocomplete plugin"
    fi

    # Install conda-zsh-completion
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/conda-zsh-completion" ]]; then
        git clone https://github.com/esc/conda-zsh-completion.git "$HOME/.oh-my-zsh/custom/plugins/conda-zsh-completion" --quiet
        print_result $? "conda-zsh-completion plugin"
    fi

    # Install zsh-vi-mode (vi mode for zsh)
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode" ]]; then
        git clone https://github.com/jeffreytse/zsh-vi-mode.git "$HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode" --quiet
        print_result $? "zsh-vi-mode plugin"
    fi

    # Install zsh-nvm (nvm plugin for zsh)
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-nvm" ]]; then
        git clone https://github.com/lukechilds/zsh-nvm.git "$HOME/.oh-my-zsh/custom/plugins/zsh-nvm" --quiet
        print_result $? "zsh-nvm plugin"
    fi

    # Install zsh-docker-aliases (docker aliases)
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-docker-aliases" ]]; then
        git clone https://github.com/docker/cli.git /tmp/docker-cli --quiet
        if [[ -d "/tmp/docker-cli/contrib/completion/zsh" ]]; then
            cp -r /tmp/docker-cli/contrib/completion/zsh "$HOME/.oh-my-zsh/custom/plugins/zsh-docker-aliases"
            rm -rf /tmp/docker-cli
            print_result $? "zsh-docker-aliases plugin"
        fi
    fi

    print_success "Custom plugins installation completed"
}

# Install custom themes
install_custom_themes() {
    print_info "Installing custom Oh My Zsh themes..."

    # Create custom themes directory if it doesn't exist
    mkdir -p "$HOME/.oh-my-zsh/custom/themes"

    # Install Powerlevel10k theme
    if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" --quiet
        print_result $? "Powerlevel10k theme"
    fi

    # Create Cordya theme if it doesn't exist
    if [[ ! -f "$HOME/.oh-my-zsh/custom/themes/cordya.zsh-theme" ]]; then
        cat > "$HOME/.oh-my-zsh/custom/themes/cordya.zsh-theme" << 'EOL'
# vim:ft=zsh ts=2 sw=2 sts=2
#
# Cordya AI's Theme - https://gist.github.com/cordya-admin/4f7a71211068c1bce53e7d879f39b94c

# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# Make sure you have a recent version: the code points that Powerline
# uses changed in 2012, and older versions will display incorrectly,
# in confusing ways.
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](https://iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# If using with "light" variant of the Solarized color schema, set
# SOLARIZED_THEME variable to "light". If you don't specify, we'll assume
# you're using the "dark" variant.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='INIT'

case ${SOLARIZED_THEME:-dark} in
    light) CURRENT_FG='white';;
    *)     CURRENT_FG='black';;
esac

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR="%{%F{green} \ue0b1%}%{%f "

  fortune | cowsay -t $1 -f eyes

  echo " "
}

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
       return 1
    fi

    # Check if we're already in a virtual environment
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Check if it's the same venv we found
        if [[ "$VIRTUAL_ENV" == "$venv_path" ]]; then
            echo "UV virtual environment already activated: $venv_path"
            return 0
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
        #export PATH="$VIRTUAL_ENV/bin:$PATH"

        #echo "Activated UV virtual environment: $venv_path"
        #echo "  VIRTUAL_ENV: $VIRTUAL_ENV"

        # Display Python version
        # if command -v python &>/dev/null; then
        #     #echo "  Python: $(python --version 2>&1)"
        # fi

        # # Display UV version
        # if command -v uv &>/dev/null; then
        #     #echo "  UV: $(uv --version 2>&1)"
        # fi

        return 0
    else
        echo "Virtual environment found but activation script is missing: $activate_script"
        echo "The environment might be corrupted. Try recreating it with: uv venv"
        return 1
    fi
}

# #==============================================================================
# # Function to automatically activate UV venv when entering a directory
# #==============================================================================

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
                #source "$activate_script" 2>/dev/null

                # Ensure VIRTUAL_ENV is set and exported globally (in case activate script failed)
                if [[ -z "$VIRTUAL_ENV" ]]; then
                    export VIRTUAL_ENV="$venv_path"
                fi
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
# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg


  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'INIT' ]]; then
    echo -n $SEGMENT_SEPARATOR
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  CURRENT_FG=$2

  [[ -n $3 ]] && echo -n "%{$fg%}$3"
  echo -n "%{$bg%}%{$fg%}"
}


# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo ''
  echo -n "%{%f%}%{%b%}%b]"
  CURRENT_BG=''
}


# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols

  symbols="%{%F{white}%}\ue635"

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%} ✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%} ⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%} ⚙"

  [[ -n "$symbols" ]] && prompt_segment NONE default "$symbols"
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#    prompt_segment black magenta "%(!.%{%F{red}%}.)%n in %m"
    prompt_segment NONE magenta "%(!.%{%F{red}%}%n.)%n %{%F{yellow}%}in %{%F{green}%}%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path

   if [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(command git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref="◈ $(command git describe --exact-match --tags HEAD 2> /dev/null)" || \
    ref="➦ $(command git rev-parse --short HEAD 2> /dev/null)"

    if [[ -n $dirty ]]; then
      prompt_segment NONE yellow
    else
      prompt_segment NONE green
    fi

    local ahead behind
    ahead=$(command git log --oneline @{upstream}.. 2>/dev/null)
    behind=$(command git log --oneline ..@{upstream} 2>/dev/null)
    if [[ -n "$ahead" ]] && [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21c5'
    elif [[ -n "$ahead" ]]; then
      PL_BRANCH_CHAR=$'\u21b1'
    elif [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21b0'
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '±'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info

    echo -n "${${ref:gs/%/%%}/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}


# Dir: current working directory
prompt_dir() {
  prompt_segment NONE cyan '%~'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" && -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
    prompt_segment NONE green "(${VIRTUAL_ENV:t:gs/%/%%} - $(python --version 2>&1))"
  fi
}

# Line 329-342: Replace prompt_uv() function with:
prompt_uv() {
  if [[ -n "$VIRTUAL_ENV" && -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
    if command -v uv &>/dev/null; then
      activate_uv_venv
      # Cache version to avoid running uv --version on every prompt
      local uv_version="${UV_VERSION:-$(uv --version 2>&1 | awk '{print $2}')}"
      prompt_segment NONE blue "(UV v${uv_version}: ${VIRTUAL_ENV:t:gs/%/%%} - $(python --version 2>&1 | awk '{print $2}'))"
    else
      prompt_segment NONE blue "(${VIRTUAL_ENV:t:gs/%/%%} - $(python --version 2>&1 | awk '{print $2}'))"
    fi
  fi
}

prompt_conda() {
  [[ -n ${CONDA_DEFAULT_ENV} ]] || return
   prompt_segment NONE green "${ZSH_THEME_CONDA_PREFIX=[}${CONDA_DEFAULT_ENV:t:gs/%/%%}${ZSH_THEME_CONDA_SUFFIX=]}"
}

#AWS Profile:
# - display current AWS_PROFILE name
# - displays yellow on red if profile name contains 'production' or
#   ends in '-prod'
# - displays black on green otherwise
prompt_aws() {
  [[ -z "$AWS_PROFILE" || "$SHOW_AWS_PROMPT" = false ]] && return
  case "$AWS_PROFILE" in
    *-prod|*production*) prompt_segment red yellow  "AWS: ${AWS_PROFILE:gs/%/%%}" ;;
    *) prompt_segment green black "AWS: ${AWS_PROFILE:gs/%/%%}" ;;
  esac
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_uv
  prompt_conda
  prompt_aws
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

EOL
        print_result $? "cordya theme"
    fi
}

# Configure Oh My Zsh
configure_oh_my_zsh() {
    print_info "Configuring Oh My Zsh..."

    # Create a new .zshrc file with our configuration
    cat > "$HOME/.zshrc" << 'EOL'
# #!/bin/zsh

# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# #==============================================================================
# # DOTFILES ZSH CONFIGURATION
# #==============================================================================
# # This is the main .zshrc file that loads all modular configurations from
# # the dotfiles directory. All specific configurations are organized
# # into separate files in ~/dotfiles/zsh_configs/
# #
# # Configuration files are loaded in a specific optimized order to avoid
# # conflicts and ensure proper initialization. The load order is defined in:
# # ~/dotfiles/zsh_configs/00_load_order.zsh
# #
# # Loading sequence:
# # 1. ohmyzsh.zsh     - Oh My Zsh framework and plugins
# # 2. exports.zsh     - General environment variables
# # 3. Language configs - java, python, ruby, rust, go, swift, kotlin, node, etc.
# # 4. Tool configs    - homebrew, xcode, docker, gpg, anthropic, ipfs
# # 5. aliases.zsh     - General aliases (loaded after tools)
# # 6. Cloud configs   - gcloud, conda
# # 7. misc.zsh        - Miscellaneous tools (iTerm2, Jina, Langflow, Kiro, etc.)
# #
# # To modify configurations, edit the appropriate file in:
# # ~/dotfiles/zsh_configs/
# #
# # To disable a configuration, rename it with .disabled extension:
# # mv ~/dotfiles/zsh_configs/something.zsh ~/dotfiles/zsh_configs/something.zsh.disabled
# #==============================================================================

# # Load the load order configuration first
# if [ -f "$HOME/dotfiles/zsh_configs/00_load_order.zsh" ]; then
#     source "$HOME/dotfiles/zsh_configs/00_load_order.zsh"

#     # Load all configurations in the optimized order
#     load_configs_in_order
# else
#     # Fallback: Load Oh My Zsh first, then everything else
#     if [ -f "$HOME/dotfiles/zsh_configs/ohmyzsh.zsh" ]; then
#         source "$HOME/dotfiles/zsh_configs/ohmyzsh.zsh"
#     fi

#     # Load all other modular configurations from jarvistoolset
#     for config_file in "$HOME/dotfiles/zsh_configs/"*.zsh; do
#         # Skip ohmyzsh.zsh and load order as they're already loaded
#         if [[ "$config_file" != *"ohmyzsh.zsh" ]] && \
#            [[ "$config_file" != *"00_load_order.zsh" ]] && \
#            [[ "$config_file" != *"template.zsh" ]] && \
#            [ -f "$config_file" ]; then
#             source "$config_file"
#         fi
#     done
# fi

# #==============================================================================
# # USER CUSTOMIZATIONS
# #==============================================================================
# # Add any personal customizations or overrides below this line
# # These will be loaded after all jarvistoolset configurations
# #==============================================================================


# # Added by LM Studio CLI (lms)
# export PATH="$PATH:/Users/evandroreis/.lmstudio/bin"
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

EOL
    print_result $? "Oh My Zsh configuration"
}

# Main function
main() {
    # Check if script is being run with root privileges
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run with sudo or as root"
        exit 1
    fi

    # Check if Oh My Zsh is already installed
    if check_oh_my_zsh_installed; then
        print_success "Oh My Zsh is already installed"
    else
        install_oh_my_zsh
    fi

    # Install custom plugins and themes
    install_custom_plugins
    install_custom_themes

    # Only configure if the user wants to
    if [[ "$1" == "--configure" ]]; then
        print_info "Configuring Oh My Zsh with default settings"
        configure_oh_my_zsh
        print_success "Oh My Zsh has been configured with default settings"
        print_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
    else
        print_info "Oh My Zsh installation complete"
        print_info "Use --configure flag to overwrite existing .zshrc"
    fi

    return 0
}

# Run the script
main "$@"
