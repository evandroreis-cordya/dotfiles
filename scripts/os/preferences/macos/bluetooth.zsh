#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Bluetooth\n\n"

# General Settings
execute "defaults write com.apple.Bluetooth ControllerPowerState -int 1" \
    "Enable Bluetooth"

execute "defaults write com.apple.Bluetooth BluetoothAutoSeekKeyboard -bool true" \
    "Enable automatic keyboard connection"

execute "defaults write com.apple.Bluetooth BluetoothAutoSeekPointingDevice -bool true" \
    "Enable automatic mouse/trackpad connection"

execute "defaults write com.apple.Bluetooth DeviceEnabled -bool true" \
    "Enable Bluetooth device"

execute "defaults write com.apple.Bluetooth DeviceSupportsHandoff -bool true" \
    "Enable device Handoff support"

# Menu Bar and UI Settings
execute "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/Bluetooth.menu'" \
    "Show Bluetooth in menu bar"

execute "defaults write com.apple.controlcenter 'NSStatusItem Visible Bluetooth' -bool true" \
    "Show Bluetooth in Control Center"

execute "defaults write com.apple.Bluetooth ShowInMenuBar -bool true" \
    "Always show Bluetooth in menu bar"

execute "defaults write com.apple.Bluetooth MenuBarShowPercentage -bool true" \
    "Show battery percentage in menu bar"

execute "defaults write com.apple.Bluetooth MenuBarShowRSSI -bool true" \
    "Show signal strength in menu bar"

# Device Connection Settings
execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40" \
    "Set minimum audio quality"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Max (editable)' -int 80" \
    "Set maximum audio quality"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Initial Bitpool (editable)' -int 40" \
    "Set initial audio quality"

execute "defaults write com.apple.BluetoothAudioAgent 'Negotiated Bitpool' -int 58" \
    "Set negotiated audio quality"

execute "defaults write com.apple.Bluetooth AutoConnectAudioDevices -bool true" \
    "Enable automatic audio device connection"

execute "defaults write com.apple.Bluetooth AutoConnectHIDDevices -bool true" \
    "Enable automatic HID device connection"

execute "defaults write com.apple.Bluetooth AutoPairWithAllDevices -bool false" \
    "Disable automatic pairing with all devices"

# Discovery and Visibility Settings
execute "defaults write com.apple.Bluetooth DeviceDiscoverableMode -bool true" \
    "Make device discoverable"

execute "defaults write com.apple.Bluetooth PANDeviceDiscoverableMode -bool true" \
    "Enable PAN device discovery"

execute "defaults write com.apple.Bluetooth DUNDeviceDiscoverableMode -bool false" \
    "Disable DUN device discovery"

execute "defaults write com.apple.Bluetooth DiscoveryTimeout -int 30" \
    "Set discovery timeout to 30 seconds"

execute "defaults write com.apple.Bluetooth TemporaryDiscoverable -bool false" \
    "Disable temporary discoverable mode"

# Power Management Settings
execute "defaults write com.apple.Bluetooth BluetoothPowerOnStartup -bool true" \
    "Enable Bluetooth on startup"

execute "defaults write com.apple.Bluetooth BluetoothAutoSeekHIDDevices -bool true" \
    "Enable automatic HID device connection"

execute "defaults write com.apple.Bluetooth BluetoothPowerOnReconnect -bool true" \
    "Enable Bluetooth power on reconnect"

execute "defaults write com.apple.Bluetooth PowerSavingEnabled -bool true" \
    "Enable power saving mode"

execute "defaults write com.apple.Bluetooth IdleTimeout -int 300" \
    "Set idle timeout to 5 minutes"

# Security Settings
execute "defaults write com.apple.Bluetooth RequireEncryption -bool true" \
    "Require encryption for all connections"

execute "defaults write com.apple.Bluetooth RequireAuthentication -bool true" \
    "Require authentication for all connections"

execute "defaults write com.apple.Bluetooth PINCodeMinimumLength -int 6" \
    "Set minimum PIN code length to 6"

execute "defaults write com.apple.Bluetooth SecurityLevel -int 2" \
    "Set security level to high"

execute "defaults write com.apple.Bluetooth RequireSecureConnections -bool true" \
    "Require secure connections"

# Audio Settings
execute "defaults write com.apple.Bluetooth AAC_ELD_BITRATE_MODE -int 2" \
    "Set AAC-ELD bitrate mode to high quality"

execute "defaults write com.apple.Bluetooth AAC_ELD_BITRATE -int 320" \
    "Set AAC-ELD bitrate to 320kbps"

execute "defaults write com.apple.Bluetooth AAC_ELD_ENABLE -bool true" \
    "Enable AAC-ELD codec"

execute "defaults write com.apple.Bluetooth APTX_ENABLE -bool true" \
    "Enable aptX codec"

execute "defaults write com.apple.Bluetooth LDAC_ENABLE -bool true" \
    "Enable LDAC codec"

# Handoff & Continuity Settings
execute "defaults write com.apple.Bluetooth HandoffEnabled -bool true" \
    "Enable Handoff"

execute "defaults write com.apple.Bluetooth UniversalClipboardEnabled -bool true" \
    "Enable Universal Clipboard"

execute "defaults write com.apple.Bluetooth InstantHotspotEnabled -bool true" \
    "Enable Instant Hotspot"

execute "defaults write com.apple.Bluetooth AirDropEnabled -bool true" \
    "Enable AirDrop"

execute "defaults write com.apple.Bluetooth ContinuitySupport -bool true" \
    "Enable Continuity support"

# Advanced Settings
execute "defaults write com.apple.Bluetooth ExperimentalEnabled -bool false" \
    "Disable experimental features"

execute "defaults write com.apple.Bluetooth FastConnectEnabled -bool true" \
    "Enable fast connect"

execute "defaults write com.apple.Bluetooth LE_STATES -int 15" \
    "Enable all LE states"

execute "defaults write com.apple.Bluetooth MaxConnectedDevices -int 10" \
    "Set maximum connected devices to 10"

execute "defaults write com.apple.Bluetooth CoexEnabled -bool true" \
    "Enable Bluetooth/Wi-Fi coexistence"

# Error Handling Settings
execute "defaults write com.apple.Bluetooth AutoReconnectAttempts -int 5" \
    "Set auto-reconnect attempts to 5"

execute "defaults write com.apple.Bluetooth ConnectionTimeout -int 10" \
    "Set connection timeout to 10 seconds"

execute "defaults write com.apple.Bluetooth ErrorRecoveryEnabled -bool true" \
    "Enable error recovery"

execute "defaults write com.apple.Bluetooth SupervisionTimeout -int 2000" \
    "Set supervision timeout to 2 seconds"

# Restart Bluetooth daemon and services
execute "sudo pkill -9 bluetoothd" \
    "Restart Bluetooth daemon"

execute "sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist DaemonControllersEnabled -bool true" \
    "Enable Bluetooth controllers"

execute "sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist" \
    "Unload Bluetooth daemon"

execute "sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist" \
    "Load Bluetooth daemon"

# Restart affected services
execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "killall ControlCenter" \
    "Restart Control Center"
