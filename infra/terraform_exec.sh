#!/bin/bash
set -o nounset
set -o errexit


echo "###############################"
echo "## Starting Terraform script ##"
echo "###############################"

ENV="dev"
AWS_REGION="us-east-1"
ENV="${ENV:-dev}"
AWS_REGION="${AWS_REGION:-us-east-1}"

apply=${1:-0} #If set terraform will force apply changes
commit_hash=`git rev-parse --short HEAD`
build_number="${BITBUCKET_BUILD_NUMBER:=local}"
#export TF_LOG=TRACE
export TF_VAR_commit_hash="${commit_hash}"
export TF_VAR_build_number="${build_number}"

terraform init \
-backend-config="bucket=project-terraform-state-dev-allen" \
-backend-config="key=${ENV}/platform-service.tfstate" \
-backend-config="dynamodb_table= project-terraform-state-lock-dynamo" \
-backend-config="region=${AWS_REGION}" -reconfigure

terraform validate
terraform plan -var-file=envs/poc-xerris.tfvars -lock=false

if [[ $apply == 1 ]]; then
    echo "###############################"
    echo "## Executing terraform apply ##"
    echo "###############################"
    terraform apply --auto-approve -var-file=envs/poc-xerris.tfvars -lock=false
fi
