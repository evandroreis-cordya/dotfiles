#!/bin/zsh
#==============================================================================
# CONFIGURATION TESTING SCRIPT
#==============================================================================
# This script tests all configurations to ensure they work properly
# and provides comprehensive validation and testing
#
# Features:
# - Syntax validation for all configuration files
# - Dependency checking
# - Performance testing
# - Integration testing
# - Error reporting
#==============================================================================

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/utils.zsh"

print_in_purple "
   Configuration Testing and Validation

"

# Test configuration
export TEST_RESULTS_DIR="$HOME/.test_results"
export TEST_LOGS_DIR="$HOME/.logs/tests"

# Create test directories
mkdir -p "$TEST_RESULTS_DIR"
mkdir -p "$TEST_LOGS_DIR"

# Test results tracking
typeset -A TEST_RESULTS
typeset -i TOTAL_TESTS=0
typeset -i PASSED_TESTS=0
typeset -i FAILED_TESTS=0

# Test logging
log_test() {
    local test_name="$1"
    local result="$2"
    local message="$3"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] $result: $test_name - $message" >> "$TEST_LOGS_DIR/test_results.log"
    
    if [[ "$result" == "PASS" ]]; then
        ((PASSED_TESTS++))
    else
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
}

# Test configuration syntax
test_config_syntax() {
    print_in_yellow "Testing configuration syntax..."
    
    local config_dir="$HOME/dotfiles/macos/configs/shell/zsh_configs"
    local errors=0
    
    for config_file in "$config_dir"/*.zsh; do
        if [[ -f "$config_file" ]]; then
            local basename="${config_file##*/}"
            
            if zsh -n "$config_file" 2>/dev/null; then
                log_test "syntax_$basename" "PASS" "Syntax is valid"
            else
                log_test "syntax_$basename" "FAIL" "Syntax error detected"
                ((errors++))
            fi
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All configuration files have valid syntax"
    else
        print_in_red "$errors configuration files have syntax errors"
    fi
    
    return $errors
}

# Test configuration loading
test_config_loading() {
    print_in_yellow "Testing configuration loading..."
    
    local config_dir="$HOME/dotfiles/macos/configs/shell/zsh_configs"
    local errors=0
    
    for config_file in "$config_dir"/*.zsh; do
        if [[ -f "$config_file" ]]; then
            local basename="${config_file##*/}"
            
            # Skip special files
            if [[ "$basename" == "00_load_order.zsh" ]] || \
               [[ "$basename" == "template.zsh" ]]; then
                continue
            fi
            
            # Test loading in isolated environment
            if zsh -c "source '$config_file'" 2>/dev/null; then
                log_test "load_$basename" "PASS" "Configuration loads successfully"
            else
                log_test "load_$basename" "FAIL" "Configuration failed to load"
                ((errors++))
            fi
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All configuration files load successfully"
    else
        print_in_red "$errors configuration files failed to load"
    fi
    
    return $errors
}

# Test tool availability
test_tool_availability() {
    print_in_yellow "Testing tool availability..."
    
    # Define tools to test
    local tools=(
        "python3"
        "node"
        "java"
        "docker"
        "git"
        "curl"
        "wget"
        "jq"
        "yq"
    )
    
    local errors=0
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" >/dev/null 2>&1; then
            log_test "tool_$tool" "PASS" "Tool is available"
        else
            log_test "tool_$tool" "FAIL" "Tool is not available"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All required tools are available"
    else
        print_in_red "$errors required tools are missing"
    fi
    
    return $errors
}

# Test environment variables
test_environment_variables() {
    print_in_yellow "Testing environment variables..."
    
    local required_vars=(
        "PATH"
        "HOME"
        "SHELL"
        "EDITOR"
    )
    
    local errors=0
    
    for var in "${required_vars[@]}"; do
        if [[ -n "${(P)var}" ]]; then
            log_test "env_$var" "PASS" "Environment variable is set"
        else
            log_test "env_$var" "FAIL" "Environment variable is not set"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All required environment variables are set"
    else
        print_in_red "$errors required environment variables are missing"
    fi
    
    return $errors
}

# Test alias functionality
test_alias_functionality() {
    print_in_yellow "Testing alias functionality..."
    
    local aliases_to_test=(
        "ll"
        "la"
        "gst"
        "gco"
        "gcb"
    )
    
    local errors=0
    
    for alias_name in "${aliases_to_test[@]}"; do
        if alias "$alias_name" >/dev/null 2>&1; then
            log_test "alias_$alias_name" "PASS" "Alias is defined"
        else
            log_test "alias_$alias_name" "FAIL" "Alias is not defined"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All required aliases are defined"
    else
        print_in_red "$errors required aliases are missing"
    fi
    
    return $errors
}

# Test function availability
test_function_availability() {
    print_in_yellow "Testing function availability..."
    
    local functions_to_test=(
        "print_in_purple"
        "print_in_yellow"
        "print_in_green"
        "print_in_red"
        "execute"
    )
    
    local errors=0
    
    for func_name in "${functions_to_test[@]}"; do
        if type "$func_name" >/dev/null 2>&1; then
            log_test "func_$func_name" "PASS" "Function is available"
        else
            log_test "func_$func_name" "FAIL" "Function is not available"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All required functions are available"
    else
        print_in_red "$errors required functions are missing"
    fi
    
    return $errors
}

# Test AI tool configurations
test_ai_tool_configs() {
    print_in_yellow "Testing AI tool configurations..."
    
    local ai_configs=(
        "gemini.zsh"
        "ai_codegen.zsh"
        "crewai.zsh"
        "agentic_ai.zsh"
        "nvidia_ai.zsh"
        "nvidia_nemo.zsh"
    )
    
    local errors=0
    
    for config in "${ai_configs[@]}"; do
        local config_path="$HOME/dotfiles/macos/configs/shell/zsh_configs/$config"
        
        if [[ -f "$config_path" ]]; then
            # Test if config can be sourced without errors
            if zsh -c "source '$config_path'" 2>/dev/null; then
                log_test "ai_config_$config" "PASS" "AI configuration loads successfully"
            else
                log_test "ai_config_$config" "FAIL" "AI configuration failed to load"
                ((errors++))
            fi
        else
            log_test "ai_config_$config" "FAIL" "AI configuration file not found"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All AI tool configurations are working"
    else
        print_in_red "$errors AI tool configurations have issues"
    fi
    
    return $errors
}

# Test installation scripts
test_installation_scripts() {
    print_in_yellow "Testing installation scripts..."
    
    local install_scripts=(
        "autonomous_agents.zsh"
        "agentic_codegen.zsh"
        "nvidia_nemo.zsh"
        "nvidia_tools.zsh"
    )
    
    local errors=0
    
    for script in "${install_scripts[@]}"; do
        local script_path="$HOME/dotfiles/macos/install/ai_tools/$script"
        
        if [[ -f "$script_path" ]]; then
            # Test script syntax
            if zsh -n "$script_path" 2>/dev/null; then
                log_test "install_$script" "PASS" "Installation script syntax is valid"
            else
                log_test "install_$script" "FAIL" "Installation script has syntax errors"
                ((errors++))
            fi
        else
            log_test "install_$script" "FAIL" "Installation script not found"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "All installation scripts are valid"
    else
        print_in_red "$errors installation scripts have issues"
    fi
    
    return $errors
}

# Test load order
test_load_order() {
    print_in_yellow "Testing load order configuration..."
    
    local load_order_file="$HOME/dotfiles/macos/configs/shell/zsh_configs/00_load_order.zsh"
    
    if [[ -f "$load_order_file" ]]; then
        # Test load order syntax
        if zsh -n "$load_order_file" 2>/dev/null; then
            log_test "load_order_syntax" "PASS" "Load order file syntax is valid"
            
            # Test load order execution
            if zsh -c "source '$load_order_file'" 2>/dev/null; then
                log_test "load_order_execution" "PASS" "Load order file executes successfully"
            else
                log_test "load_order_execution" "FAIL" "Load order file failed to execute"
                return 1
            fi
        else
            log_test "load_order_syntax" "FAIL" "Load order file has syntax errors"
            return 1
        fi
    else
        log_test "load_order_file" "FAIL" "Load order file not found"
        return 1
    fi
    
    print_in_green "Load order configuration is working"
    return 0
}

# Performance test
test_performance() {
    print_in_yellow "Testing configuration performance..."
    
    local start_time=$(date +%s.%N)
    
    # Test shell startup time
    local test_shell_startup() {
        local test_start=$(date +%s.%N)
        
        # Simulate shell startup
        zsh -c "
            source '$HOME/dotfiles/macos/configs/shell/zsh_configs/exports.zsh'
            source '$HOME/dotfiles/macos/configs/shell/zsh_configs/aliases.zsh'
        " >/dev/null 2>&1
        
        local test_end=$(date +%s.%N)
        local duration=$(echo "$test_end - $test_start" | bc)
        
        if (( $(echo "$duration < 2.0" | bc -l) )); then
            log_test "performance_shell_startup" "PASS" "Shell startup time: ${duration}s"
            return 0
        else
            log_test "performance_shell_startup" "FAIL" "Shell startup time too slow: ${duration}s"
            return 1
        fi
    }
    
    local errors=0
    if ! test_shell_startup; then
        ((errors++))
    fi
    
    local end_time=$(date +%s.%N)
    local total_duration=$(echo "$end_time - $start_time" | bc)
    
    log_test "performance_total" "INFO" "Total test duration: ${total_duration}s"
    
    if [[ $errors -eq 0 ]]; then
        print_in_green "Performance tests passed"
    else
        print_in_red "Performance tests failed"
    fi
    
    return $errors
}

# Generate test report
generate_test_report() {
    print_in_yellow "Generating test report..."
    
    local report_file="$TEST_RESULTS_DIR/test_report_$(date +%Y%m%d_%H%M%S).md"
    
    cat > "$report_file" << EOF
# Configuration Test Report
Generated: $(date)

## Summary
- Total Tests: $TOTAL_TESTS
- Passed: $PASSED_TESTS
- Failed: $FAILED_TESTS
- Success Rate: $(( (PASSED_TESTS * 100) / TOTAL_TESTS ))%

## Test Results
EOF
    
    # Add detailed results from log file
    if [[ -f "$TEST_LOGS_DIR/test_results.log" ]]; then
        cat "$TEST_LOGS_DIR/test_results.log" >> "$report_file"
    fi
    
    echo "Test report generated: $report_file"
}

# Run all tests
run_all_tests() {
    print_in_purple "Running comprehensive configuration tests..."
    
    local total_errors=0
    
    test_config_syntax
    ((total_errors += $?))
    
    test_config_loading
    ((total_errors += $?))
    
    test_tool_availability
    ((total_errors += $?))
    
    test_environment_variables
    ((total_errors += $?))
    
    test_alias_functionality
    ((total_errors += $?))
    
    test_function_availability
    ((total_errors += $?))
    
    test_ai_tool_configs
    ((total_errors += $?))
    
    test_installation_scripts
    ((total_errors += $?))
    
    test_load_order
    ((total_errors += $?))
    
    test_performance
    ((total_errors += $?))
    
    generate_test_report
    
    echo ""
    print_in_purple "Test Summary:"
    echo "Total Tests: $TOTAL_TESTS"
    echo "Passed: $PASSED_TESTS"
    echo "Failed: $FAILED_TESTS"
    echo "Total Errors: $total_errors"
    
    if [[ $total_errors -eq 0 ]]; then
        print_in_green "All tests passed! Configuration is working correctly."
        return 0
    else
        print_in_red "Some tests failed. Please check the test report for details."
        return 1
    fi
}

# Run tests
run_all_tests
