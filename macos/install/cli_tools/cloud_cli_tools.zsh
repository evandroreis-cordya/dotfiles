#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../utils.zsh"

print_in_purple "
   Cloud CLI Tools

"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Amazon Web Services (AWS)
brew_install "AWS CLI" "awscli"
brew_install "AWS SAM CLI" "aws-sam-cli"
brew_install "AWS CDK" "aws-cdk"

# Google Cloud Platform (GCP)
brew_install "Google Cloud SDK" "google-cloud-sdk"
brew_install "Firebase CLI" "firebase-cli"

# Microsoft Azure
brew_install "Azure CLI" "azure-cli"
brew_install "Azure Functions Core Tools" "azure-functions-core-tools@4"

# Oracle Cloud Infrastructure (OCI)
brew_install "OCI CLI" "oci-cli"

# IBM Cloud
brew_install "IBM Cloud CLI" "ibmcloud-cli"

# Multi-Cloud and DevOps Tools
brew_install "Terraform" "terraform"
brew_install "Pulumi" "pulumi"
brew_install "Kubernetes CLI" "kubernetes-cli"
brew_install "Helm" "helm"
brew_install "Docker" "docker"

# Cloud Development Tools
brew_install "Vercel CLI" "vercel"
brew_install "Netlify CLI" "netlify-cli"
brew_install "Heroku CLI" "heroku"

print_in_green "
  Cloud CLI tools installation complete!
"
