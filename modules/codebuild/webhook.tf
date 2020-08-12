resource "aws_codebuild_webhook" "this" {
  count = var.create_webhook ? 1 : 0

  project_name = aws_codebuild_project.this.name

  filter_group {
    dynamic "filter" {
      for_each = var.filter_rule
      content {
        type    = lookup(filter.value, "type")
        pattern = lookup(filter.value, "pattern")
      }
    }
  }
}