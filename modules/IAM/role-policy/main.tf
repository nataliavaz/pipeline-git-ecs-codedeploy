//modulo para criação de role com politicas próprias
resource "aws_iam_role" "role" {
  name = "role-${var.name}"

  tags = var.tags
  assume_role_policy = templatefile("${path.module}/../../../templates/policy_assume_role.json",
    {
      service = var.service
  })

}

resource "aws_iam_policy" "policy" {
  name = "policy-${var.name}"
  path = "/"
  //role = aws_iam_role.role.id

  policy = var.policy
}

resource "aws_iam_policy_attachment" "policy_attachment" {
  name       = "attachment-${aws_iam_role.role.name}"
  roles      = ["${aws_iam_role.role.name}"]
  policy_arn = aws_iam_policy.policy.arn
}
