#!/usr/bin/env bash

terraform init

terraform workspace new $env_name
terraform apply -auto-approve