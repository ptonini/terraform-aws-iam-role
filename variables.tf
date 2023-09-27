variable "name" {
  default = null
}

variable "assume_role_policy_statements" {
  default = null
}

variable "policy_statements" {
  default = []
}

variable "policy_arns" {
  type    = list(string)
  default = []
}