#!/bin/zsh
#==============================================================================
# PERFORMANCE OPTIMIZATION SCRIPT
#==============================================================================
# This script implements performance improvements and best practices for
# the macOS dotfiles configuration system
#
# Features:
# - Shell startup time optimization
# - Lazy loading for heavy tools
# - Caching mechanisms for frequently used commands
# - PATH and environment variable optimization
# - Error handling improvements
# - Logging enhancements
# - Configuration validation
# - Cleanup scripts for failed installations
#==============================================================================

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

print_in_purple "
   Performance Optimization and Best Practices

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Performance optimization configuration
export PERFORMANCE_CONFIG_DIR="$HOME/.config/performance"
export PERFORMANCE_CACHE_DIR="$HOME/.cache/performance"
export PERFORMANCE_LOGS_DIR="$HOME/.logs/performance"

# Create performance directories
mkdir -p "$PERFORMANCE_CONFIG_DIR"
mkdir -p "$PERFORMANCE_CACHE_DIR"
mkdir -p "$PERFORMANCE_LOGS_DIR"

# Performance optimization functions
optimize_shell_startup() {
    print_in_yellow "Optimizing shell startup time..."
    
    # Create optimized .zshrc
    cat > "$HOME/.zshrc.optimized" << 'EOF'
# Optimized .zshrc for faster startup
# Load only essential configurations initially

# Essential exports only
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR="code"
export SHELL="/bin/zsh"

# Load Oh My Zsh (required)
export ZSH="$HOME/.oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"

# Load essential configurations only
source "$HOME/dotfiles/macos/configs/shell/zsh_configs/exports.zsh"
source "$HOME/dotfiles/macos/configs/shell/zsh_configs/aliases.zsh"

# Lazy load heavy tools
lazy_load_python() {
    unset -f lazy_load_python
    source "$HOME/dotfiles/macos/configs/shell/zsh_configs/python.zsh"
}

lazy_load_node() {
    unset -f lazy_load_node
    source "$HOME/dotfiles/macos/configs/shell/zsh_configs/node.zsh"
}

lazy_load_java() {
    unset -f lazy_load_java
    source "$HOME/dotfiles/macos/configs/shell/zsh_configs/java.zsh"
}

# Create lazy load aliases
alias python='lazy_load_python && python'
alias node='lazy_load_node && node'
alias java='lazy_load_java && java'
alias npm='lazy_load_node && npm'
alias nvm='lazy_load_node && nvm'

# Load remaining configurations in background
{
    source "$HOME/dotfiles/macos/configs/shell/zsh_configs/00_load_order.zsh"
} &
EOF
    
    echo "Optimized .zshrc created at $HOME/.zshrc.optimized"
}

implement_caching() {
    print_in_yellow "Implementing caching mechanisms..."
    
    # Create command cache
    cat > "$PERFORMANCE_CONFIG_DIR/command_cache.zsh" << 'EOF'
# Command caching for frequently used commands
typeset -A COMMAND_CACHE
typeset -A CACHE_TIMESTAMP
export CACHE_TIMEOUT=300  # 5 minutes

cache_command() {
    local cmd="$1"
    local result="$2"
    local timestamp=$(date +%s)
    
    COMMAND_CACHE[$cmd]="$result"
    CACHE_TIMESTAMP[$cmd]="$timestamp"
}

get_cached_command() {
    local cmd="$1"
    local current_time=$(date +%s)
    local cache_time="${CACHE_TIMESTAMP[$cmd]}"
    
    if [[ -n "$cache_time" ]]; then
        local age=$((current_time - cache_time))
        if [[ $age -lt $CACHE_TIMEOUT ]]; then
            echo "${COMMAND_CACHE[$cmd]}"
            return 0
        else
            # Remove expired cache
            unset COMMAND_CACHE[$cmd]
            unset CACHE_TIMESTAMP[$cmd]
        fi
    fi
    
    return 1
}

# Cached command functions
cached_which() {
    local cmd="$1"
    local result
    
    if result=$(get_cached_command "which:$cmd"); then
        echo "$result"
    else
        result=$(which "$cmd")
        cache_command "which:$cmd" "$result"
        echo "$result"
    fi
}

cached_command_exists() {
    local cmd="$1"
    local result
    
    if result=$(get_cached_command "exists:$cmd"); then
        [[ "$result" == "true" ]]
    else
        if command -v "$cmd" >/dev/null 2>&1; then
            cache_command "exists:$cmd" "true"
            return 0
        else
            cache_command "exists:$cmd" "false"
            return 1
        fi
    fi
}
EOF
    
    echo "Command caching implemented"
}

optimize_path() {
    print_in_yellow "Optimizing PATH and environment variables..."
    
    # Create PATH optimization script
    cat > "$PERFORMANCE_CONFIG_DIR/path_optimization.zsh" << 'EOF'
# PATH optimization for faster command resolution
export PATH_OPTIMIZATION_ENABLED=true

# Optimize PATH by removing duplicates and non-existent directories
optimize_path() {
    if [[ "$PATH_OPTIMIZATION_ENABLED" == "true" ]]; then
        # Remove duplicates and non-existent directories
        local new_path=""
        local seen_paths=()
        
        IFS=':' read -A path_array <<< "$PATH"
        for dir in "${path_array[@]}"; do
            # Skip if already seen or doesn't exist
            if [[ " ${seen_paths[@]} " =~ " ${dir} " ]] || [[ ! -d "$dir" ]]; then
                continue
            fi
            
            seen_paths+=("$dir")
            if [[ -z "$new_path" ]]; then
                new_path="$dir"
            else
                new_path="$new_path:$dir"
            fi
        done
        
        export PATH="$new_path"
    fi
}

# Optimize PATH on shell startup
optimize_path
EOF
    
    echo "PATH optimization implemented"
}

implement_lazy_loading() {
    print_in_yellow "Implementing lazy loading for heavy tools..."
    
    # Create lazy loading configuration
    cat > "$PERFORMANCE_CONFIG_DIR/lazy_loading.zsh" << 'EOF'
# Lazy loading for heavy tools to improve shell startup time
typeset -A LAZY_LOADED_TOOLS

lazy_load_tool() {
    local tool_name="$1"
    local config_file="$2"
    
    if [[ "${LAZY_LOADED_TOOLS[$tool_name]}" != "loaded" ]]; then
        if [[ -f "$config_file" ]]; then
            source "$config_file"
            LAZY_LOADED_TOOLS[$tool_name]="loaded"
        fi
    fi
}

# Define lazy loading for heavy tools
setup_lazy_loading() {
    # Python tools
    alias python='lazy_load_tool "python" "$HOME/dotfiles/macos/configs/shell/zsh_configs/python.zsh" && python'
    alias pip='lazy_load_tool "python" "$HOME/dotfiles/macos/configs/shell/zsh_configs/python.zsh" && pip'
    alias pyenv='lazy_load_tool "python" "$HOME/dotfiles/macos/configs/shell/zsh_configs/python.zsh" && pyenv'
    
    # Node.js tools
    alias node='lazy_load_tool "node" "$HOME/dotfiles/macos/configs/shell/zsh_configs/node.zsh" && node'
    alias npm='lazy_load_tool "node" "$HOME/dotfiles/macos/configs/shell/zsh_configs/node.zsh" && npm'
    alias nvm='lazy_load_tool "node" "$HOME/dotfiles/macos/configs/shell/zsh_configs/node.zsh" && nvm'
    
    # Java tools
    alias java='lazy_load_tool "java" "$HOME/dotfiles/macos/configs/shell/zsh_configs/java.zsh" && java'
    alias javac='lazy_load_tool "java" "$HOME/dotfiles/macos/configs/shell/zsh_configs/java.zsh" && javac'
    alias mvn='lazy_load_tool "java" "$HOME/dotfiles/macos/configs/shell/zsh_configs/java.zsh" && mvn'
    alias gradle='lazy_load_tool "java" "$HOME/dotfiles/macos/configs/shell/zsh_configs/java.zsh" && gradle'
    
    # Docker tools
    alias docker='lazy_load_tool "docker" "$HOME/dotfiles/macos/configs/shell/zsh_configs/docker.zsh" && docker'
    alias docker-compose='lazy_load_tool "docker" "$HOME/dotfiles/macos/configs/shell/zsh_configs/docker.zsh" && docker-compose'
    
    # AI tools
    alias python3='lazy_load_tool "ai_tools" "$HOME/dotfiles/macos/configs/shell/zsh_configs/ai_codegen.zsh" && python3'
}

# Initialize lazy loading
setup_lazy_loading
EOF
    
    echo "Lazy loading implemented"
}

enhance_error_handling() {
    print_in_yellow "Enhancing error handling..."
    
    # Create enhanced error handling
    cat > "$PERFORMANCE_CONFIG_DIR/error_handling.zsh" << 'EOF'
# Enhanced error handling for configuration loading
typeset -A CONFIG_ERRORS
export CONFIG_DEBUG=false

# Enhanced error logging
log_config_error() {
    local config_file="$1"
    local error_message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    CONFIG_ERRORS[$config_file]="$error_message"
    
    if [[ "$CONFIG_DEBUG" == "true" ]]; then
        echo "[$timestamp] ERROR in $config_file: $error_message" >&2
    fi
    
    # Log to file
    echo "[$timestamp] ERROR in $config_file: $error_message" >> "$HOME/.logs/config_errors.log"
}

# Safe source function with error handling
safe_source() {
    local config_file="$1"
    
    if [[ -f "$config_file" ]]; then
        if source "$config_file" 2>/dev/null; then
            return 0
        else
            log_config_error "$config_file" "Failed to load configuration"
            return 1
        fi
    else
        log_config_error "$config_file" "Configuration file not found"
        return 1
    fi
}

# Configuration validation
validate_config() {
    local config_file="$1"
    local errors=0
    
    # Check if file exists
    if [[ ! -f "$config_file" ]]; then
        echo "ERROR: Configuration file $config_file not found"
        ((errors++))
    fi
    
    # Check syntax
    if [[ -f "$config_file" ]]; then
        if ! zsh -n "$config_file" 2>/dev/null; then
            echo "ERROR: Syntax error in $config_file"
            ((errors++))
        fi
    fi
    
    return $errors
}

# Show configuration errors
show_config_errors() {
    if [[ ${#CONFIG_ERRORS[@]} -gt 0 ]]; then
        echo "Configuration Errors:"
        for config in "${(@k)CONFIG_ERRORS}"; do
            echo "  $config: ${CONFIG_ERRORS[$config]}"
        done
    else
        echo "No configuration errors found"
    fi
}
EOF
    
    echo "Enhanced error handling implemented"
}

implement_logging() {
    print_in_yellow "Implementing comprehensive logging..."
    
    # Create logging configuration
    cat > "$PERFORMANCE_CONFIG_DIR/logging.zsh" << 'EOF'
# Comprehensive logging system
export LOG_LEVEL="${LOG_LEVEL:-INFO}"
export LOG_DIR="$HOME/.logs"
export LOG_FILE="$LOG_DIR/dotfiles.log"

# Create log directory
mkdir -p "$LOG_DIR"

# Logging functions
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Log levels: DEBUG, INFO, WARN, ERROR
    case "$level" in
        DEBUG) [[ "$LOG_LEVEL" == "DEBUG" ]] && echo "[$timestamp] DEBUG: $message" >> "$LOG_FILE" ;;
        INFO)  echo "[$timestamp] INFO: $message" >> "$LOG_FILE" ;;
        WARN)  echo "[$timestamp] WARN: $message" >> "$LOG_FILE" ;;
        ERROR) echo "[$timestamp] ERROR: $message" >> "$LOG_FILE" ;;
    esac
}

# Configuration loading logging
log_config_load() {
    local config_file="$1"
    local start_time=$(date +%s.%N)
    
    if source "$config_file" 2>/dev/null; then
        local end_time=$(date +%s.%N)
        local duration=$(echo "$end_time - $start_time" | bc)
        log_message "INFO" "Loaded $config_file in ${duration}s"
        return 0
    else
        log_message "ERROR" "Failed to load $config_file"
        return 1
    fi
}

# Performance logging
log_performance() {
    local operation="$1"
    local duration="$2"
    log_message "INFO" "Performance: $operation completed in ${duration}s"
}

# Log cleanup
cleanup_logs() {
    local days="${1:-7}"
    find "$LOG_DIR" -name "*.log" -mtime +$days -delete
    log_message "INFO" "Cleaned up logs older than $days days"
}
EOF
    
    echo "Comprehensive logging implemented"
}

create_validation_scripts() {
    print_in_yellow "Creating configuration validation scripts..."
    
    # Create validation script
    cat > "$PERFORMANCE_CONFIG_DIR/validate_configs.zsh" << 'EOF'
#!/bin/zsh
# Configuration validation script

validate_all_configs() {
    local config_dir="$HOME/dotfiles/macos/configs/shell/zsh_configs"
    local errors=0
    local total=0
    
    echo "Validating configuration files..."
    
    for config_file in "$config_dir"/*.zsh; do
        if [[ -f "$config_file" ]]; then
            ((total++))
            local basename="${config_file##*/}"
            
            echo -n "Validating $basename... "
            
            if zsh -n "$config_file" 2>/dev/null; then
                echo "OK"
            else
                echo "ERROR"
                ((errors++))
            fi
        fi
    done
    
    echo "Validation complete: $errors errors out of $total files"
    return $errors
}

# Run validation
validate_all_configs
EOF
    
    chmod +x "$PERFORMANCE_CONFIG_DIR/validate_configs.zsh"
    echo "Configuration validation script created"
}

create_cleanup_scripts() {
    print_in_yellow "Creating cleanup scripts for failed installations..."
    
    # Create cleanup script
    cat > "$PERFORMANCE_CONFIG_DIR/cleanup_failed_installs.zsh" << 'EOF'
#!/bin/zsh
# Cleanup script for failed installations

cleanup_failed_installs() {
    local failed_dirs=(
        "$HOME/.cache/pip/failed"
        "$HOME/.npm/_cacache/failed"
        "$HOME/.gradle/caches/failed"
        "$HOME/.m2/repository/failed"
    )
    
    for dir in "${failed_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            echo "Cleaning up failed installs in $dir"
            rm -rf "$dir"
        fi
    done
    
    # Clean up broken symlinks
    find "$HOME" -type l -xtype l 2>/dev/null | while read -r link; do
        echo "Removing broken symlink: $link"
        rm "$link"
    done
    
    echo "Cleanup complete"
}

cleanup_failed_installs
EOF
    
    chmod +x "$PERFORMANCE_CONFIG_DIR/cleanup_failed_installs.zsh"
    echo "Cleanup script created"
}

# Run all optimizations
optimize_shell_startup
implement_caching
optimize_path
implement_lazy_loading
enhance_error_handling
implement_logging
create_validation_scripts
create_cleanup_scripts

print_in_green "Performance optimization complete!"
echo "Optimized configurations created in $PERFORMANCE_CONFIG_DIR"
echo "To use optimized .zshrc, run: cp $HOME/.zshrc.optimized $HOME/.zshrc"
