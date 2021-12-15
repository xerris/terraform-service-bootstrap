# Terraform-Service-bootstrap

## Introduction
This repository packages Lambda code as a Docker image via null resource in order for you to build and deploy workloads faster.  
The Terraform code is stored inside the infra folder.

## Prerequisites 
Terraform version 0.15.1
The  .terraform-version or version.tf works with tfenv . It will install if needed and switch to the Terrraform version specified.
# version.tf 
```
terraform {
  required_version = ">= 0.15"
}
```
# .terraform-version
```
terraform {
  required_version = ">= 0.15"
}
```

## Environment Variables

Environment variables needed to execute this deployment.

| Name | Value | Description |
|------|---------|--------|
|AWS_ACCESS_KEY_ID| n/a | n/a |
|AWS_SECRET_ACCESS_KEY| n/a | n/a |
|AWS_REGION | ca-central-1| n/a |
|ENV | \<env\>| n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.19 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | 2.11.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2 |

## Backend Requirements 
* Create Backend Bucket
* [Create Backend Dynamo Table](https://www.terraform.io/docs/language/settings/backends/s3.html#dynamodb-state-locking)


| Name | Version |
|------|---------|
| Bucket name | project-terraform-state-\<ENV\>|
| Table name | \<ENV\>-project-terraform-state-lock-dynamo |
| Key | LockID \(string\) |


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.38.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hello_lambda"></a> [hello\_lambda](#module\_hello\_lambda) | github.com/xerris/aws-modules//eventLambda | v1.3 |

## Resources

| Name | Type |
|------|------|
| [null_resource.image_base_build](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.platform-infra](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_number"></a> [build\_number](#input\_build\_number) | n/a | `string` | `"local"` | no |
| <a name="input_commit_hash"></a> [commit\_hash](#input\_commit\_hash) | n/a | `string` | `"local"` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | `"dev"` | no |
| <a name="input_hello_entrypoint"></a> [hello\_entrypoint](#input\_hello\_entrypoint) | n/a | `string` | `"lambda.helloHandler"` | no |
| <a name="input_infra_bucket"></a> [infra\_bucket](#input\_infra\_bucket) | n/a | `map(any)` | <pre>{<br>  "dev": "terraform-state-dev",<br>  "poc-xerris": "terraform-state-poc-xerris",<br>  "prod": "terraform-state-prod",<br>  "stage": "terraform-state-stage"<br>}</pre> | no |
| <a name="input_infra_file"></a> [infra\_file](#input\_infra\_file) | n/a | `map(any)` | <pre>{<br>  "dev": "dev/platform-infra.tfstate",<br>  "poc-xerris": "poc-xerris/platform-infra.tfstate",<br>  "prod": "prod/platform-infra.tfstate",<br>  "stage": "stage/platform-infra.tfstate"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |

## Outputs
No outputs.

## Execution Steps

* Initialize the Environment Variables

```
export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="YYYYYYYYYYYYYYYYYYYYYYYYY"
export AWS_REGION=ca-central-1
export ENV=<env>
```

The `terraform_exec.sh` script receives one parameter that indicates the action to be executed.

```
0 = Executes a terraform plan
1 = Executes a terraform apply
2 = Executes a terraform destroy
```


* Execute a Terraform Plan on the project folder

```
cd infra
bash terraform_exec.sh 0
```

* Execute a Terraform apply on the project folder

```
cd infra
bash terraform_exec.sh 1
```

* Execute a Terraform Destroy on the project folder

```
cd infra
bash terraform_exec.sh 1
```


