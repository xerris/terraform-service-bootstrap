terraform {
  backend "s3" {
   
  }
}  

provider "aws" {
  region = var.region
  #shared_credentials_files = ["~/.aws/credentials"]
  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}


data "terraform_remote_state" "platform-infra" {
  backend = "s3"
  config = {
    bucket = var.infra_bucket[var.env]
    key    = var.infra_file[var.env]
    region = var.region
  }
}
