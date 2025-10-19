# Windows-specific PowerShell environment detection script

# Function to detect the operating system
function Get-OperatingSystem {
    return "windows"
}

# Function to detect the shell
function Get-Shell {
    if ($PSVersionTable.PSVersion) {
        return "powershell"
    } elseif ($env:SHELL -like "*bash*") {
        return "bash"
    } elseif ($env:SHELL -like "*zsh*") {
        return "zsh"
    } else {
        return "unknown"
    }
}

# Function to detect the package manager
function Get-PackageManager {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        return "winget"
    } elseif (Get-Command choco -ErrorAction SilentlyContinue) {
        return "chocolatey"
    } elseif (Get-Command scoop -ErrorAction SilentlyContinue) {
        return "scoop"
    } else {
        return "winget"
    }
}

# Function to detect the terminal
function Get-Terminal {
    if ($env:WEZTERM_PANE) {
        return "wezterm"
    } elseif ($env:WT_SESSION) {
        return "windows-terminal"
    } elseif ($env:TERM_PROGRAM) {
        return $env:TERM_PROGRAM
    } elseif ($env:TERMINAL_EMULATOR) {
        return $env:TERMINAL_EMULATOR
    } else {
        return "unknown"
    }
}

# Function to detect the architecture
function Get-Architecture {
    return $env:PROCESSOR_ARCHITECTURE
}

# Function to detect Windows version
function Get-WindowsVersion {
    $os = Get-WmiObject -Class Win32_OperatingSystem
    return @{
        "Caption" = $os.Caption
        "Version" = $os.Version
        "BuildNumber" = $os.BuildNumber
        "Architecture" = $os.OSArchitecture
    }
}

# Function to detect PowerShell version
function Get-PowerShellVersion {
    return $PSVersionTable.PSVersion
}

# Function to detect .NET version
function Get-DotNetVersion {
    try {
        $dotnetVersion = dotnet --version
        return $dotnetVersion
    } catch {
        return "not installed"
    }
}

# Function to detect Visual Studio
function Get-VisualStudioVersion {
    $vsInstallations = Get-ChildItem "C:\Program Files*\Microsoft Visual Studio" -ErrorAction SilentlyContinue
    if ($vsInstallations) {
        $versions = @()
        foreach ($installation in $vsInstallations) {
            $versions += $installation.Name
        }
        return $versions -join ", "
    } else {
        return "not installed"
    }
}

# Function to detect WSL
function Get-WSLVersion {
    try {
        $wslVersion = wsl --version
        return "installed"
    } catch {
        return "not installed"
    }
}

# Function to detect Docker
function Get-DockerVersion {
    try {
        $dockerVersion = docker --version
        return $dockerVersion
    } catch {
        return "not installed"
    }
}

# Function to detect Git
function Get-GitVersion {
    try {
        $gitVersion = git --version
        return $gitVersion
    } catch {
        return "not installed"
    }
}

# Function to detect Node.js
function Get-NodeVersion {
    try {
        $nodeVersion = node --version
        return $nodeVersion
    } catch {
        return "not installed"
    }
}

# Function to detect Python
function Get-PythonVersion {
    try {
        $pythonVersion = python --version
        return $pythonVersion
    } catch {
        return "not installed"
    }
}

# Function to detect Java
function Get-JavaVersion {
    try {
        $javaVersion = java -version
        return $javaVersion
    } catch {
        return "not installed"
    }
}

# Function to get environment information
function Get-EnvironmentInfo {
    $os = Get-OperatingSystem
    $shell = Get-Shell
    $packageManager = Get-PackageManager
    $terminal = Get-Terminal
    $architecture = Get-Architecture
    $windowsVersion = Get-WindowsVersion
    $powershellVersion = Get-PowerShellVersion

    return @{
        "OS" = $os
        "Shell" = $shell
        "Package Manager" = $packageManager
        "Terminal" = $terminal
        "Architecture" = $architecture
        "Windows Version" = $windowsVersion.Caption
        "Windows Build" = $windowsVersion.BuildNumber
        "PowerShell Version" = $powershellVersion
        "DotNet Version" = Get-DotNetVersion
        "Visual Studio" = Get-VisualStudioVersion
        "WSL" = Get-WSLVersion
        "Docker" = Get-DockerVersion
        "Git" = Get-GitVersion
        "Node.js" = Get-NodeVersion
        "Python" = Get-PythonVersion
        "Java" = Get-JavaVersion
    }
}

# Export environment variables
$env:DOTFILES_OS = Get-OperatingSystem
$env:DOTFILES_SHELL = Get-Shell
$env:DOTFILES_PACKAGE_MANAGER = Get-PackageManager
$env:DOTFILES_TERMINAL = Get-Terminal
$env:DOTFILES_ARCH = Get-Architecture

# Log environment detection
if (Get-Command Write-LogInfo -ErrorAction SilentlyContinue) {
    Write-LogInfo "Environment detected:"
    Write-LogInfo "  OS: $env:DOTFILES_OS"
    Write-LogInfo "  Shell: $env:DOTFILES_SHELL"
    Write-LogInfo "  Package Manager: $env:DOTFILES_PACKAGE_MANAGER"
    Write-LogInfo "  Terminal: $env:DOTFILES_TERMINAL"
    Write-LogInfo "  Architecture: $env:DOTFILES_ARCH"
}

# Export functions
Export-ModuleMember -Function *
