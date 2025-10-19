#!/bin/zsh
#==============================================================================
# WEZTERM TERMINAL CONFIGURATION
#==============================================================================
# Configuration for WezTerm terminal emulator
# Provides terminal environment setup, themes, and integration
#
# Dependencies: WezTerm terminal emulator
#==============================================================================

# Check if WezTerm is installed
if ! command -v wezterm &> /dev/null; then
    # WezTerm not installed, skip configuration
    return 0
fi

# WezTerm configuration directory
export WEZTERM_CONFIG_DIR="$HOME/.config/wezterm"
export WEZTERM_CONFIG_FILE="$WEZTERM_CONFIG_DIR/wezterm.lua"

# Create WezTerm config directory if it doesn't exist
if [[ ! -d "$WEZTERM_CONFIG_DIR" ]]; then
    mkdir -p "$WEZTERM_CONFIG_DIR"
fi

# WezTerm specific environment variables
export WEZTERM_PROFILE="default"

# WezTerm integration functions
wezterm_theme() {
    # Switch WezTerm theme
    local theme="${1:-default}"
    if [[ -f "$WEZTERM_CONFIG_DIR/themes/${theme}.lua" ]]; then
        echo "Switching to WezTerm theme: $theme"
        # This would require WezTerm config reload
        export WEZTERM_THEME="$theme"
    else
        echo "Theme '$theme' not found in $WEZTERM_CONFIG_DIR/themes/"
        return 1
    fi
}

wezterm_font_size() {
    # Change WezTerm font size
    local size="${1:-12}"
    echo "Setting WezTerm font size to: $size"
    export WEZTERM_FONT_SIZE="$size"
}

wezterm_tab_title() {
    # Set custom tab title
    local title="${1:-}"
    if [[ -n "$title" ]]; then
        echo -e "\033]1337;SetUserVar=tab_title=$title\007"
    fi
}

# WezTerm aliases
alias wt='wezterm'
alias wtt='wezterm connect'
alias wtl='wezterm list'
alias wtc='wezterm cli set-tab-title'
alias wtw='wezterm cli set-window-title'

# WezTerm integration for development
wezterm_dev() {
    # Set up development environment in WezTerm
    wezterm_tab_title "Development"
    export WEZTERM_PROFILE="development"
}

# WezTerm integration for AI/ML work
wezterm_ai() {
    # Set up AI/ML environment in WezTerm
    wezterm_tab_title "AI/ML"
    export WEZTERM_PROFILE="ai-ml"
}

# WezTerm integration for data science
wezterm_data() {
    # Set up data science environment in WezTerm
    wezterm_tab_title "Data Science"
    export WEZTERM_PROFILE="data-science"
}

# WezTerm status bar integration
wezterm_status() {
    # Display WezTerm status information
    echo "WezTerm Configuration:"
    echo "  Config File: $WEZTERM_CONFIG_FILE"
    echo "  Config Dir:  $WEZTERM_CONFIG_DIR"
    echo "  Profile:     $WEZTERM_PROFILE"
    echo "  Theme:       ${WEZTERM_THEME:-default}"
    echo "  Font Size:   ${WEZTERM_FONT_SIZE:-12}"
}

# WezTerm session management
wezterm_sessions() {
    # List active WezTerm sessions
    if command -v wezterm &> /dev/null; then
        wezterm cli list
    else
        echo "WezTerm not available"
    fi
}

# WezTerm window management
wezterm_new_window() {
    # Open new WezTerm window
    if command -v wezterm &> /dev/null; then
        wezterm cli spawn --new-window
    else
        echo "WezTerm not available"
    fi
}

wezterm_new_tab() {
    # Open new WezTerm tab
    if command -v wezterm &> /dev/null; then
        wezterm cli spawn --new-tab
    else
        echo "WezTerm not available"
    fi
}

# WezTerm integration with shell
if [[ -n "$WEZTERM_CONFIG_FILE" ]] && [[ -f "$WEZTERM_CONFIG_FILE" ]]; then
    # WezTerm config is available
    export WEZTERM_AVAILABLE=true
else
    # WezTerm config not found, but binary might be available
    export WEZTERM_AVAILABLE=false
fi

# WezTerm color scheme integration
if [[ -n "$WEZTERM_THEME" ]]; then
    export WEZTERM_THEME_ACTIVE="$WEZTERM_THEME"
else
    export WEZTERM_THEME_ACTIVE="default"
fi

# WezTerm font configuration
if [[ -n "$WEZTERM_FONT_SIZE" ]]; then
    export WEZTERM_FONT_SIZE_ACTIVE="$WEZTERM_FONT_SIZE"
else
    export WEZTERM_FONT_SIZE_ACTIVE="12"
fi

# WezTerm development helpers
wezterm_reload() {
    # Reload WezTerm configuration
    if command -v wezterm &> /dev/null; then
        wezterm cli reload-config
        echo "WezTerm configuration reloaded"
    else
        echo "WezTerm not available"
    fi
}

# WezTerm debugging
wezterm_debug() {
    # Show WezTerm debug information
    echo "WezTerm Debug Information:"
    echo "  Binary: $(which wezterm 2>/dev/null || echo 'Not found')"
    echo "  Config: $WEZTERM_CONFIG_FILE"
    echo "  Available: $WEZTERM_AVAILABLE"
    echo "  Profile: $WEZTERM_PROFILE"
    echo "  Theme: $WEZTERM_THEME_ACTIVE"
    echo "  Font Size: $WEZTERM_FONT_SIZE_ACTIVE"
}

# WezTerm integration complete
if [[ "$WEZTERM_AVAILABLE" == "true" ]]; then
    # WezTerm is properly configured
    export WEZTERM_INTEGRATION="active"
else
    # WezTerm integration limited
    export WEZTERM_INTEGRATION="limited"
fi
