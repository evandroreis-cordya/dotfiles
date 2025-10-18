# Generic PowerShell environment detection script for multi-platform support

# Function to detect the operating system
function Get-OperatingSystem {
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
    $os = Get-OperatingSystem

    switch ($os) {
        "macos" {
            if (Get-Command brew -ErrorAction SilentlyContinue) {
                return "homebrew"
            } else {
                return "homebrew"
            }
        }
        "linux" {
            if (Get-Command apt -ErrorAction SilentlyContinue) {
                return "apt"
            } elseif (Get-Command yum -ErrorAction SilentlyContinue) {
                return "yum"
            } elseif (Get-Command dnf -ErrorAction SilentlyContinue) {
                return "dnf"
            } elseif (Get-Command pacman -ErrorAction SilentlyContinue) {
                return "pacman"
            } elseif (Get-Command zypper -ErrorAction SilentlyContinue) {
                return "zypper"
            } else {
                return "unknown"
            }
        }
        "windows" {
            if (Get-Command winget -ErrorAction SilentlyContinue) {
                return "winget"
            } elseif (Get-Command choco -ErrorAction SilentlyContinue) {
                return "chocolatey"
            } else {
                return "winget"
            }
        }
        default {
            return "unknown"
        }
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
    if ($IsWindows) {
        return $env:PROCESSOR_ARCHITECTURE
    } elseif ($IsLinux -or $IsMacOS) {
        return (uname -m)
    } else {
        return "unknown"
    }
}

# Function to get environment information
function Get-EnvironmentInfo {
    $os = Get-OperatingSystem
    $shell = Get-Shell
    $packageManager = Get-PackageManager
    $terminal = Get-Terminal
    $architecture = Get-Architecture

    $info = @{
        "OS" = $os
        "Shell" = $shell
        "Package Manager" = $packageManager
        "Terminal" = $terminal
        "Architecture" = $architecture
    }

    # OS-specific information
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

# Export environment variables
$env:JARVIS_OS = Get-OperatingSystem
$env:JARVIS_SHELL = Get-Shell
$env:JARVIS_PACKAGE_MANAGER = Get-PackageManager
$env:JARVIS_TERMINAL = Get-Terminal
$env:JARVIS_ARCH = Get-Architecture

# Log environment detection
if (Get-Command Write-LogInfo -ErrorAction SilentlyContinue) {
    Write-LogInfo "Environment detected:"
    Write-LogInfo "  OS: $env:JARVIS_OS"
    Write-LogInfo "  Shell: $env:JARVIS_SHELL"
    Write-LogInfo "  Package Manager: $env:JARVIS_PACKAGE_MANAGER"
    Write-LogInfo "  Terminal: $env:JARVIS_TERMINAL"
    Write-LogInfo "  Architecture: $env:JARVIS_ARCH"
}

# Export functions
Export-ModuleMember -Function *
