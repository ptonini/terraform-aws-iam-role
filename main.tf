resource "aws_iam_role" "this" {
  name = var.name
  assume_role_policy = coalesce(var.assume_role_policy, jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = var.assume_role_principal
      Effect = "Allow"
    }]
  }))
  tags = {}
  lifecycle {
    ignore_changes = [
      inline_policy,
      managed_policy_arns
    ]
  }
}

resource "aws_iam_role_policy" "this" {
  count = length(var.policy_statements) > 0 ? 1 : 0
  role = aws_iam_role.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = var.policy_statements
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {for i, v in var.policy_arns : i => v}
  role = aws_iam_role.this.id
  policy_arn = each.value
}

module "vault_role" {
  source = "github.com/ptonini/terraform-vault-aws-role?ref=v1"
  count = var.vault_role != null ? 1 : 0
  name = var.vault_role
  credential_type = var.vault_credential_type
  backend = var.vault_backend
  role_arns = [aws_iam_role.this.arn]
}