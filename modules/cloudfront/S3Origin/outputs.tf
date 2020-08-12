output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "hosted_zone_id" {
  value = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}

output "endpoint_cloudfront" {
  value = aws_route53_record.cloudfront-endpoint.*.fqdn
}

output "arn" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}