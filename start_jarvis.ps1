# Windows PowerShell entry script for Jarvis Toolset

param(
    [string]$Hostname = $env:COMPUTERNAME,
    [string]$Username = $env:USERNAME,
    [string]$Email = "evandro.reis@arvos.ai",
    [string]$Directory = "$env:USERPROFILE\.jarvistoolset"
)

# Get the directory of the current script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$JarvisDir = "$env:USERPROFILE\.jarvistoolset"

# Define paths to scripts
$UtilsScript = "$JarvisDir\generic\scripts\os\utils.ps1"
$LoggingScript = "$JarvisDir\generic\scripts\os\logging.ps1"
$SetupScript = "$JarvisDir\generic\scripts\os\setup.ps1"

# Define the logs directory
$LogsDir = "$env:USERPROFILE\.jarvistoolset\logs"

# Ensure logs directory exists
if (-not (Test-Path $LogsDir)) {
    New-Item -ItemType Directory -Path $LogsDir -Force | Out-Null
}

# Source utility scripts if they exist
if (Test-Path $UtilsScript) {
    . $UtilsScript
}

if (Test-Path $LoggingScript) {
    . $LoggingScript
}

# Initialize logging
Initialize-Logging

# Log system information
Write-LogSystemInfo

# Log start of Jarvis Toolset
Write-LogInfo "Starting Jarvis Toolset"

# Check if the first argument is "/help"
if ($args[0] -eq "/help") {
    # Path to README.md
    $ReadmePath = "$JarvisDir\README.md"

    # Verify README.md exists
    if (-not (Test-Path $ReadmePath)) {
        Write-Error "README.md not found at $ReadmePath"
        Write-LogError "README.md not found at $ReadmePath"
        Finalize-Logging
        exit 1
    }

    # Display README.md
    Write-LogInfo "Displaying README.md"
    Get-Content $ReadmePath | Write-Host
    Finalize-Logging
    exit 0
}

# Log configuration
Write-LogInfo "Configuration:"
Write-LogInfo "  Hostname: $Hostname"
Write-LogInfo "  Username: $Username"
Write-LogInfo "  Email: $Email"
Write-LogInfo "  Directory: $Directory"

# Check if the setup script exists
if (-not (Test-Path $SetupScript)) {
    Write-Error "Setup script not found at $SetupScript"
    Write-LogError "Setup script not found at $SetupScript"
    Finalize-Logging
    exit 1
}

# Log execution of setup script
Write-LogInfo "Executing setup script: $SetupScript"

# Call the setup script with the arguments
& $SetupScript -Hostname $Hostname -Username $Username -Email $Email -Directory $Directory

# Capture the exit code
$ExitCode = $LASTEXITCODE

# Log the result of the setup script execution
if ($ExitCode -eq 0) {
    Write-LogSuccess "Setup script completed successfully"
    Write-Host "Jarvis Toolset setup completed successfully!" -ForegroundColor Green
} else {
    Write-LogError "Setup script failed with exit code $ExitCode"
    Write-Error "Jarvis Toolset setup failed with exit code $ExitCode"
}

# Finalize logging
Write-LogInfo "Finalizing logging"
Finalize-Logging

exit $ExitCode
