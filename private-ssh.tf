# Allow private application SSH only from the bastion host security group.
resource "aws_security_group" "aws_private_ssh_sg" {
  name   = "kamyar-private-ssh-sg"
  vpc_id = aws_vpc.aws_capstone_vpc.id
  tags = { Name = "kamyar-PrivateSSH-SG" }
}
resource "aws_vpc_security_group_ingress_rule" "private_ssh_from_bastion" {
  security_group_id = aws_security_group.aws_private_ssh_sg.id
  referenced_security_group_id = aws_security_group.aws_ssh_sg.id
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "private_ssh_egress" {
  security_group_id = aws_security_group.aws_private_ssh_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}
