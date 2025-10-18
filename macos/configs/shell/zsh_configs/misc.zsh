#!/bin/zsh
#
# Miscellaneous configurations for zsh
# This file contains various initialization scripts and tools
#

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# JINA CLI autocomplete
if [[ -o interactive ]]; then
    compctl -K _jina jina

    _jina() {
      local words completions
      read -cA words

      if [ "${#words}" -eq 2 ]; then
        completions="$(jina commands)"
      else
        completions="$(jina completions ${words[2,-2]})"
      fi

      reply=(${(ps:
:)completions})
    }

    # session-wise fix
    ulimit -n 4096
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
    # default workspace for Executors
    export JINA_DEFAULT_WORKSPACE_BASE="${HOME}/.jina/executor-workspace"
fi

# Docker CLI completions (compinit is already called by Oh My Zsh, just add to fpath)
fpath=($HOME/.docker/completions $fpath)

# Set personal token for GitHub CLI
test -e "${HOME}/.config/op/plugins.sh" && source "${HOME}/.config/op/plugins.sh"

# Kiro shell integration
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# GEMINI_API_KEY - Store securely instead of in .zshrc
# Recommended: Use keychain or separate untracked file
# export GEMINI_API_KEY="your_key_here"

