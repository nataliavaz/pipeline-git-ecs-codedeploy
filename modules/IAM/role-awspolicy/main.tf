//modulo para criação de role com políticas gerenciadas pela AWS
resource "aws_iam_role" "role" {
  name = "role-${var.name}"

  tags = var.tags
  assume_role_policy = templatefile("${path.module}/../../../templates/policy_assume_role.json",
    {
      service = var.service
  })

}

resource "aws_iam_role_policy_attachment" "attach_role" {
  role       = aws_iam_role.role.name
  policy_arn = var.policy_arn
}