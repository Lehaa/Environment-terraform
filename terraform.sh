#!/usr/bin/env bash

aws configure list-profiles

terraform init

terraform workspace new $env_name
terraform apply -auto-approve