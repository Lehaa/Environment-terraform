#!/usr/bin/env bash

set -e

# Function to test input parameter and validate

declare -F validate_environment_name  &>/dev/null || validate_environment_name() {
  environment_name=(params.env_name)
  if [ -z (params.env_name) ]; then
    error "The \"environment_name\" parameter is mandatory"
    return 1
  fi
}