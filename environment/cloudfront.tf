resource "aws_cloudfront_origin_access_identity" "identity_teste" {
  comment = "access-identity-${var.environment}"
}

module "cloudfront" {
  source = "../modules/cloudfront/S3Origin"

  tags = local.tags

  origin_domain_name             = module.bucket-cloudfront.bucket_regional_domain_name
  origin_id                      = "S3-${module.bucket-cloudfront.name}"
  origin_access_identity         = aws_cloudfront_origin_access_identity.identity_teste.cloudfront_access_identity_path
  comment                        = "Frontend - ${var.environment}"
  alias                          = ["${var.frontend_url}"]
  price_class                    = "PriceClass_All"
  cloudfront_default_certificate = false
  certificate_arn                = data.aws_acm_certificate.acm.arn

  viewer_protocol_policy = "redirect-to-https"
  allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  default_root_object    = "index.html"
  cached_methods         = ["GET", "HEAD"]


  custom_error_responses = [
    {
      error_code            = 403
      error_caching_min_ttl = 300
      response_page_path    = "/index.html"
      response_code         = 200
    },
    {
      error_code            = 404
      error_caching_min_ttl = 300
      response_page_path    = "/index.html"
      response_code         = 200
    }
  ]

  restriction_type = "none"
  locations        = []

  create_dns_record   = true
  endpoint_cloudfront = "${var.frontend_url}"
  zone_id             = data.aws_route53_zone.main.id
}