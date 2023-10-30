resource "aws_instance" "name" {
  instance_type = "t2.micro"
  ami = "ami-06791f9213cbb608b"

  tags = {
    Name = var.name
    Environment = "EC2 instance"
  }
}
