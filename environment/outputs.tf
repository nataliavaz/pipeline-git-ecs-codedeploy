
output "endpoint_app" {
  value = join(",", "${module.cloudfront.endpoint_cloudfront}")
}
