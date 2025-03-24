#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Sharing\n\n"

# Computer Name
COMPUTER_NAME="macbook-pro"

execute "sudo scutil --set ComputerName '$COMPUTER_NAME'" \
    "Set computer name"

execute "sudo scutil --set HostName '$COMPUTER_NAME'" \
    "Set host name"

execute "sudo scutil --set LocalHostName '$COMPUTER_NAME'" \
    "Set local host name"

execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string '$COMPUTER_NAME'" \
    "Set NetBIOS name"

# File Sharing
execute "sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist" \
    "Disable AFP file sharing"

execute "sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist" \
    "Disable SMB file sharing"

# Screen Sharing
execute "sudo defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool true" \
    "Disable screen sharing"

# Remote Login (SSH)
execute "sudo systemsetup -setremotelogin off" \
    "Disable remote login"

# Remote Management
execute "sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off" \
    "Disable remote management"

# Remote Apple Events
execute "sudo systemsetup -setremoteappleevents off" \
    "Disable remote Apple events"

# Internet Sharing
execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.nat NAT -dict Enabled -int 0" \
    "Disable Internet sharing"

# Bluetooth Sharing
execute "defaults -currentHost write com.apple.Bluetooth PrefKeyServicesEnabled -bool false" \
    "Disable Bluetooth sharing"

# Media Sharing
execute "launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null" \
    "Disable iTunes sharing"

execute "defaults write com.apple.amp.mediasharingd home-sharing-enabled -bool false" \
    "Disable Home Sharing"

execute "defaults write com.apple.amp.mediasharingd public-sharing-enabled -bool false" \
    "Disable Public Sharing"

# Printer Sharing
execute "cupsctl --no-share-printers" \
    "Disable printer sharing"

execute "cupsctl --no-remote-any" \
    "Disable remote printer administration"

# Content Caching
execute "sudo AssetCacheManagerUtil deactivate" \
    "Disable content caching"

# AirDrop
execute "defaults write com.apple.NetworkBrowser DisableAirDrop -bool true" \
    "Disable AirDrop"

# Handoff
execute "defaults write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool false" \
    "Disable Handoff"

execute "defaults write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool false" \
    "Disable Handoff receiving"

# iCloud Drive
execute "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false" \
    "Disable saving to iCloud by default"

# AirPlay Receiver
execute "defaults write com.apple.controlcenter 'NSStatusItem Visible AirplayReciever' -bool false" \
    "Hide AirPlay Receiver in Control Center"

execute "sudo defaults write /Library/Preferences/com.apple.airplay showInMenuBarIfPresent -bool false" \
    "Hide AirPlay in menu bar"

# Sidecar
execute "defaults write com.apple.sidecar.display AllowAllDevices -bool false" \
    "Disable Sidecar"

execute "defaults write com.apple.sidecar.display hasShownPref -bool true" \
    "Disable Sidecar setup prompt"

# Restart affected services
execute "killall Finder" \
    "Restart Finder"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"

execute "sudo pkill -HUP cupsd" \
    "Restart CUPS daemon"
