#!/bin/bash
set -o nounset
set -o errexit


echo "###############################"
echo "## Starting Terraform script ##"
echo "###############################"

ENV="${ENV:-dev}"
AWS_REGION="${AWS_REGION:-us-east-1}"

apply=${1:-0} #If set terraform will force apply changes
commit_hash=`git rev-parse --short HEAD`
build_number="${BITBUCKET_BUILD_NUMBER:=local}"
#export TF_LOG=TRACE
export TF_VAR_commit_hash="${commit_hash}"
export TF_VAR_build_number="${build_number}"

terraform init \
-backend-config="bucket=dev-ginu-s3-newbucket" \
-backend-config="key=alias/platform-service-ginu.tfstate" \
-backend-config="dynamodb_table=ginu-table-state-lock" \
-backend-config="region=${AWS_REGION}"

terraform validate 
terraform plan -var-file=envs/${ENV}.tfvars

if [ $apply == 1 ]; then
    echo "###############################"
    echo "## Executing terraform apply ##"
    echo "###############################"
    terraform apply --auto-approve -var-file=envs/${ENV}.tfvars
fi
