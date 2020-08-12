resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id
    origin_path = var.origin_path

    s3_origin_config {
      origin_access_identity = var.origin_access_identity
    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.comment
  default_root_object = var.default_root_object

  #   logging_config {
  #     include_cookies = false
  #     bucket          = "mylogs.s3.amazonaws.com"
  #     prefix          = "myprefix"
  #   }

  aliases = var.alias

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = false
      headers      = []

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_responses
    content {
      error_code            = lookup(custom_error_response.value, "error_code", null)
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
      response_code         = lookup(custom_error_response.value, "response_code", null)
    }
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.locations
    }
  }

  tags = var.tags

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = var.certificate_arn
    minimum_protocol_version       = "TLSv1.2_2018"
    ssl_support_method             = "sni-only"
  }
}

resource "aws_route53_record" "cloudfront-endpoint" {
  count = var.create_dns_record ? 1 : 0

  zone_id = var.zone_id
  name    = var.endpoint_cloudfront
  type    = "A"


  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }

  lifecycle {
    prevent_destroy = false
  }
  depends_on = [aws_cloudfront_distribution.s3_distribution]
}