#!/usr/bin/env bash

set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "env file not found"
  exit 1
fi

# Ensure that stage is dev or prod
if [ "$stage" != "dev" ] && [ "$stage" != "prod" ]; then
  echo "stage must be either dev or prod!"
  exit 1
fi

# Initialize Terraform
TF_WORKSPACE=$stage terraform init -var-file=environment/$stage.tfvars
