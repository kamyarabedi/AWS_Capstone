variable "region_us_east_1" {
  type        = string
  description = "value for the region"
  default     = "us-east-1"
}

variable "aws_availability_zone_a" {
  type        = string
  description = "value for the availability zone"
  default     = "us-east-1a"
}

variable "aws_availability_zone_b" {
  type        = string
  description = "value for the availability zone"
  default     = "us-east-1b"
}

variable "aws_instance_type_t2micro" {
  type        = string
  description = "value for the instance type"
  default     = "t2.micro"
}

## Extra variables
variable "key_pair_name" {
  description = "Existing EC2 SSH key pair in us-east-1"
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

