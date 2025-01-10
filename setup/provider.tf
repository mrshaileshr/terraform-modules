provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "../modules/vpc"
}


module "ec2" {
  source = "../modules/ec2"
  ami_id = "ami value"
  instance_type = "instance type"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  security_group_id = module.vpc.public_sg_id
  vpc_cidr_block = module.vpc.cidr
}

# module "eks" {
#   source = "../modules/eks"
#   vpc_id = module.vpc.vpc_id
#   private_subnets = module.vpc.private_subnets
# }

module "storage" {
  source = "../modules/s3andefs"
  private_subnets = module.vpc.private_subnets
}

module "rds"{
  source = "../modules/rds"
  privateSecuritygp = module.vpc.private_sg_id
  private_subnets = module.vpc.private_subnets
  password = "adv"
}

module "iam" {
  source = "../modules/iam"
}
