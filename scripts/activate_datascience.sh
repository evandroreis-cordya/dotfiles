#!/bin/bash
# Activate the Data Science Python environment
echo "Activating Data Science Python environment..."
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv activate datascience
echo "Data Science environment activated. Run 'pyenv deactivate' to exit."
