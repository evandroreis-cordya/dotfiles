# Windows-specific PowerShell setup script

param(
    [string]$Hostname = $env:COMPUTERNAME,
    [string]$Username = $env:USERNAME,
    [string]$Email = "evandro.reis@cordya.ai",
    [string]$Directory = "$env:USERPROFILE\dotfiles"
)

# Get the directory of the current script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DotfilesDir = "$env:USERPROFILE\dotfiles"

# Source generic utilities
. "$DotfilesDir\generic\scripts\os\detect_environment.ps1"
. "$DotfilesDir\generic\scripts\os\utils.ps1"
. "$DotfilesDir\generic\scripts\os\logging.ps1"

# Verify we're running on Windows
if ($env:DOTFILES_OS -ne "windows") {
    Write-Error "This script is intended for Windows only. Detected OS: $env:DOTFILES_OS"
    exit 1
}

# Log configuration
Write-LogInfo "Windows setup configuration:"
Write-LogInfo "  Hostname: $Hostname"
Write-LogInfo "  Username: $Username"
Write-LogInfo "  Email: $Email"
Write-LogInfo "  Directory: $Directory"

# Script groups for installation
$ScriptGroups = @{
    "system" = "System Setup (powershell, oh-my-posh, wezterm, chocolatey)"
    "dev_langs" = "Development Languages (python, node, ruby, go, java, kotlin, rust, php, cpp)"
    "data_science" = "Data Science Environment"
    "dev_tools" = "Development Tools (git, docker, vscode, jetbrains, yarn)"
    "web_tools" = "Web and Frontend Tools"
    "daily_tools" = "Daily Tools and Utilities (browsers, compression, misc, office)"
    "media_tools" = "Media and Creative Tools"
    "creative_tools" = "Creative and 3D Design Tools (blender, gimp, inkscape)"
    "cloud_tools" = "Cloud and DevOps Tools"
    "ai_tools" = "AI and Productivity Tools (including Anthropic Libraries and MCP Servers/Clients)"
}

# Default: all groups are selected
$SelectedGroups = @{}
foreach ($group in $ScriptGroups.Keys) {
    $SelectedGroups[$group] = $true
}

# Function to install Chocolatey
function Install-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "`n >> Installing Chocolatey" -ForegroundColor Magenta
        Write-LogInfo "Installing Chocolatey"

        # Install Chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

        if ($LASTEXITCODE -eq 0) {
            Write-LogSuccess "Chocolatey installed successfully"
        } else {
            Write-LogError "Failed to install Chocolatey"
            return $false
        }
    } else {
        Write-LogInfo "Chocolatey is already installed"
    }
    return $true
}

# Function to install WezTerm
function Install-WezTerm {
    if (-not (Get-Command wezterm -ErrorAction SilentlyContinue)) {
        Write-Host "`n >> Installing WezTerm" -ForegroundColor Magenta
        Write-LogInfo "Installing WezTerm"

        # Install WezTerm using winget
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Execute-WithLog "winget install WezFiddle.WezTerm" "Installing WezTerm"
        } else {
            # Fallback to Chocolatey
            Execute-WithLog "choco install wezterm -y" "Installing WezTerm"
        }

        if ($LASTEXITCODE -eq 0) {
            Write-LogSuccess "WezTerm installed successfully"
        } else {
            Write-LogError "Failed to install WezTerm"
            return $false
        }
    } else {
        Write-LogInfo "WezTerm is already installed"
    }
    return $true
}

# Function to install Oh My Posh
function Install-OhMyPosh {
    if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
        Write-Host "`n >> Installing Oh My Posh" -ForegroundColor Magenta
        Write-LogInfo "Installing Oh My Posh"

        # Install Oh My Posh using winget
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Execute-WithLog "winget install JanDeDobbeleer.OhMyPosh" "Installing Oh My Posh"
        } else {
            # Fallback to Chocolatey
            Execute-WithLog "choco install oh-my-posh -y" "Installing Oh My Posh"
        }

        if ($LASTEXITCODE -eq 0) {
            Write-LogSuccess "Oh My Posh installed successfully"
        } else {
            Write-LogError "Failed to install Oh My Posh"
            return $false
        }
    } else {
        Write-LogInfo "Oh My Posh is already installed"
    }
    return $true
}

# Function to install PowerShell modules
function Install-PowerShellModules {
    Write-Host "`n >> Installing PowerShell modules" -ForegroundColor Magenta
    Write-LogInfo "Installing PowerShell modules"

    $modules = @(
        "PSReadLine",
        "PSFzf",
        "posh-git",
        "Terminal-Icons",
        "z"
    )

    foreach ($module in $modules) {
        if (-not (Get-Module -ListAvailable -Name $module)) {
            Execute-WithLog "Install-Module -Name $module -Force -AllowClobber" "Installing $module"
        } else {
            Write-LogInfo "$module is already installed"
        }
    }
}

# Function to configure PowerShell
function Configure-PowerShell {
    Write-Host "`n >> Configuring PowerShell" -ForegroundColor Magenta
    Write-LogInfo "Configuring PowerShell"

    # Create PowerShell profile directory
    $profileDir = Split-Path -Parent $PROFILE
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force
    }

    # Backup existing profile
    if (Test-Path $PROFILE) {
        Copy-Item $PROFILE "$PROFILE.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    }

    # Create PowerShell profile
    $profileContent = @"
# PowerShell Profile for Dotfiles
# Generated on $(Get-Date)

# Import Oh My Posh
Import-Module oh-my-posh

# Set Oh My Posh theme
Set-PoshPrompt -Theme catppuccin_mocha

# Import other modules
Import-Module PSReadLine
Import-Module posh-git
Import-Module Terminal-Icons
Import-Module z

# PSReadLine configuration
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteChar
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Aliases
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String
Set-Alias -Name which -Value Get-Command
Set-Alias -Name cat -Value Get-Content
Set-Alias -Name touch -Value New-Item

# Git aliases
function gs { git status }
function ga { git add }
function gc { git commit }
function gp { git push }
function gl { git pull }
function gd { git diff }
function gb { git branch }
function gco { git checkout }
function gcm { git checkout main }
function gcb { git checkout -b }

# Docker aliases
function d { docker }
function dc { docker-compose }
function dps { docker ps }
function dpsa { docker ps -a }
function di { docker images }
function drm { docker rm }
function drmi { docker rmi }
function dstop { docker stop }
function dstart { docker start }
function drestart { docker restart }
function dlogs { docker logs }
function dexec { docker exec -it }

# Kubernetes aliases
function k { kubectl }
function kg { kubectl get }
function kd { kubectl describe }
function kdel { kubectl delete }
function kapply { kubectl apply }
function klogs { kubectl logs }
function kexec { kubectl exec -it }

# Development aliases
function py { python }
function pip { pip }
function node { node }
function npm { npm }
function yarn { yarn }
function go { go }
function rust { cargo }
function java { java }
function javac { javac }

# Utility functions
function Get-Weather { Invoke-RestMethod "wttr.in" }
function Get-MyIP { Invoke-RestMethod "ipinfo.io/ip" }
function Get-DiskUsage { Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, @{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB,2)}}, @{Name="FreeSpace(GB)";Expression={[math]::Round($_.FreeSpace/1GB,2)}} }
function Get-MemoryUsage { Get-WmiObject -Class Win32_OperatingSystem | Select-Object @{Name="TotalRAM(GB)";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}}, @{Name="FreeRAM(GB)";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}} }

# Load additional configurations
if (Test-Path "$DotfilesDir\windows\configs\shell\*.ps1") {
    Get-ChildItem "$DotfilesDir\windows\configs\shell\*.ps1" | ForEach-Object { . $_.FullName }
}

Write-Host "Dotfiles PowerShell configuration loaded!" -ForegroundColor Green
"@

    Set-Content -Path $PROFILE -Value $profileContent
    Write-LogSuccess "PowerShell configuration completed"
}

# Function to configure WezTerm
function Configure-WezTerm {
    Write-Host "`n >> Configuring WezTerm" -ForegroundColor Magenta
    Write-LogInfo "Configuring WezTerm"

    # Create WezTerm config directory
    $weztermConfigDir = "$env:USERPROFILE\.config\wezterm"
    if (-not (Test-Path $weztermConfigDir)) {
        New-Item -ItemType Directory -Path $weztermConfigDir -Force
    }

    # Create WezTerm configuration
    $weztermConfig = @"
-- WezTerm configuration for Windows
local wezterm = require 'wezterm'

return {
    -- Font configuration
    font = wezterm.font_with_fallback({
        'JetBrains Mono',
        'Fira Code',
        'Cascadia Code',
        'Consolas',
        'Courier New',
    }),
    font_size = 14.0,

    -- Color scheme
    color_scheme = 'Catppuccin Mocha',

    -- Window configuration
    window_background_opacity = 0.95,
    window_decorations = 'RESIZE',
    window_close_confirmation = 'NeverPrompt',

    -- Tab configuration
    use_fancy_tab_bar = true,
    tab_bar_at_bottom = true,
    show_tab_index_in_tab_bar = true,
    show_new_tab_button_in_tab_bar = true,

    -- Key bindings
    keys = {
        {
            key = 'n',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.SpawnTab 'DefaultDomain',
        },
        {
            key = 'w',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.CloseCurrentTab { confirm = false },
        },
        {
            key = 't',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.SpawnTab 'DefaultDomain',
        },
        {
            key = 'Tab',
            mods = 'CTRL',
            action = wezterm.action.ActivateTabRelative(1),
        },
        {
            key = 'Tab',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivateTabRelative(-1),
        },
    },

    -- Default domain
    default_domain = 'DefaultDomain',

    -- Launch menu
    launch_menu = {
        {
            label = 'PowerShell',
            args = { 'powershell.exe', '-NoLogo' },
        },
        {
            label = 'Command Prompt',
            args = { 'cmd.exe' },
        },
        {
            label = 'Git Bash',
            args = { 'C:\Program Files\Git\bin\bash.exe' },
        },
        {
            label = 'WSL Ubuntu',
            args = { 'wsl.exe', '-d', 'Ubuntu' },
        },
    },
}
"@

    Set-Content -Path "$weztermConfigDir\wezterm.lua" -Value $weztermConfig
    Write-LogSuccess "WezTerm configuration completed"
}

# Function to install Windows Subsystem for Linux
function Install-WSL {
    if (-not (Get-Command wsl -ErrorAction SilentlyContinue)) {
        Write-Host "`n >> Installing Windows Subsystem for Linux" -ForegroundColor Magenta
        Write-LogInfo "Installing WSL"

        # Enable WSL feature
        Execute-WithLog "dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart" "Enabling WSL feature"

        # Enable Virtual Machine Platform
        Execute-WithLog "dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart" "Enabling Virtual Machine Platform"

        # Set WSL 2 as default
        Execute-WithLog "wsl --set-default-version 2" "Setting WSL 2 as default"

        # Install Ubuntu
        Execute-WithLog "wsl --install -d Ubuntu" "Installing Ubuntu on WSL"

        Write-LogSuccess "WSL installation completed"
    } else {
        Write-LogInfo "WSL is already installed"
    }
}

# Interactive menu to select script groups
function Select-ScriptGroups {
    Write-Host "`n >> Installation Options" -ForegroundColor Magenta
    Write-Host "Would you like to install the complete toolset or select specific groups?" -ForegroundColor Yellow
    Write-Host "1) Install complete toolset (all groups)" -ForegroundColor Yellow
    Write-Host "2) Select specific groups to install" -ForegroundColor Yellow

    $answer = Read-Host "Enter your choice (1/2)"

    if ($answer -eq "2") {
        # Reset all groups to false
        foreach ($group in $ScriptGroups.Keys) {
            $SelectedGroups[$group] = $false
        }

        Write-Host "`n >> Available groups to install" -ForegroundColor Magenta

        foreach ($group in $ScriptGroups.Keys) {
            $groupAnswer = Read-Host "Install $($ScriptGroups[$group])? (y/n)"
            if ($groupAnswer -match "^[Yy]$") {
                $SelectedGroups[$group] = $true
            } else {
                $SelectedGroups[$group] = $false
            }
        }

        # Summary of selected groups
        Write-Host "`n >> Installation Summary" -ForegroundColor Magenta
        foreach ($group in $ScriptGroups.Keys) {
            if ($SelectedGroups[$group]) {
                Write-Host "Will install: $($ScriptGroups[$group])" -ForegroundColor Green
            } else {
                Write-Host "Will skip...: $($ScriptGroups[$group])" -ForegroundColor Red
            }
        }

        # Confirmation
        $confirmAnswer = Read-Host "`n >> Proceed with installation? (y/n)"

        if ($confirmAnswer -notmatch "^[Yy]$") {
            Write-Host "`n** Installation cancelled by user!!" -ForegroundColor Red
            exit 0
        }
    } else {
        Write-Host "`nInstalling complete toolset (all groups)." -ForegroundColor Green
    }
}

# Main function
function Main {
    Clear-Host

    # Display banner
    Write-Host "`n >> Welcome to Cordya AI Dotfiles 25H1 Edition for Windows" -ForegroundColor Yellow
    Write-Host "Copyright (c) 2025 Cordya AI. All rights reserved." -ForegroundColor Yellow

    # Check if running as administrator
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "`n >> Requesting administrator privileges..." -ForegroundColor Magenta
        Write-Host "Please run this script as Administrator (right-click and 'Run as administrator')" -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
    }

    # Display configuration
    Write-Host "`n >> Starting Dotfiles with the following configuration:" -ForegroundColor Green
    Write-Host "---------------------------------------------------------------" -ForegroundColor Green
    Write-Host "Hostname : $Hostname" -ForegroundColor Green
    Write-Host "Username : $Username" -ForegroundColor Green
    Write-Host "Email    : $Email" -ForegroundColor Green
    Write-Host "Directory: $Directory" -ForegroundColor Green
    Write-Host "---------------------------------------------------------------" -ForegroundColor Green

    # Install system prerequisites
    Install-Chocolatey
    Install-WezTerm
    Install-OhMyPosh
    Install-PowerShellModules
    Install-WSL

    # Configure shell and terminal
    Configure-PowerShell
    Configure-WezTerm

    # Interactive menu to select script groups
    Select-ScriptGroups

    # Create directories
    Create-Directories

    # Install everything based on selected groups
    & "$DotfilesDir\windows\install\main.ps1" -Hostname $Hostname -Username $Username -Email $Email -Directory $Directory

    Write-Host "`n >> Setup completed! Please restart your terminal or run 'refreshenv' to reload environment variables." -ForegroundColor Magenta
}

# Run main function
Main
