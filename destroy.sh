#!/usr/bin/env bash

terraform init
terraform workspace list

# Select and destroy desired environment
terraform workspace select $env_name
terraform destroy -auto-approve

# Switch to default workspace and remove S3 objects
terraform workspace select default
terraform workspace delete $env_name