resource "aws_key_pair" "capstone" {
  key_name   = "capstone-key"
  public_key = file("${path.module}/capstone-key.pub")

  tags = {
    Name = "capstone-key"
  }
}