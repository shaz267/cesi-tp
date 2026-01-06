module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "my-vpc"
  }
}

module "compute" {
  source      = "./modules/compute"
  name        = "nginx-server"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnets
  instance_type = "t3.micro"
  ami_id      = "ami-0c02fb55956c7d316"
  key_name    = "ma-cle-ssh"
  ssh_allowed_cidr = "203.0.113.0/24"
}