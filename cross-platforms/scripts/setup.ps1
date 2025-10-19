# Generic PowerShell setup script that detects environment and calls appropriate platform script

param(
    [string]$Hostname = $env:COMPUTERNAME,
    [string]$Username = $env:USERNAME,
    [string]$Email = "evandro.reis@cordya.ai",
    [string]$Directory = "$env:USERPROFILE\dotfiles"
)

# Get the directory of the current script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DotfilesDir = "$env:USERPROFILE\dotfiles"

# Source environment detection
. "$DotfilesDir\cross-platforms\scripts\os\detect_environment.ps1"

# Source utility scripts
. "$DotfilesDir\cross-platforms\scripts\os\utils.ps1" -ErrorAction SilentlyContinue
. "$DotfilesDir\cross-platforms\scripts\os\logging.ps1" -ErrorAction SilentlyContinue

# Log configuration
Write-LogInfo "Generic setup configuration:"
Write-LogInfo "  Hostname: $Hostname"
Write-LogInfo "  Username: $Username"
Write-LogInfo "  Email: $Email"
Write-LogInfo "  Directory: $Directory"
Write-LogInfo "  Detected OS: $env:DOTFILES_OS"

# Function to call platform-specific setup
function Invoke-PlatformSetup {
    param([string]$Platform)

    $setupScript = switch ($Platform) {
        "macos" { "$DotfilesDir\macos\scripts\setup.zsh" }
        "linux" { "$DotfilesDir\linux\scripts\os\setup.zsh" }
        "windows" { "$DotfilesDir\windows\scripts\os\setup.ps1" }
        default {
            Write-Error "Unsupported platform: $Platform"
            Write-LogError "Unsupported platform: $Platform"
            return $false
        }
    }

    if (Test-Path $setupScript) {
        Write-LogInfo "Calling platform-specific setup: $setupScript"

        # Call the platform-specific setup script
        if ($Platform -eq "windows") {
            # For Windows PowerShell scripts
            & $setupScript -Hostname $Hostname -Username $Username -Email $Email -Directory $Directory
        } else {
            # For Unix-like systems (macOS, Linux)
            & $setupScript $Hostname $Username $Email $Directory
        }

        return $LASTEXITCODE
    } else {
        Write-Error "Platform-specific setup script not found: $setupScript"
        Write-LogError "Platform-specific setup script not found: $setupScript"
        return $false
    }
}

# Main function
function Main {
    # Display environment information
    Write-Host "`n >> Environment Detection" -ForegroundColor Magenta
    Write-Host "Detected environment:" -ForegroundColor Yellow
    Write-Host "  OS: $env:DOTFILES_OS" -ForegroundColor Yellow
    Write-Host "  Shell: $env:DOTFILES_SHELL" -ForegroundColor Yellow
    Write-Host "  Package Manager: $env:DOTFILES_PACKAGE_MANAGER" -ForegroundColor Yellow
    Write-Host "  Terminal: $env:DOTFILES_TERMINAL" -ForegroundColor Yellow

    # Verify OS support
    if ($env:DOTFILES_OS -eq "unknown") {
        Write-Error "Unknown operating system detected. This toolset supports macOS, Linux, and Windows."
        Write-LogError "Unknown operating system detected"
        exit 1
    }

    # Call platform-specific setup
    Write-Host "`n >> Starting platform-specific setup for $env:DOTFILES_OS" -ForegroundColor Magenta

    $exitCode = Invoke-PlatformSetup $env:DOTFILES_OS

    if ($exitCode -eq 0) {
        Write-Success "Setup completed successfully for $env:DOTFILES_OS"
        Write-LogSuccess "Setup completed successfully for $env:DOTFILES_OS"
    } else {
        Write-Error "Setup failed for $env:DOTFILES_OS with exit code $exitCode"
        Write-LogError "Setup failed for $env:DOTFILES_OS with exit code $exitCode"
    }

    return $exitCode
}

# Run main function
Main
