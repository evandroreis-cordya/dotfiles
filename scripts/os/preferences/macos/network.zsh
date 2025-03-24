#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Network\n\n"

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

# Network Discovery
execute "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true" \
    "Enable network file browsing"

execute "defaults write com.apple.NetworkBrowser ShowThisComputer -bool true" \
    "Show this computer on the network"

execute "defaults write com.apple.NetworkBrowser EnableODiskBrowsing -bool true" \
    "Enable optical disk sharing"

execute "defaults write com.apple.NetworkBrowser EnableLegacyAFPClient -bool false" \
    "Disable legacy AFP client"

# AirDrop
execute "defaults write com.apple.NetworkBrowser DisableAirDrop -bool false" \
    "Enable AirDrop"

execute "defaults write com.apple.sharingd DiscoverableMode -string 'Contacts Only'" \
    "Set AirDrop discovery to Contacts Only"

# Wi-Fi
execute "networksetup -setairportpower en0 on" \
    "Enable Wi-Fi"

execute "networksetup -setv6automatic Wi-Fi" \
    "Enable automatic IPv6 configuration"

execute "networksetup -setnetworkserviceenabled Wi-Fi on" \
    "Enable Wi-Fi network service"

# DNS
execute "networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4" \
    "Set DNS servers to Cloudflare and Google DNS"

execute "networksetup -setdnssearchdomains Wi-Fi empty" \
    "Clear DNS search domains"

# Firewall
execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on" \
    "Enable firewall"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on" \
    "Enable firewall logging"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on" \
    "Enable stealth mode"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on" \
    "Allow signed apps through firewall"

execute "sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp on" \
    "Allow signed app downloads through firewall"

# Captive Portal
execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false" \
    "Disable captive portal"

# Network Services
# List of common network services to disable if not needed
NETWORK_SERVICES=(
    "com.apple.NetworkBrowser"              # Network browser
    "com.apple.amp.mediasharingd"          # Media sharing
    "com.apple.preferences.sharing.SharingPrefsExtension" # Sharing preferences
    "com.apple.amp.mediaremoted"           # Media remote
    "com.apple.geod"                       # Location services
    "com.apple.gamed"                      # Game Center
)

for service in $NETWORK_SERVICES; do
    execute "launchctl unload -w /System/Library/LaunchAgents/$service.plist 2>/dev/null" \
        "Disable $service"
done

# Network Privacy
execute "defaults write com.apple.safari SendDoNotTrackHTTPHeader -bool true" \
    "Enable Do Not Track in Safari"

execute "defaults write com.apple.AdLib forceLimitAdTracking -bool true" \
    "Limit ad tracking"

execute "defaults write com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -bool false" \
    "Disable Private Click Measurement"

execute "defaults write com.apple.Safari WebKitPreferences.dntHeaderEnabled -bool true" \
    "Enable Do Not Track header"

# Network Performance
execute "networksetup -setv6off Wi-Fi" \
    "Disable IPv6 on Wi-Fi"

execute "sudo sysctl -w net.inet.tcp.delayed_ack=0" \
    "Disable delayed ACK for better TCP performance"

execute "sudo sysctl -w net.inet.tcp.mssdflt=1440" \
    "Set default TCP MSS to 1440 for better compatibility"

execute "sudo sysctl -w net.inet.tcp.blackhole=2" \
    "Enable TCP blackhole"

execute "sudo sysctl -w net.inet.udp.blackhole=1" \
    "Enable UDP blackhole"

execute "sudo sysctl -w net.inet.icmp.icmplim=50" \
    "Set ICMP rate limit"

# Network Security
execute "defaults write com.apple.sharing AllowWindowsSharing -bool false" \
    "Disable Windows File Sharing"

execute "defaults write com.apple.sharing AllowGuestAccess -bool false" \
    "Disable guest access for sharing"

execute "defaults write com.apple.sharing DVDorCDSharing -bool false" \
    "Disable DVD or CD Sharing"

execute "defaults write com.apple.sharing BluetoothSharing -bool false" \
    "Disable Bluetooth Sharing"

execute "defaults write com.apple.sharing InternetSharing -bool false" \
    "Disable Internet Sharing"

execute "defaults write com.apple.sharing RemoteLogin -bool false" \
    "Disable Remote Login"

execute "defaults write com.apple.sharing RemoteManagement -bool false" \
    "Disable Remote Management"

# VPN Settings
execute "defaults write com.apple.networkextension VPNLoggingEnabled -bool true" \
    "Enable VPN logging"

execute "defaults write com.apple.networkextension VPNShowStatus -bool true" \
    "Show VPN status in menu bar"

# Proxy Settings
execute "networksetup -setproxyautodiscovery Wi-Fi off" \
    "Disable proxy auto-discovery"

execute "networksetup -setautoproxystate Wi-Fi off" \
    "Disable auto proxy configuration"

# Restart affected services
execute "sudo killall -HUP mDNSResponder" \
    "Flush DNS cache"

execute "sudo killall -HUP mDNSResponderHelper" \
    "Restart mDNS helper"

execute "sudo pfctl -F all -f /etc/pf.conf" \
    "Reload packet filter rules"

execute "killall SystemUIServer" \
    "Restart SystemUIServer"
