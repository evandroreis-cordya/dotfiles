#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Sound\n\n"

# Alert Sound Settings
execute "defaults write NSGlobalDomain com.apple.sound.beep.sound -string '/System/Library/Sounds/Funk.aiff'" \
    "Set alert sound to Funk"

execute "defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.6" \
    "Set alert sound volume to 60%"

execute "defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false" \
    "Disable feedback when volume is changed"

execute "defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false" \
    "Disable screen flash on alert"

execute "defaults write NSGlobalDomain com.apple.sound.beep.repeat -bool false" \
    "Disable alert sound repetition"

# User Interface Sound Effects
execute "defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool false" \
    "Disable user interface sound effects"

execute "defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -bool false" \
    "Disable additional user interface sound effects"

execute "defaults write NSGlobalDomain com.apple.sound.uiaudio.volume -float 0.0" \
    "Set UI sound effects volume to 0"

# Startup Sound
execute "sudo nvram SystemAudioVolume='%00'" \
    "Disable startup sound"

execute "sudo nvram StartupMute=%01" \
    "Mute startup sound (alternative method)"

execute "sudo nvram SystemAudioVolumeDB='%80'" \
    "Set startup volume to minimum"

# Sound Output Settings
execute "defaults write com.apple.audio.AudioMIDISetup 'Default Output Device' -string 'Built-in Output'" \
    "Set default output device to Built-in Output"

execute "osascript -e 'set volume output volume 50'" \
    "Set output volume to 50%"

execute "osascript -e 'set volume alert volume 50'" \
    "Set alert volume to 50%"

execute "defaults write com.apple.audio.AudioMIDISetup 'Output Format' -string '44100'" \
    "Set output format to 44.1kHz"

execute "defaults write com.apple.audio.AudioMIDISetup 'Output Bit Depth' -string '24-bit'" \
    "Set output bit depth to 24-bit"

# Sound Input Settings
execute "defaults write com.apple.audio.AudioMIDISetup 'Default Input Device' -string 'Built-in Microphone'" \
    "Set default input device to Built-in Microphone"

execute "osascript -e 'set volume input volume 75'" \
    "Set input volume to 75%"

execute "defaults write com.apple.audio.AudioMIDISetup 'Input Format' -string '44100'" \
    "Set input format to 44.1kHz"

execute "defaults write com.apple.audio.AudioMIDISetup 'Input Bit Depth' -string '24-bit'" \
    "Set input bit depth to 24-bit"

# Menu Bar Settings
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/Volume.menu'" \
    "Show volume in menu bar"

execute "defaults write com.apple.controlcenter 'NSStatusItem Visible Sound' -bool true" \
    "Show sound in Control Center"

execute "defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.volume' -bool true" \
    "Keep volume visible in menu bar"

# Sound Effects Settings
execute "defaults write NSGlobalDomain com.apple.sound.play-user-interface-sound-effects -bool false" \
    "Disable interface sound effects"

execute "defaults write NSGlobalDomain com.apple.sound.play-feedback-whoosh -bool false" \
    "Disable whoosh sound effect"

execute "defaults write com.apple.finder FinderSounds -bool false" \
    "Disable Finder sounds"

execute "defaults write com.apple.dock no-bouncing -bool true" \
    "Disable Dock bounce sound"

execute "defaults write com.apple.systemsound 'com.apple.sound.selection' -bool false" \
    "Disable selection sound effect"

execute "defaults write com.apple.systemsound 'com.apple.sound.dragdrop' -bool false" \
    "Disable drag and drop sound effect"

# Audio Device Settings
execute "defaults write com.apple.audio.AudioMIDISetup 'Automatic Gain Control' -bool true" \
    "Enable automatic gain control"

execute "defaults write com.apple.audio.AudioMIDISetup 'Ambient Noise Reduction' -bool true" \
    "Enable ambient noise reduction"

execute "defaults write com.apple.audio.AudioMIDISetup 'Echo Cancellation' -bool true" \
    "Enable echo cancellation"

execute "defaults write com.apple.audio.AudioMIDISetup 'Noise Suppression' -bool true" \
    "Enable noise suppression"

# AirPods Settings
execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40" \
    "Set AirPods audio quality minimum"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Initial Bitpool (editable)' -int 40" \
    "Set AirPods initial audio quality"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Max (editable)' -int 80" \
    "Set AirPods maximum audio quality"

execute "defaults write com.apple.BluetoothAudioAgent 'Negotiated Bitpool' -int 58" \
    "Set AirPods negotiated audio quality"

execute "defaults write com.apple.BluetoothAudioAgent 'Enable AAC codec' -bool true" \
    "Enable AAC codec for AirPods"

execute "defaults write com.apple.BluetoothAudioAgent 'Enable Adaptive Bitpool' -bool true" \
    "Enable adaptive bitpool for AirPods"

# Sound Balance Settings
execute "defaults write com.apple.audio.AudioMIDISetup 'Master Balance' -float 0.5" \
    "Set master balance to center"

execute "defaults write com.apple.audio.AudioMIDISetup 'Left/Right Balance' -float 0.5" \
    "Set left/right balance to center"

# Audio Enhancement Settings
execute "defaults write com.apple.audio.AudioMIDISetup 'Sound Enhancement' -bool true" \
    "Enable sound enhancement"

execute "defaults write com.apple.audio.AudioMIDISetup 'Bass Boost' -bool false" \
    "Disable bass boost"

execute "defaults write com.apple.audio.AudioMIDISetup 'Virtual Surround' -bool false" \
    "Disable virtual surround"

# Audio Routing Settings
execute "defaults write com.apple.audio.AudioMIDISetup 'Automatic Device Switching' -bool true" \
    "Enable automatic device switching"

execute "defaults write com.apple.audio.AudioMIDISetup 'Automatic Input Switching' -bool true" \
    "Enable automatic input switching"

execute "defaults write com.apple.audio.AudioMIDISetup 'Automatic Output Switching' -bool true" \
    "Enable automatic output switching"

# Restart affected services
execute "sudo killall coreaudiod" \
    "Restart Core Audio daemon"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall ControlCenter" \
    "Restart Control Center"
