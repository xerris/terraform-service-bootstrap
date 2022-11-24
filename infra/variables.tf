variable "region" {
  default = "us-east-1"
}

variable "build_number" {
  default = "local"
}

variable "commit_hash" {
  default = "local"
}

variable "env" {
  default = "dev-allen"
}

variable "infra_bucket" {
  type = map(any)
  default = {
    dev-allen  = "project-terraform-state-dev-allen"
    stage      = "terraform-state-stage"
    prod       = "terraform-state-prod"
    poc-xerris = "terraform-state-poc-xerris"
  }
}

variable "infra_file" {
  type = map(any)
  default = {
    dev-allen  = "dev/platform-infra.tfstate"
    stage      = "stage/platform-infra.tfstate"
    prod       = "prod/platform-infra.tfstate"
    poc-xerris = "poc-xerris/platform-infra.tfstate"
  }
}
variable "hello_entrypoint" {
  default = "lambda.helloHandler"
}

