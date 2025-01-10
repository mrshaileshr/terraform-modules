resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id 
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-2a"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-west-2b"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
resource "aws_eip" "nat" { 
  domain   = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  egress { 
    from_port = 0 
    to_port = 0 
    protocol = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port    = 80
    to_port      = 80
    protocol     = "tcp"
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main.id

  egress { 
    from_port = 0 
    to_port = 0 
    protocol = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    cidr_blocks = [aws_vpc.main.cidr_block]
    from_port    = 3306
    to_port      = 3306
    protocol     = "tcp"
  }
}
output "cidr" {
  value = aws_vpc.main.cidr_block
}
output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_sg_id" { 
  value = aws_security_group.public_sg.id 
  }
output "private_sg_id" { 
  value = aws_security_group.private_sg.id 
  }
output "public_subnets" {
  value = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "private_subnets" {
  value = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}
