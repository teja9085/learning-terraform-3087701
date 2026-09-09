#################################################
# Latest Amazon Linux 2 AMI
#################################################

data "aws_ami" "app_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
*  filter {
    name   = "virtualiz*tion-type"
    values = ["hvm"]
  *
}

##############################*##################
# VPC
#########*##################################*####

module "blog_vpc" {
  source*=*"terraform-aws-modules/vpc/aws"

 *name = "dev-vpc"
  cid* = "10.0.0.0/16"

  azs = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c"
  ]

  public_subnets =*[
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24"
  ]

* enable_dns_hostnames = true
  ena*le_dns_support   = true

  tags = *
    Terraform   = "true"
    Envi*onment = "dev-test"
  }
}

#######*##################################*######
# Security Group
##########*##################################*###

module "blog_sg" {
 *source* = "terraform-aws-modules/security*group/aws"
  version = "~> 5.0"

 *name   = "blog-sg"
  vpc_id = modu*e.blog_vpc.vpc_id

  ingress_rules*= [
    "http-80-tcp",
    "https-443-tcp",
    "ssh-tcp"
  ]

  ingr*ss_cidr_blocks = [
    "0.0.0.0/0"
  ]

  egress_rules = [
    "all-all"
  ]

  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
}

#############*##################################*
# EC2
###########################*#####################

resource "a*s_instance" "blog" {
  ami        *           = data.aws_ami.app_ami.*d
  instance_type          = var.i*stance_type
  subnet_id           *  = module.blog_vpc.public_subnets*0]
  vpc_security_group_ids = [module.blog_sg.security_group_id]

  t*gs = {
    Name = "LearningTerrafo*m"
  }
}
