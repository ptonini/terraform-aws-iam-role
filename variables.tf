variable "name" {
  default = null
}

variable "assume_role_policy_statement" {
  default = null
}

variable "policy_statement" {
  type    = list(any)
  default = null
}

variable "policy_arns" {
  type    = list(string)
  default = []
}