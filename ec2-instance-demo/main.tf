resource "aws_vpc" "demo-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Demo subnet"
  }
}

resource "aws_security_group" "demo-sg" {
#  depends_on = [aws_vpc.demo-vpc]
  vpc_id = aws_vpc.demo-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "SSH"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

  tags = {
    Name = "tf-demo-sg"
    Environment = "Training"
  }
}

data "template_file" "user_data_file" {
  template = file("${path.module}/userdata.tpl")
}

resource "aws_instance" "demo-instance" {
  instance_type = "t2.micro"
  ami = "ami-06791f9213cbb608b"
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  subnet_id = aws_subnet.demo-subnet.id
  user_data = data.template_file.user_data_file.rendered
  tags = {
    Name = "demo-ec2-instance"
    Environment = "Training"
  }
}

output "ec2_global_ips" {
  value = [aws_instance.demo-instance.*.public_ip]
}
output "vpcIds" {
  value = [aws_vpc.demo-vpc.id]
}