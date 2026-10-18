# Regional shared WordPress file storage, mounted in both AZs.
resource "aws_efs_file_system" "wordpress" {
  creation_token = "kamyar-wordpress-efs"
  encrypted = true
  performance_mode = "generalPurpose"
  tags = { Name = "kamyar-WordPress-EFS" }
}
resource "aws_efs_mount_target" "private_a" {
  file_system_id = aws_efs_file_system.wordpress.id
  subnet_id = aws_subnet.private_subnet_1.id
  security_groups = [aws_security_group.efs.id]
}
resource "aws_efs_mount_target" "private_b" {
  file_system_id = aws_efs_file_system.wordpress.id
  subnet_id = aws_subnet.private_subnet_2.id
  security_groups = [aws_security_group.efs.id]
}
resource "aws_security_group" "efs" {
  name = "kamyar-efs-sg"
  vpc_id = aws_vpc.aws_capstone_vpc.id
  tags = { Name = "kamyar-EFS-SG" }
}
resource "aws_vpc_security_group_ingress_rule" "efs_nfs" {
  security_group_id = aws_security_group.efs.id
  referenced_security_group_id = aws_security_group.aws_webserver_sg.id
  from_port = 2049
  to_port = 2049
  ip_protocol = "tcp"
}
