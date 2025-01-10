variable "ami_id"{
     description = "ami"
}

variable "instance_type" {
  description = "instance type"
}
variable "vpc_id" {
  description = " vpic id"
}
variable "public_subnets" {
  description = "subnet"
}
variable "security_group_id" {
  description = "jenkins security"
}
variable "vpc_cidr_block" {
  description = "cidrBlock for vpc"
}