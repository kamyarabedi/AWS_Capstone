output "alb_dns_name" { value = aws_lb.capstone_lb.dns_name }
output "bastion_public_ip" { value = aws_instance.bastion.public_ip }
output "efs_id" { value = aws_efs_file_system.wordpress.id }
output "artifacts_bucket" { value = aws_s3_bucket.artifacts.id }
