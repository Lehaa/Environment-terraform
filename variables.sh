#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
set -e
# Function to test input parameter and validate

validate_environment_name () {
  environment_name=$1
  regex="^[A-Za-z0-9\-]+$"
  if [ -z "$1" ]; then
    echo "The \"environment_name\" parameter is mandatory"
    return 1

  elif [[ ${#environment_name} -gt 32 ]]; then
    echo "The \"environment_name\" parameter must have lenght less than or equal to 32"
    return 1

  elif [[ ! $environment_name =~ $regex ]]; then
    echo "The \"environment_name\" parameter must only contain alphanumeric characters and dashes"
    return 1

  else
  echo "all good"
  fi
}

validate_environment_name $1

source $SCRIPT_DIR/terraform.sh
