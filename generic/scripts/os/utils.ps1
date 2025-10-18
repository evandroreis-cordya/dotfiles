# Generic PowerShell utility functions for multi-platform support

# Color output functions
function Write-InYellow {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Yellow
}

function Write-InGreen {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Green
}

function Write-InRed {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Red
}

function Write-InPurple {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Magenta
}

function Write-Error {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Result {
    param([int]$ExitCode, [string]$Message)
    if ($ExitCode -eq 0) {
        Write-Success $Message
    } else {
        Write-Error $Message
    }
}

# Function to check if a command exists
function Test-CommandExists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# Function to get the operating system
function Get-OS {
    if ($IsWindows) {
        return "windows"
    } elseif ($IsLinux) {
        return "linux"
    } elseif ($IsMacOS) {
        return "macos"
    } else {
        return "unknown"
    }
}

# Function to get the architecture
function Get-Architecture {
    return $env:PROCESSOR_ARCHITECTURE
}

# Function to create directories
function Create-Directories {
    $dirs = @(
        "$env:USERPROFILE\.config",
        "$env:USERPROFILE\.local\bin",
        "$env:USERPROFILE\.local\share",
        "$env:USERPROFILE\.cache",
        "$env:USERPROFILE\.logs"
    )

    foreach ($dir in $dirs) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-LogInfo "Created directory: $dir"
        }
    }
}

# Function to backup existing files
function Backup-File {
    param([string]$FilePath)
    $backupDir = "$env:USERPROFILE\.jarvistoolset\backups"

    if (Test-Path $FilePath) {
        if (-not (Test-Path $backupDir)) {
            New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        }
        $backupFile = "$backupDir\$(Split-Path $FilePath -Leaf).$(Get-Date -Format 'yyyyMMdd_HHmmss').bak"
        Copy-Item $FilePath $backupFile
        Write-LogInfo "Backed up $FilePath to $backupFile"
    }
}

# Function to create symbolic link
function New-Symlink {
    param([string]$Source, [string]$Target)

    if (Test-Path $Target) {
        if ((Get-Item $Target).LinkType -eq "SymbolicLink") {
            Remove-Item $Target
        } else {
            Backup-File $Target
            Remove-Item $Target
        }
    }

    New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
    Write-LogInfo "Created symbolic link: $Target -> $Source"
}

# Function to install package using platform-specific package manager
function Install-Package {
    param([string]$Package)
    $os = Get-OS

    switch ($os) {
        "macos" {
            if (Test-CommandExists "brew") {
                brew install $Package
            } else {
                Write-Error "Homebrew not found. Please install Homebrew first."
                return $false
            }
        }
        "linux" {
            $packageManager = $env:JARVIS_PACKAGE_MANAGER
            switch ($packageManager) {
                "apt" { sudo apt update; sudo apt install -y $Package }
                "yum" { sudo yum install -y $Package }
                "dnf" { sudo dnf install -y $Package }
                "pacman" { sudo pacman -S --noconfirm $Package }
                "zypper" { sudo zypper install -y $Package }
                default {
                    Write-Error "Unsupported package manager: $packageManager"
                    return $false
                }
            }
        }
        "windows" {
            if (Test-CommandExists "winget") {
                winget install $Package
            } elseif (Test-CommandExists "choco") {
                choco install $Package -y
            } else {
                Write-Error "No package manager found. Please install winget or chocolatey first."
                return $false
            }
        }
        default {
            Write-Error "Unsupported operating system: $os"
            return $false
        }
    }
}

# Function to check if running as root/admin
function Test-IsRoot {
    if ($IsWindows) {
        # Check if running as administrator on Windows
        $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
        return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    } else {
        # Check if running as root on Unix-like systems
        return $env:USER -eq "root"
    }
}

# Function to ask for sudo/admin privileges
function Request-SudoPrivileges {
    if (-not (Test-IsRoot)) {
        if ($IsWindows) {
            Write-Host "Please run this script as Administrator (right-click and 'Run as administrator')" -ForegroundColor Yellow
        } else {
            Write-Host "Please enter your password for sudo access:" -ForegroundColor Yellow
            sudo -v
        }
    }
}

# Function to execute command with logging
function Execute-WithLog {
    param(
        [string]$Command,
        [string]$Message = $Command
    )

    Write-InYellow "   $Message..."

    try {
        Invoke-Expression $Command
        $exitCode = $LASTEXITCODE
        Write-Result $exitCode $Message
        return $exitCode
    } catch {
        Write-Error "Command failed: $Message"
        Write-Error $_.Exception.Message
        return 1
    }
}

# Function to download file
function Get-File {
    param([string]$Url, [string]$OutputPath)

    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath
        return $true
    } catch {
        Write-Error "Failed to download $Url to $OutputPath"
        Write-Error $_.Exception.Message
        return $false
    }
}

# Function to extract archive
function Expand-Archive {
    param([string]$ArchivePath, [string]$DestinationPath = ".")

    try {
        Expand-Archive -Path $ArchivePath -DestinationPath $DestinationPath -Force
        return $true
    } catch {
        Write-Error "Failed to extract $ArchivePath to $DestinationPath"
        Write-Error $_.Exception.Message
        return $false
    }
}

# Function to get latest release from GitHub
function Get-LatestRelease {
    param([string]$Repository)
    $url = "https://api.github.com/repos/$Repository/releases/latest"

    try {
        $response = Invoke-RestMethod -Uri $url
        return $response.tag_name
    } catch {
        Write-Error "Failed to get latest release for $Repository"
        Write-Error $_.Exception.Message
        return $null
    }
}

# Function to check if a port is in use
function Test-PortInUse {
    param([int]$Port)

    try {
        $connection = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
        return $null -ne $connection
    } catch {
        return $false
    }
}

# Function to wait for a service to be ready
function Wait-ForService {
    param(
        [string]$Host,
        [int]$Port,
        [int]$TimeoutSeconds = 30,
        [int]$IntervalSeconds = 1
    )

    $endTime = (Get-Date).AddSeconds($TimeoutSeconds)

    while ((Get-Date) -lt $endTime) {
        try {
            $tcpClient = New-Object System.Net.Sockets.TcpClient
            $tcpClient.Connect($Host, $Port)
            $tcpClient.Close()
            return $true
        } catch {
            Start-Sleep -Seconds $IntervalSeconds
        }
    }

    return $false
}

# Function to get system information
function Get-SystemInfo {
    $os = Get-OS
    $arch = Get-Architecture

    $info = @{
        "Operating System" = $os
        "Architecture" = $arch
        "Shell" = $env:JARVIS_SHELL
        "Package Manager" = $env:JARVIS_PACKAGE_MANAGER
        "Terminal" = $env:JARVIS_TERMINAL
    }

    switch ($os) {
        "macos" {
            $info["macOS Version"] = (sw_vers -productVersion)
        }
        "linux" {
            if (Test-Path "/etc/os-release") {
                $osRelease = Get-Content "/etc/os-release" | ConvertFrom-StringData
                $info["Distribution"] = "$($osRelease.NAME) $($osRelease.VERSION)"
            }
        }
        "windows" {
            $os = Get-WmiObject -Class Win32_OperatingSystem
            $info["Windows Version"] = "$($os.Caption) $($os.Version)"
        }
    }

    return $info
}

# Export functions
Export-ModuleMember -Function *
