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
