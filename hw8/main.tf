provider "aws" {
  region = "eu-north-1"
  profile = "hillel"
}

module "ec2" {
  source                = "ec2"
  public_instance_type  = "t3.micro"
  private_instance_type = "t3.micro"
  public_subnet_id      = module.networking.public_subnet_id
  private_subnet_id     = module.networking.private_subnet_id

}

module "networking" {
  source              = "networking"
  vpc_cidr            = "10.0.0.0/16"
  private_subnet_cidr = "10.0.101.0/24"
  public_subnet_cidr  = "10.0.1.0/24"
}