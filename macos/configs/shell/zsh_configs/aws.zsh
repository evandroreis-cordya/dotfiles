#!/bin/zsh
#
# AWS Configuration
# This file contains all AWS-related configurations
#

# Environment Variables
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-}"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
export AWS_PROFILE="${AWS_PROFILE:-default}"
export AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN:-}"

# AWS Configuration Directory
export AWS_CONFIG_DIR="$HOME/.aws"
export AWS_CONFIG_FILE="$AWS_CONFIG_DIR/config"
export AWS_SHARED_CREDENTIALS_FILE="$AWS_CONFIG_DIR/credentials"

# AWS AI Services
export AWS_BEDROCK_REGION="${AWS_BEDROCK_REGION:-us-east-1}"
export AWS_SAGEMAKER_REGION="${AWS_SAGEMAKER_REGION:-us-east-1}"

# Aliases
alias aws-profile="aws configure list-profiles"
alias aws-region="aws configure get region"
alias aws-whoami="aws sts get-caller-identity"
alias s3-ls="aws s3 ls"
alias ec2-ls="aws ec2 describe-instances"

# Functions
aws_setup() {
    if [[ -z "$AWS_ACCESS_KEY_ID" ]]; then
        echo "Warning: AWS_ACCESS_KEY_ID not set. Please configure AWS credentials."
        return 1
    fi
    echo "AWS configuration is complete."
}

aws_profile_switch() {
    local profile="$1"
    if [[ -z "$profile" ]]; then
        echo "Usage: aws_profile_switch <profile_name>"
        return 1
    fi
    export AWS_PROFILE="$profile"
    echo "Switched to AWS profile: $profile"
}

# Tool-specific setup
if command -v aws &> /dev/null; then
    # Initialize AWS CLI if available
    aws_setup
fi
