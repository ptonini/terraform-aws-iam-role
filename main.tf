resource "aws_iam_role" "this" {
  name = var.name
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.assume_role_policy_statement
  })
}

resource "aws_iam_role_policy" "this" {
  count = var.policy_statement == null ? 0 : 1
  role  = aws_iam_role.this.id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.policy_statement
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = { for i, v in var.policy_arns : i => v }
  role       = aws_iam_role.this.id
  policy_arn = each.value
}