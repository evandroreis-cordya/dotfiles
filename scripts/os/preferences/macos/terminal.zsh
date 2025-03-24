#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Terminal\n\n"

# General Settings
execute "defaults write com.apple.terminal FocusFollowsMouse -string true" \
    "Enable focus follows mouse"

execute "defaults write com.apple.terminal SecureKeyboardEntry -bool true" \
    "Enable 'Secure Keyboard Entry'"

execute "defaults write com.apple.Terminal ShowLineMarks -int 0" \
    "Hide line marks"

execute "defaults write com.apple.terminal StringEncodings -array 4" \
    "Only use UTF-8"

execute "defaults write com.apple.terminal AutomaticProfileSwitching -bool true" \
    "Enable automatic profile switching"

execute "defaults write com.apple.terminal EnableRendezvous -bool false" \
    "Disable Bonjour advertising"

# Window Settings
execute "defaults write com.apple.terminal 'Default Window Settings' -string 'Pro'" \
    "Set Pro as default window theme"

execute "defaults write com.apple.terminal 'Startup Window Settings' -string 'Pro'" \
    "Set Pro as startup window theme"

execute "defaults write com.apple.terminal NewWindowWorkingDirectoryBehavior -int 1" \
    "Open new windows with default working directory"

execute "defaults write com.apple.terminal WindowRestoration -bool true" \
    "Restore windows on startup"

execute "defaults write com.apple.terminal Shell -string '/usr/local/bin/zsh'" \
    "Set default shell to zsh"

# Text Settings
execute "defaults write com.apple.terminal 'FontAntialias' -bool true" \
    "Enable font anti-aliasing"

execute "defaults write com.apple.terminal 'FontHeightSpacing' -float 1.1" \
    "Set line height spacing"

execute "defaults write com.apple.terminal 'FontWidthSpacing' -float 1.0" \
    "Set character spacing"

execute "defaults write com.apple.terminal 'Bell' -bool false" \
    "Disable audible bell"

execute "defaults write com.apple.terminal 'VisualBell' -bool true" \
    "Enable visual bell"

# Cursor Settings
execute "defaults write com.apple.terminal 'CursorType' -string 'underline'" \
    "Set cursor style to underline"

execute "defaults write com.apple.terminal 'CursorBlink' -bool true" \
    "Enable cursor blinking"

# Selection Settings
execute "defaults write com.apple.terminal SelectionColor -data 62706c6973743030d4010203040506070a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a2080955246e756c6c5f1020636f6d2e6170706c652e74657874656469742e73656c656374696f6e636f6c6f720819" \
    "Set selection color"

execute "defaults write com.apple.terminal MouseWordSelectionStyle -int 1" \
    "Set word selection style"

execute "defaults write com.apple.terminal DoubleClickSelectsWord -bool true" \
    "Double click selects word"

execute "defaults write com.apple.terminal TripleClickSelectsLine -bool true" \
    "Triple click selects line"

# Scrollback Settings
execute "defaults write com.apple.terminal ScrollbackLines -int 50000" \
    "Set scrollback buffer to 50000 lines"

execute "defaults write com.apple.terminal ScrollAlternateScreen -bool true" \
    "Enable alternate screen scrolling"

execute "defaults write com.apple.terminal SaveLines -int 50000" \
    "Save 50000 lines of history"

execute "defaults write com.apple.terminal ScrollPositionBehavior -int 1" \
    "Scroll to bottom on new output"

# Color Settings
execute "defaults write com.apple.terminal 'ANSIBlackColor' -data 62706c6973743030d40102030405060708582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a30809595824636c617373" \
    "Set ANSI black color"

execute "defaults write com.apple.terminal 'ANSIBrightBlackColor' -data 62706c6973743030d40102030405060708582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a30809595824636c617373" \
    "Set ANSI bright black color"

execute "defaults write com.apple.terminal 'TextBoldColor' -data 62706c6973743030d40102030405060708582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a30809595824636c617373" \
    "Set bold text color"

execute "defaults write com.apple.terminal 'TextColor' -data 62706c6973743030d40102030405060708582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a30809595824636c617373" \
    "Set normal text color"

# Tab Settings
execute "defaults write com.apple.terminal TabViewType -int 0" \
    "Set tab view type"

execute "defaults write com.apple.terminal ShowTabBar -bool true" \
    "Show tab bar"

execute "defaults write com.apple.terminal ShowActiveProcessInTitle -bool true" \
    "Show active process in title"

execute "defaults write com.apple.terminal ShowActiveProcessArgumentsInTitle -bool false" \
    "Hide process arguments in title"

execute "defaults write com.apple.terminal ShowRepresentedURLInTitle -bool true" \
    "Show working directory in title"

execute "defaults write com.apple.terminal ShowRepresentedURLPathInTitle -bool false" \
    "Hide full path in title"

# Profile Settings
execute "defaults write com.apple.terminal 'Default Window Settings' -string 'Pro'" \
    "Set Pro as default profile"

execute "defaults write com.apple.terminal 'Startup Window Settings' -string 'Pro'" \
    "Set Pro as startup profile"

execute "defaults write com.apple.terminal ShowActivityIndicatorInDock -bool true" \
    "Show activity indicator in Dock"

execute "defaults write com.apple.terminal ShowDimensionsInTitle -bool false" \
    "Hide dimensions in title"

# Security Settings
execute "defaults write com.apple.terminal SecureKeyboardEntry -bool true" \
    "Enable secure keyboard entry"

execute "defaults write com.apple.terminal AllowClipboardAccess -bool true" \
    "Allow clipboard access"

execute "defaults write com.apple.terminal DisablePromptOnQuit -bool false" \
    "Show prompt on quit"

# Restart Terminal
execute "killall Terminal" \
    "Restart Terminal"
