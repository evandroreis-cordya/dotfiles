#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Siri\n\n"

# Enable/Disable Siri
execute "defaults write com.apple.assistant.support 'Assistant Enabled' -bool false" \
    "Disable Siri"

execute "defaults write com.apple.Siri StatusMenuVisible -bool false" \
    "Hide Siri in menu bar"

# Voice Feedback
execute "defaults write com.apple.Siri VoiceFeedbackEnabled -bool false" \
    "Disable voice feedback"

# Language
execute "defaults write com.apple.Siri Language -string 'en-US'" \
    "Set Siri language to English (US)"

execute "defaults write com.apple.Siri VoiceLanguage -string 'en-US'" \
    "Set Siri voice to English (US)"

# Voice Variety
execute "defaults write com.apple.Siri Voice -string 'Samantha'" \
    "Set Siri voice to Samantha"

# Keyboard Shortcut
execute "defaults write com.apple.Siri HotkeyTag -int 0" \
    "Disable Siri keyboard shortcut"

# Listen for "Hey Siri"
execute "defaults write com.apple.Siri ListenForHeySiri -bool false" \
    "Disable 'Hey Siri'"

execute "defaults write com.apple.Siri ListenForHeySiriEnabled -bool false" \
    "Disable 'Hey Siri' activation"

# Privacy
execute "defaults write com.apple.Siri SiriAnalytics -bool false" \
    "Disable Siri analytics"

execute "defaults write com.apple.Siri SiriDiagnosticsEnabled -bool false" \
    "Disable Siri diagnostics"

execute "defaults write com.apple.Siri SiriImproveEnabled -bool false" \
    "Disable Siri improvements"

# Suggestions
execute "defaults write com.apple.Siri SiriSuggestionsEnabled -bool false" \
    "Disable Siri suggestions"

execute "defaults write com.apple.Siri AppSuggestionsEnabled -bool false" \
    "Disable app suggestions"

execute "defaults write com.apple.Siri ShowSiriSuggestionsInSpotlight -bool false" \
    "Disable Siri suggestions in Spotlight"

execute "defaults write com.apple.Siri ShowSiriSuggestionsInLookup -bool false" \
    "Disable Siri suggestions in Lookup"

# App Support
execute "defaults write com.apple.Siri AppIntegrationEnabled -bool false" \
    "Disable app integration"

execute "defaults write com.apple.Siri AppsEnabled -bool false" \
    "Disable apps support"

# History
execute "defaults write com.apple.Siri HistoryEnabled -bool false" \
    "Disable Siri history"

# Type to Siri
execute "defaults write com.apple.Siri TypeToSiriEnabled -bool false" \
    "Disable Type to Siri"

# Control Center
execute "defaults write com.apple.controlcenter 'NSStatusItem Visible Siri' -bool false" \
    "Hide Siri in Control Center"

# Accessibility
execute "defaults write com.apple.Siri CommandAndControlEnabled -bool false" \
    "Disable Voice Control with Siri"

# Dictation
execute "defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs DictationIMEnabled -bool false" \
    "Disable dictation"

execute "defaults write com.apple.assistant.support 'Dictation Enabled' -bool false" \
    "Disable enhanced dictation"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall ControlCenter" \
    "Restart Control Center"

execute "launchctl unload -w /System/Library/LaunchAgents/com.apple.Siri.agent.plist 2>/dev/null" \
    "Unload Siri agent"
