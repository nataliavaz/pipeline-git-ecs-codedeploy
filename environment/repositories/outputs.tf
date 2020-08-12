output "codecommit_name" {
  value = aws_codecommit_repository.repos.repository_name
}
output "codecommit_arn" {
  value = aws_codecommit_repository.repos.arn
}

output "ecr_uri" {
  value = aws_ecr_repository.repos.repository_url
}

output "ecr_name" {
  value = aws_ecr_repository.repos.name
}

output "ecr_arn" {
  value = aws_ecr_repository.repos.arn
}