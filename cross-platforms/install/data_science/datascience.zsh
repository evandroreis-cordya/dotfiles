#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
print_in_purple "\n   Data Science Environment\n\n"

# Create a dedicated virtual environment for data science packages
DATASCIENCE_ENV="datascience"
pyenv virtualenv 3.12.2 $DATASCIENCE_ENV 2>/dev/null || true
print_result $? "Creating Data Science virtual environment"

# Function to install packages in the data science environment
pip_install_in_env() {
    local -r PACKAGE_READABLE_NAME="$1"
    local -r PACKAGE="$2"

    PYENV_VERSION=$DATASCIENCE_ENV pip install $PACKAGE -U &>/dev/null
    print_result $? "$PACKAGE_READABLE_NAME"
}

# Data Science packages
pip_install_in_env "Jupyter" "jupyter"
pip_install_in_env "Pandas" "pandas"
pip_install_in_env "NumPy" "numpy"
pip_install_in_env "Matplotlib" "matplotlib"
pip_install_in_env "Seaborn" "seaborn"
pip_install_in_env "SciPy" "scipy"
pip_install_in_env "Scikit-learn" "scikit-learn"

# Machine Learning packages
pip_install_in_env "TensorFlow" "tensorflow"
# PyTorch installation - cross-platform version
print_in_yellow "Installing PyTorch...\n"
PYENV_VERSION=$DATASCIENCE_ENV pip install torch torchvision torchaudio
print_result $? "PyTorch"
pip_install_in_env "Keras" "keras"
pip_install_in_env "XGBoost" "xgboost"
pip_install_in_env "LightGBM" "lightgbm"

# Create activation script for the data science environment
DIRECTORY="${SCRIPT_DIR}/../../.."
# Detect OS and set appropriate path
if [[ "$OSTYPE" == "darwin"* ]]; then
    ACTIVATE_SCRIPT="${DIRECTORY}/macos/scripts/activate_datascience.sh"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ACTIVATE_SCRIPT="${DIRECTORY}/linux/scripts/activate_datascience.sh"
else
    ACTIVATE_SCRIPT="${DIRECTORY}/cross-platforms/scripts/activate_datascience.sh"
fi
mkdir -p "$(dirname "$ACTIVATE_SCRIPT")"

cat > "$ACTIVATE_SCRIPT" << EOL
#!/bin/bash
# Activate the Data Science environment

# Ensure pyenv is available
if command -v pyenv 1>/dev/null 2>&1; then
    eval "\$(pyenv init -)"
    eval "\$(pyenv virtualenv-init -)"

    # Activate the datascience environment
    pyenv activate datascience

    echo "Data Science environment activated!"
    echo "This environment includes: Jupyter, Pandas, NumPy, Matplotlib, TensorFlow, PyTorch, etc."
else
    echo "Error: pyenv is not installed or not in PATH"
    exit 1
fi
EOL

chmod +x "$ACTIVATE_SCRIPT"
print_result $? "Creating Data Science activation script"

print_in_yellow "\n  To activate the Data Science environment, run:\n"
print_in_yellow "  source ${ACTIVATE_SCRIPT}\n"
