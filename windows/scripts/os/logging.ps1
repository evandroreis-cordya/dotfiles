# Windows-specific PowerShell logging functions

# Global variables for logging
$script:CURRENT_LOG_FILE = ""
$script:LOGS_DIR = "$env:USERPROFILE\.jarvistoolset\logs"

# Initialize logging
function Initialize-Logging {
    # Create timestamp in format YYYY-MM-DD-HHMMSS
    $timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"

    # Create log filename
    $script:CURRENT_LOG_FILE = "$script:LOGS_DIR\jarvistoolset-$timestamp.log"

    # Ensure logs directory exists
    if (-not (Test-Path $script:LOGS_DIR)) {
        New-Item -ItemType Directory -Path $script:LOGS_DIR -Force | Out-Null
    }

    # Create empty log file
    New-Item -ItemType File -Path $script:CURRENT_LOG_FILE -Force | Out-Null

    # Print log file location
    Write-Host "`n >> Logging initialized`n`n   Log file: $script:CURRENT_LOG_FILE`n"

    # Add header to log file
    $header = @"
========================================================
  JARVIS TOOLSET INSTALLATION LOG
  Started: $(Get-Date)
  Hostname: $env:COMPUTERNAME
  User: $env:USERNAME
  OS: $env:JARVIS_OS
  Shell: $env:JARVIS_SHELL
========================================================

"@
    Add-Content -Path $script:CURRENT_LOG_FILE -Value $header
}

# Log a message to the log file
function Write-LogMessage {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )

    # Initialize logging if not already done
    if (-not $script:CURRENT_LOG_FILE -or -not (Test-Path $script:CURRENT_LOG_FILE)) {
        Initialize-Logging
    }

    # Ensure logs directory exists
    if (-not (Test-Path $script:LOGS_DIR)) {
        New-Item -ItemType Directory -Path $script:LOGS_DIR -Force | Out-Null
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] $Message"

    Add-Content -Path $script:CURRENT_LOG_FILE -Value $logEntry
}

# Logging functions
function Write-LogInfo {
    param([string]$Message)
    Write-LogMessage $Message "INFO"
}

function Write-LogWarning {
    param([string]$Message)
    Write-LogMessage $Message "WARNING"
}

function Write-LogError {
    param([string]$Message)
    Write-LogMessage $Message "ERROR"
}

function Write-LogSuccess {
    param([string]$Message)
    Write-LogMessage $Message "SUCCESS"
}

function Write-LogDebug {
    param([string]$Message)
    Write-LogMessage $Message "DEBUG"
}

# Log command execution
function Write-LogCommand {
    param(
        [string]$Command,
        [string]$Description = $Command
    )

    Write-LogInfo "Executing: $Description"

    try {
        $output = Invoke-Expression $Command
        Write-LogSuccess "Command succeeded: $Description"

        if ($output) {
            $commandOutput = @"
--- Command output start ---
$output
--- Command output end ---

"@
            Add-Content -Path $script:CURRENT_LOG_FILE -Value $commandOutput
        }
        return $true
    } catch {
        Write-LogError "Command failed: $Description"
        Write-LogError $_.Exception.Message

        $commandOutput = @"
--- Command output start ---
$($_.Exception.Message)
--- Command output end ---

"@
        Add-Content -Path $script:CURRENT_LOG_FILE -Value $commandOutput
        return $false
    }
}

# Execute command with logging
function Execute-WithLog {
    param(
        [string]$Command,
        [string]$Message = $Command
    )

    Write-InYellow "   $Message..."
    $result = Write-LogCommand $Command $Message
    Write-Result $LASTEXITCODE $Message
    return $result
}

# Log system information
function Write-LogSystemInfo {
    Write-LogInfo "System Information:"
    Write-LogInfo "  OS: $env:JARVIS_OS"
    Write-LogInfo "  Architecture: $env:JARVIS_ARCH"
    Write-LogInfo "  Shell: $env:JARVIS_SHELL"
    Write-LogInfo "  Package Manager: $env:JARVIS_PACKAGE_MANAGER"
    Write-LogInfo "  Terminal: $env:JARVIS_TERMINAL"
    Write-LogInfo "  User: $env:USERNAME"
    Write-LogInfo "  Hostname: $env:COMPUTERNAME"
    Write-LogInfo "  Home Directory: $env:USERPROFILE"

    # Windows-specific system information
    $os = Get-WmiObject -Class Win32_OperatingSystem
    Write-LogInfo "  Windows Version: $($os.Caption) $($os.Version)"
    Write-LogInfo "  Build Number: $($os.BuildNumber)"
    Write-LogInfo "  Architecture: $($os.OSArchitecture)"

    $computer = Get-WmiObject -Class Win32_ComputerSystem
    Write-LogInfo "  Total RAM: $([math]::Round($computer.TotalPhysicalMemory / 1GB, 2)) GB"

    $processor = Get-WmiObject -Class Win32_Processor
    Write-LogInfo "  Processor: $($processor.Name)"
}

# Log environment variables
function Write-LogEnvironment {
    Write-LogInfo "Environment Variables:"
    Write-LogInfo "  JARVIS_OS: $env:JARVIS_OS"
    Write-LogInfo "  JARVIS_SHELL: $env:JARVIS_SHELL"
    Write-LogInfo "  JARVIS_PACKAGE_MANAGER: $env:JARVIS_PACKAGE_MANAGER"
    Write-LogInfo "  JARVIS_TERMINAL: $env:JARVIS_TERMINAL"
    Write-LogInfo "  HOSTNAME: $env:HOSTNAME"
    Write-LogInfo "  USERNAME: $env:USERNAME"
    Write-LogInfo "  EMAIL: $env:EMAIL"
    Write-LogInfo "  DIRECTORY: $env:DIRECTORY"
}

# Log installation progress
function Write-LogInstallationProgress {
    param(
        [int]$Step,
        [int]$Total,
        [string]$Description
    )

    Write-LogInfo "Installation Progress: Step $Step of $Total - $Description"
}

# Log package installation
function Write-LogPackageInstall {
    param(
        [string]$Package,
        [string]$Method,
        [string]$Version = "unknown"
    )

    Write-LogInfo "Package Installation:"
    Write-LogInfo "  Package: $Package"
    Write-LogInfo "  Method: $Method"
    Write-LogInfo "  Version: $Version"
}

# Log configuration changes
function Write-LogConfigChange {
    param(
        [string]$File,
        [string]$Action,
        [string]$Description
    )

    Write-LogInfo "Configuration Change:"
    Write-LogInfo "  File: $File"
    Write-LogInfo "  Action: $Action"
    Write-LogInfo "  Description: $Description"
}

# Log error with context
function Write-LogErrorWithContext {
    param(
        [string]$Error,
        [string]$Context,
        [string]$Suggestion = ""
    )

    Write-LogError "Error: $Error"
    Write-LogError "Context: $Context"
    if ($Suggestion) {
        Write-LogError "Suggestion: $Suggestion"
    }
}

# Log performance metrics
function Write-LogPerformance {
    param(
        [string]$Operation,
        [string]$Duration,
        [string]$MemoryUsage = "",
        [string]$CpuUsage = ""
    )

    Write-LogInfo "Performance Metrics:"
    Write-LogInfo "  Operation: $Operation"
    Write-LogInfo "  Duration: ${Duration}s"
    if ($MemoryUsage) {
        Write-LogInfo "  Memory Usage: $MemoryUsage"
    }
    if ($CpuUsage) {
        Write-LogInfo "  CPU Usage: $CpuUsage"
    }
}

# Finalize logging
function Finalize-Logging {
    if ($script:CURRENT_LOG_FILE -and (Test-Path $script:CURRENT_LOG_FILE)) {
        $footer = @"

========================================================
  JARVIS TOOLSET INSTALLATION COMPLETED
  Finished: $(Get-Date)
  Total Duration: $((Get-Date) - (Get-Item $script:CURRENT_LOG_FILE).CreationTime).TotalSeconds seconds
========================================================
"@
        Add-Content -Path $script:CURRENT_LOG_FILE -Value $footer

        Write-LogInfo "Logging finalized. Log file: $script:CURRENT_LOG_FILE"
    }
}

# Clean up old log files
function Clear-OldLogs {
    param([int]$DaysToKeep = 7)

    if (Test-Path $script:LOGS_DIR) {
        $cutoffDate = (Get-Date).AddDays(-$DaysToKeep)
        $oldLogs = Get-ChildItem -Path $script:LOGS_DIR -Filter "jarvistoolset-*.log" | Where-Object { $_.CreationTime -lt $cutoffDate }

        foreach ($log in $oldLogs) {
            Remove-Item $log.FullName -Force
        }

        Write-LogInfo "Cleaned up $($oldLogs.Count) log files older than $DaysToKeep days"
    }
}

# Function to get log file path
function Get-LogFile {
    return $script:CURRENT_LOG_FILE
}

# Function to set log file path
function Set-LogFile {
    param([string]$LogFilePath)
    $script:CURRENT_LOG_FILE = $LogFilePath
}

# Function to get logs directory
function Get-LogsDirectory {
    return $script:LOGS_DIR
}

# Function to set logs directory
function Set-LogsDirectory {
    param([string]$LogsDirectory)
    $script:LOGS_DIR = $LogsDirectory
}

# Export functions
Export-ModuleMember -Function *
