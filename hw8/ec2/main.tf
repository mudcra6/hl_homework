# AWS Instances
resource "aws_instance" "public_instance" {
  ami           = "ami-0014ce3e52359afbd"
  instance_type = var.public_instance_type
  subnet_id     = var.public_subnet_id
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0014ce3e52359afbd"
  instance_type = var.private_instance_type
  subnet_id     = var.private_subnet_id
}