# Windows-specific PowerShell utility functions

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
    return "windows"
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

    if (Test-CommandExists "winget") {
        winget install $Package
    } elseif (Test-CommandExists "choco") {
        choco install $Package -y
    } else {
        Write-Error "No package manager found. Please install winget or chocolatey first."
        return $false
    }
}

# Function to check if running as administrator
function Test-IsAdministrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to ask for administrator privileges
function Request-AdministratorPrivileges {
    if (-not (Test-IsAdministrator)) {
        Write-Host "Please run this script as Administrator (right-click and 'Run as administrator')" -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
    }
}

# Function to execute command with logging
function Execute-WithLog {
    param([string]$Command, [string]$Message = $Command)

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
    param([string]$Host, [int]$Port, [int]$TimeoutSeconds = 30, [int]$IntervalSeconds = 1)

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
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $computer = Get-WmiObject -Class Win32_ComputerSystem
    $processor = Get-WmiObject -Class Win32_Processor

    return @{
        "Operating System" = "$($os.Caption) $($os.Version)"
        "Architecture" = $env:PROCESSOR_ARCHITECTURE
        "Computer Name" = $env:COMPUTERNAME
        "User Name" = $env:USERNAME
        "Total RAM" = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
        "Processor" = $processor.Name
        "PowerShell Version" = $PSVersionTable.PSVersion
    }
}

# Function to get Windows version
function Get-WindowsVersion {
    $os = Get-WmiObject -Class Win32_OperatingSystem
    return @{
        "Caption" = $os.Caption
        "Version" = $os.Version
        "BuildNumber" = $os.BuildNumber
        "Architecture" = $os.OSArchitecture
    }
}

# Function to enable Windows features
function Enable-WindowsFeature {
    param([string]$FeatureName)

    try {
        Enable-WindowsOptionalFeature -Online -FeatureName $FeatureName -All -NoRestart
        return $true
    } catch {
        Write-Error "Failed to enable Windows feature: $FeatureName"
        Write-Error $_.Exception.Message
        return $false
    }
}

# Function to install Windows updates
function Install-WindowsUpdates {
    try {
        $updates = Get-WindowsUpdate
        if ($updates.Count -gt 0) {
            Install-WindowsUpdate -AcceptAll -AutoReboot
            return $true
        } else {
            Write-LogInfo "No Windows updates available"
            return $true
        }
    } catch {
        Write-Error "Failed to install Windows updates"
        Write-Error $_.Exception.Message
        return $false
    }
}

# Function to set environment variable
function Set-EnvironmentVariable {
    param([string]$Name, [string]$Value, [bool]$User = $true)

    try {
        if ($User) {
            [Environment]::SetEnvironmentVariable($Name, $Value, "User")
        } else {
            [Environment]::SetEnvironmentVariable($Name, $Value, "Machine")
        }
        Write-LogInfo "Set environment variable: $Name = $Value"
        return $true
    } catch {
        Write-Error "Failed to set environment variable: $Name"
        Write-Error $_.Exception.Message
        return $false
    }
}

# Function to get environment variable
function Get-EnvironmentVariable {
    param([string]$Name, [bool]$User = $true)

    try {
        if ($User) {
            return [Environment]::GetEnvironmentVariable($Name, "User")
        } else {
            return [Environment]::GetEnvironmentVariable($Name, "Machine")
        }
    } catch {
        Write-Error "Failed to get environment variable: $Name"
        return $null
    }
}

# Function to refresh environment variables
function Refresh-Environment {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Function to get installed programs
function Get-InstalledPrograms {
    $programs = Get-WmiObject -Class Win32_Product | Select-Object Name, Version, Vendor
    return $programs
}

# Function to uninstall program
function Uninstall-Program {
    param([string]$ProgramName)

    try {
        $program = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*$ProgramName*" }
        if ($program) {
            $program.Uninstall()
            Write-LogInfo "Uninstalled program: $ProgramName"
            return $true
        } else {
            Write-LogInfo "Program not found: $ProgramName"
            return $false
        }
    } catch {
        Write-Error "Failed to uninstall program: $ProgramName"
        Write-Error $_.Exception.Message
        return $false
    }
}

# Function to get network information
function Get-NetworkInfo {
    $adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    $ipConfig = Get-NetIPConfiguration

    return @{
        "Adapters" = $adapters
        "IP Configuration" = $ipConfig
    }
}

# Function to get disk information
function Get-DiskInfo {
    $disks = Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, @{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB,2)}}, @{Name="FreeSpace(GB)";Expression={[math]::Round($_.FreeSpace/1GB,2)}}, @{Name="UsedSpace(GB)";Expression={[math]::Round(($_.Size-$_.FreeSpace)/1GB,2)}}
    return $disks
}

# Function to get memory information
function Get-MemoryInfo {
    $memory = Get-WmiObject -Class Win32_OperatingSystem | Select-Object @{Name="TotalRAM(GB)";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}}, @{Name="FreeRAM(GB)";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}}, @{Name="UsedRAM(GB)";Expression={[math]::Round(($_.TotalVisibleMemorySize-$_.FreePhysicalMemory)/1MB,2)}}
    return $memory
}

# Export functions
Export-ModuleMember -Function *
