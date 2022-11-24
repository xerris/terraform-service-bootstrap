module "hello_lambda" {
  env           = var.env
  source        = "github.com/xerris/aws-modules//eventLambda?ref=v1.3"
  entrypoint    = var.hello_entrypoint
  function_name = "${var.env}-hello-xerris"
  description   = "Hello lambda function from container image"
  image         = local.base_image

  depends_on = [null_resource.image_base_build]

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}
