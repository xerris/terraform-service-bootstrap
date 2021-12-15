
resource "null_resource" "image_base_build" {

  triggers = {
    image_sha = "image_base_build-${local.image_patch_version}"
  }

  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password  --region ${var.region} | docker login \
              --username AWS \
              --password-stdin ${local.base_ecr_url}
      echo "############ building Image and tagging with sha ############"
      cd ..
      docker build . --build-arg NODE_ENV=${local.node_env} -t ${local.base_ecr_url}:${local.image_version} -f Dockerfile
      echo "############ Tagging Image ############"
      docker tag ${local.base_ecr_url}:${local.image_version} ${local.base_ecr_url}:latest
      docker tag ${local.base_ecr_url}:${local.image_version} ${local.base_ecr_url}:${var.env}
      echo "############ Pushing Image ############"
      docker push ${local.base_ecr_url}
      docker push ${local.base_ecr_url}:${var.env}
      docker push ${local.base_ecr_url}:${local.image_version}
      EOT
  }
}
