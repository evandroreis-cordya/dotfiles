#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

print_in_purple "
   CLI Tools Installation

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Core CLI Tools
print_in_purple "
 >> Installing Core CLI Tools

"
source "${SCRIPT_DIR}/core_cli_tools.zsh"

# Cloud CLI Tools
print_in_purple "
 >> Installing Cloud CLI Tools

"
source "${SCRIPT_DIR}/cloud_cli_tools.zsh"

# Web Development CLI Tools
print_in_purple "
 >> Installing Web Development CLI Tools

"
source "${SCRIPT_DIR}/web_cli_tools.zsh"

# Development CLI Tools
print_in_purple "
 >> Installing Development CLI Tools

"
source "${SCRIPT_DIR}/development_cli_tools.zsh"

# System CLI Tools
print_in_purple "
 >> Installing System CLI Tools

"
source "${SCRIPT_DIR}/system_cli_tools.zsh"

print_in_green "
  All CLI tools installation complete!
"
