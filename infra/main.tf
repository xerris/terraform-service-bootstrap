data "aws_caller_identity" "this" {}
data "aws_region" "current" {}

locals {
  ecr_address         = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
  image_major_version = "0"
  image_minor_version = "1"
  image_patch_version = format("%s-%s", var.build_number, var.commit_hash)
  image_version       = "${local.image_major_version}.${local.image_minor_version}.${local.image_patch_version}"
  base_image          = "${data.aws_caller_identity.this.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.env}-isengard-xerris-ecr:${local.image_version}"
  node_env = lookup({
    "dev"   = "development",
    "stage" = "stage",
    "prod"  = "production"
  }, var.env, "production")

  base_ecr_url = "${local.ecr_address}/${data.terraform_remote_state.platform-infra.outputs.ecr_name}"
}
