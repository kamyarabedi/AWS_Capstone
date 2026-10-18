variable "key_pair_name" {
  description = "Existing EC2 SSH key pair in us-west-2"
  type = string
  default = "vockey"
}
variable "ssh_ingress_cidr" {
  description = "Your trusted public IPv4 CIDR for bastion SSH (set explicitly)"
  type = string
  default = "127.0.0.1/32"
}
variable "db_password" {
  description = "RDS WordPress password; supply using TF_VAR_db_password or a secret store"
  type = string
  sensitive = true
}
