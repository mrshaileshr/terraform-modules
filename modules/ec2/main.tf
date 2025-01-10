resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnets[0]
  security_groups = [var.security_group_id]
}

resource "aws_security_group" "eks_worker_sg" {
  vpc_id = var.vpc_id

   egress { 
    from_port = 0 
    to_port = 0 
    protocol = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    cidr_blocks = [var.vpc_cidr_block]
    from_port    = 443
    to_port      = 443
    protocol     = "tcp"
  }
}
