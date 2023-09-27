resource "aws_iam_role" "this" {
  name = var.name
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.assume_role_policy_statements
  })
  tags = {}
}

resource "aws_iam_role_policy" "this" {
  count = length(var.policy_statements) > 0 ? 1 : 0
  role  = aws_iam_role.this.id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.policy_statements
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = { for i, v in var.policy_arns : i => v }
  role       = aws_iam_role.this.id
  policy_arn = each.value
}