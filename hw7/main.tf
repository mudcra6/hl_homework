provider "aws" {
  region = "eu-north-1"
  profile = "hillel"
}

# AWS VPC
resource "aws_vpc" "hl_devops_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.hl_devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.hl_devops_vpc.id
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.hl_devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.hl_devops_vpc.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "eu-north-1b"
}

# Route Table for Private Subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.hl_devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }
}

# AWS NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "my_eip" {}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# AWS Instances
resource "aws_instance" "public_instance" {
  ami           = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_subnet.id
}
