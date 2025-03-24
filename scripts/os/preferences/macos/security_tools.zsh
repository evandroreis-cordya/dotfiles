#!/bin/zsh

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.zsh"

print_in_purple "\n   Cybersecurity Tools\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Network Security Tools
brew_install "nmap" "Installing Nmap" false

brew_install "wireshark" "Installing Wireshark" true

brew_install "burp-suite" "Installing Burp Suite" true

brew_install "netcat" "Installing Netcat" false

brew_install "tcpdump" "Installing TCPDump" false

# Vulnerability Scanning
brew_install "owasp-zap" "Installing OWASP ZAP" true

brew_install "nikto" "Installing Nikto" false

brew_install "sqlmap" "Installing SQLMap" false

brew_install "metasploit" "Installing Metasploit" true

brew_install "acunetix" "Installing Acunetix" true

# Password and Encryption Tools
brew_install "john-jumbo" "Installing John the Ripper" false

brew_install "hashcat" "Installing Hashcat" false

brew_install "keepassxc" "Installing KeePassXC" true

brew_install "gnupg" "Installing GnuPG" false

brew_install "veracrypt" "Installing VeraCrypt" false

# Forensics Tools
brew_install "autopsy" "Installing Autopsy" true

brew_install "sleuthkit" "Installing The Sleuth Kit" false

brew_install "volatility" "Installing Volatility" false

brew_install "foremost" "Installing Foremost" false

brew_install "scalpel" "Installing Scalpel" false

# Malware Analysis
brew_install "ghidra" "Installing Ghidra" true

brew_install "ida-free" "Installing IDA Free" true

brew_install "cutter" "Installing Cutter" true

brew_install "radare2" "Installing Radare2" false

brew_install "yara" "Installing YARA" false

# AI Security Tools
brew_install "ai-security-copilot" "Installing AI Security Copilot" true

brew_install "deepfence" "Installing Deepfence" true

brew_install "snyk" "Installing Snyk" true

brew_install "security-scorecard" "Installing Security Scorecard" true

brew_install "darktrace" "Installing Darktrace" true

# Threat Intelligence
brew_install "maltego" "Installing Maltego" true

brew_install "misp" "Installing MISP" true

brew_install "osquery" "Installing OSQuery" false

brew_install "yeti" "Installing YETI" false

brew_install "opencti" "Installing OpenCTI" false

# Web Security
brew_install "burp-suite-pro" "Installing Burp Suite Pro" true

brew_install "acunetix" "Installing Acunetix" true

brew_install "netsparker" "Installing Netsparker" true

brew_install "wpscan" "Installing WPScan" false

brew_install "nikto" "Installing Nikto" false

# Cloud Security
brew_install "prisma-cloud" "Installing Prisma Cloud" true

brew_install "wiz" "Installing Wiz" true

brew_install "lacework" "Installing Lacework" true

brew_install "aqua-security" "Installing Aqua Security" true

brew_install "orca-security" "Installing Orca Security" true

# Container Security
brew_install "trivy" "Installing Trivy" false

brew_install "anchore" "Installing Anchore" true

brew_install "twistlock" "Installing Twistlock" true

brew_install "qualys" "Installing Qualys" true

brew_install "snyk-container" "Installing Snyk Container" true

# Security Testing
brew_install "kali-linux" "Installing Kali Linux" true

brew_install "parrot-security" "Installing Parrot Security" true

brew_install "pentestbox" "Installing PentestBox" true

brew_install "blackarch" "Installing BlackArch" true

# AI-Powered Security Analysis
brew_install "vectra-ai" "Installing Vectra AI" true

brew_install "exabeam" "Installing Exabeam" true

brew_install "cybereason" "Installing Cybereason" true

brew_install "crowdstrike" "Installing CrowdStrike" true

brew_install "sentinel-one" "Installing SentinelOne" true

# Security Monitoring
brew_install "splunk" "Installing Splunk" true

brew_install "elastic-security" "Installing Elastic Security" true

brew_install "qradar" "Installing QRadar" true

brew_install "arcsight" "Installing ArcSight" true

brew_install "logrhythm" "Installing LogRhythm" true

# Privacy Tools
brew_install "tor" "Installing Tor" false

brew_install "tails" "Installing Tails" true

brew_install "protonvpn" "Installing ProtonVPN" true

brew_install "mullvadvpn" "Installing Mullvad VPN" true

brew_install "signal" "Installing Signal" true

# Security Development
brew_install "security-code-scan" "Installing Security Code Scan" true

brew_install "checkmarx" "Installing Checkmarx" true

brew_install "fortify" "Installing Fortify" true

brew_install "sonarqube" "Installing SonarQube" true

brew_install "veracode" "Installing Veracode" true
