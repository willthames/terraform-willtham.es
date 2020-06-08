#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <environment>"
  exit
fi

set -eu

ENVIRONMENT=${1}

if [ -f .terraform/terraform.tfstate ]; then
  mv ./.terraform/terraform.tfstate ./.terraform/terraform.backup.$(date +%Y%m%d-%H%M%S).tfstate
fi

terraform init \
    -backend-config "region=us-west-2" \
    -backend-config "bucket=skedulo-${ENVIRONMENT}-terraform-state" \
    -backend-config "key=${ENVIRONMENT}/link.skedulo.com/terraform.tfstate"

