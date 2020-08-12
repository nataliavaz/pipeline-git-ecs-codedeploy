resource "aws_codecommit_repository" "repos" {
  repository_name = "example"
  description     = "Repositorio Exemplo"
  tags            = local.tags
}

resource "aws_ecr_repository" "repos" {
  name = "example"
  tags = local.tags
}


