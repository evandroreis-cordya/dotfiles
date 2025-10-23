#!/bin/zsh
#==============================================================================
# CONFIGURATION VALIDATION SCRIPT
#==============================================================================
# This script validates the configuration refactoring by checking:
# 1. All config files are properly formatted
# 2. No duplicate exports across config files
# 3. All install scripts properly source utils.zsh
# 4. No remaining inline configurations
# 5. Load order is properly configured
#==============================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONFIG_DIR="/Volumes/DEVS/repos/dotfiles/macos/configs/shell/zsh_configs"
INSTALL_DIR="/Volumes/DEVS/repos/dotfiles/macos/install"
LOAD_ORDER_FILE="$CONFIG_DIR/00_load_order.zsh"

# Validation results
declare -a ERRORS=()
declare -a WARNINGS=()
declare -a SUCCESS=()

# Helper functions
print_error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    ERRORS+=("$1")
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    WARNINGS+=("$1")
}

print_success() {
    echo -e "${GREEN}✅ SUCCESS: $1${NC}"
    SUCCESS+=("$1")
}

print_info() {
    echo -e "${BLUE}ℹ️  INFO: $1${NC}"
}

# Function to check if a file exists and is readable
check_file_exists() {
    local file="$1"
    local description="$2"

    if [[ -f "$file" ]]; then
        if [[ -r "$file" ]]; then
            print_success "$description exists and is readable"
            return 0
        else
            print_error "$description exists but is not readable"
            return 1
        fi
    else
        print_error "$description does not exist: $file"
        return 1
    fi
}

# Function to validate config file format
validate_config_file() {
    local config_file="$1"
    local config_path="$CONFIG_DIR/$config_file"

    if [[ ! -f "$config_path" ]]; then
        print_warning "Config file not found: $config_file"
        return 1
    fi

    # Check if file starts with shebang
    if ! head -1 "$config_path" | grep -q "^#!/bin/zsh"; then
        print_warning "$config_file: Missing shebang or incorrect shebang"
    fi

    # Check for proper header format
    if ! grep -q "^#.*Configuration" "$config_path"; then
        print_warning "$config_file: Missing configuration header comment"
    fi

    # Check for proper structure (exports, aliases, functions)
    local has_exports=false
    local has_aliases=false
    local has_functions=false

    if grep -q "^export " "$config_path"; then
        has_exports=true
    fi

    if grep -q "^alias " "$config_path"; then
        has_aliases=true
    fi

    if grep -q "^[a-zA-Z_][a-zA-Z0-9_]*()" "$config_path"; then
        has_functions=true
    fi

    # At least one of these should be present
    if [[ "$has_exports" == false && "$has_aliases" == false && "$has_functions" == false ]]; then
        print_warning "$config_file: No exports, aliases, or functions found"
    fi

    print_success "$config_file: Format validation passed"
    return 0
}

# Function to check for duplicate exports
check_duplicate_exports() {
    print_info "Checking for duplicate exports across config files..."

    local -A export_counts=()
    local duplicates_found=false

    # Find all export statements in config files
    for config_file in "$CONFIG_DIR"/*.zsh; do
        if [[ -f "$config_file" ]]; then
            local basename_file="${config_file##*/}"
            if [[ "$basename_file" != "00_load_order.zsh" && "$basename_file" != "template.zsh" ]]; then
                while IFS= read -r line; do
                    if [[ "$line" =~ ^export[[:space:]]+([A-Z_][A-Z0-9_]*)= ]]; then
                        local var_name="${BASH_REMATCH[1]}"
                        if [[ -n "${export_counts[$var_name]}" ]]; then
                            export_counts[$var_name]+=" $basename_file"
                            duplicates_found=true
                        else
                            export_counts[$var_name]="$basename_file"
                        fi
                    fi
                done < "$config_file"
            fi
        fi
    done

    # Report duplicates
    for var_name in "${(@k)export_counts}"; do
        local files="${export_counts[$var_name]}"
        local file_count=$(echo "$files" | wc -w)
        if [[ $file_count -gt 1 ]]; then
            print_error "Duplicate export '$var_name' found in: $files"
        fi
    done

    if [[ "$duplicates_found" == false ]]; then
        print_success "No duplicate exports found"
    fi
}

# Function to validate utils.zsh sourcing
validate_utils_sourcing() {
    print_info "Validating utils.zsh sourcing in install scripts..."

    local incorrect_sourcing=0

    # Find all .zsh files in install directory
    find "$INSTALL_DIR" -name "*.zsh" -not -path "*/utils.zsh" -not -path "*/template.zsh" -not -path "*/main.zsh" -not -path "*/update_*.zsh" | while read -r script_file; do
        if grep -q "source.*utils\.zsh" "$script_file"; then
            # Check if sourcing is correct (should be ../utils.zsh from subdirectories)
            if grep -q 'source "${SCRIPT_DIR}/../utils.zsh"' "$script_file"; then
                print_success "Correct utils sourcing in: ${script_file##*/}"
            elif grep -q 'source "${SCRIPT_DIR}/utils.zsh"' "$script_file"; then
                print_error "Incorrect utils sourcing in: ${script_file##*/} (should be ../utils.zsh)"
                ((incorrect_sourcing++))
            elif grep -q 'source "${SCRIPT_DIR}/../../utils.zsh"' "$script_file"; then
                print_error "Incorrect utils sourcing in: ${script_file##*/} (should be ../utils.zsh)"
                ((incorrect_sourcing++))
            else
                print_warning "Unknown utils sourcing pattern in: ${script_file##*/}"
            fi
        else
            print_warning "No utils.zsh sourcing found in: ${script_file##*/}"
        fi
    done

    if [[ $incorrect_sourcing -eq 0 ]]; then
        print_success "All utils.zsh sourcing patterns are correct"
    fi
}

# Function to check for remaining inline configurations
check_inline_configs() {
    print_info "Checking for remaining inline configurations..."

    local inline_configs=0

    # Check for shell profile modifications
    local shell_modifications=$(find "$INSTALL_DIR" -name "*.zsh" -exec grep -l "grep.*\.zshrc\|echo.*>>.*\.zshrc\|echo.*>>.*SHELL_PROFILE" {} \; 2>/dev/null | wc -l)

    if [[ $shell_modifications -gt 0 ]]; then
        print_error "Found $shell_modifications files with shell profile modifications"
        find "$INSTALL_DIR" -name "*.zsh" -exec grep -l "grep.*\.zshrc\|echo.*>>.*\.zshrc\|echo.*>>.*SHELL_PROFILE" {} \; 2>/dev/null | while read -r file; do
            print_error "Shell profile modification in: ${file##*/}"
        done
    else
        print_success "No shell profile modifications found"
    fi

    # Check for inline export statements in install scripts
    local inline_exports=$(find "$INSTALL_DIR" -name "*.zsh" -not -path "*/utils.zsh" -exec grep -l "^export " {} \; 2>/dev/null | wc -l)

    if [[ $inline_exports -gt 0 ]]; then
        print_warning "Found $inline_exports files with inline export statements"
        find "$INSTALL_DIR" -name "*.zsh" -not -path "*/utils.zsh" -exec grep -l "^export " {} \; 2>/dev/null | while read -r file; do
            print_warning "Inline exports in: ${file##*/}"
        done
    else
        print_success "No inline export statements found"
    fi
}

# Function to validate load order
validate_load_order() {
    print_info "Validating load order configuration..."

    if [[ ! -f "$LOAD_ORDER_FILE" ]]; then
        print_error "Load order file not found: $LOAD_ORDER_FILE"
        return 1
    fi

    # Check if load order file has proper structure
    if ! grep -q "ZSH_CONFIG_LOAD_ORDER=" "$LOAD_ORDER_FILE"; then
        print_error "Load order file missing ZSH_CONFIG_LOAD_ORDER array"
        return 1
    fi

    # Check if all config files in load order exist
    local missing_configs=0
    while IFS= read -r line; do
        if [[ "$line" =~ \"([^\"]+\.zsh)\" ]]; then
            local config_file="${BASH_REMATCH[1]}"
            if [[ ! -f "$CONFIG_DIR/$config_file" ]]; then
                print_error "Config file in load order does not exist: $config_file"
                ((missing_configs++))
            fi
        fi
    done < "$LOAD_ORDER_FILE"

    if [[ $missing_configs -eq 0 ]]; then
        print_success "All config files in load order exist"
    fi

    # Check for config files not in load order
    local unlisted_configs=0
    for config_file in "$CONFIG_DIR"/*.zsh; do
        if [[ -f "$config_file" ]]; then
            local basename_file="${config_file##*/}"
            if [[ "$basename_file" != "00_load_order.zsh" && "$basename_file" != "template.zsh" ]]; then
                if ! grep -q "\"$basename_file\"" "$LOAD_ORDER_FILE"; then
                    print_warning "Config file not in load order: $basename_file"
                    ((unlisted_configs++))
                fi
            fi
        fi
    done

    if [[ $unlisted_configs -eq 0 ]]; then
        print_success "All config files are included in load order"
    fi
}

# Function to validate specific config files
validate_specific_configs() {
    print_info "Validating specific configuration files..."

    # List of expected config files
    local expected_configs=(
        "00_load_order.zsh"
        "anthropic.zsh"
        "ai_codegen.zsh"
        "gemini.zsh"
        "openai.zsh"
        "azure_ai.zsh"
        "deepseek.zsh"
        "cerebras.zsh"
        "grok.zsh"
        "oracle_ai.zsh"
        "meta_ai.zsh"
        "aws.zsh"
        "azure.zsh"
        "vercel.zsh"
        "nvidia_cloud.zsh"
        "vscode.zsh"
        "jetbrains.zsh"
        "neovim.zsh"
        "python.zsh"
        "ruby.zsh"
        "go.zsh"
        "rust.zsh"
        "java.zsh"
        "node.zsh"
        "php.zsh"
        "cpp.zsh"
        "kotlin.zsh"
        "swift.zsh"
        "docker.zsh"
        "gpg.zsh"
        "xcode.zsh"
        "homebrew.zsh"
    )

    for config_file in "${expected_configs[@]}"; do
        validate_config_file "$config_file"
    done
}

# Function to generate validation report
generate_report() {
    echo ""
    echo "=============================================================================="
    echo "VALIDATION REPORT"
    echo "=============================================================================="
    echo ""

    echo -e "${GREEN}SUCCESSES (${#SUCCESS[@]}):${NC}"
    for success in "${SUCCESS[@]}"; do
        echo "  ✅ $success"
    done
    echo ""

    if [[ ${#WARNINGS[@]} -gt 0 ]]; then
        echo -e "${YELLOW}WARNINGS (${#WARNINGS[@]}):${NC}"
        for warning in "${WARNINGS[@]}"; do
            echo "  ⚠️  $warning"
        done
        echo ""
    fi

    if [[ ${#ERRORS[@]} -gt 0 ]]; then
        echo -e "${RED}ERRORS (${#ERRORS[@]}):${NC}"
        for error in "${ERRORS[@]}"; do
            echo "  ❌ $error"
        done
        echo ""
    fi

    echo "=============================================================================="
    echo "SUMMARY"
    echo "=============================================================================="
    echo "Total Successes: ${#SUCCESS[@]}"
    echo "Total Warnings: ${#WARNINGS[@]}"
    echo "Total Errors: ${#ERRORS[@]}"
    echo ""

    if [[ ${#ERRORS[@]} -eq 0 ]]; then
        echo -e "${GREEN}🎉 VALIDATION PASSED! All configurations are properly set up.${NC}"
        return 0
    else
        echo -e "${RED}❌ VALIDATION FAILED! Please fix the errors above.${NC}"
        return 1
    fi
}

# Main validation function
main() {
    echo "=============================================================================="
    echo "CONFIGURATION REFACTORING VALIDATION"
    echo "=============================================================================="
    echo ""

    # Check if directories exist
    check_file_exists "$CONFIG_DIR" "Configuration directory"
    check_file_exists "$INSTALL_DIR" "Install directory"

    # Run validations
    validate_load_order
    validate_specific_configs
    check_duplicate_exports
    validate_utils_sourcing
    check_inline_configs

    # Generate report
    generate_report
}

# Run main function
main "$@"
