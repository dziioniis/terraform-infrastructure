
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
 vpc_id = aws_vpc.vpc.id
 
 tags = {
   Name = "VPC IG"
 }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    "Name" = "Public Route Table"
    "VPC"  = "AWS_NETWORKING"
  }
}

resource "aws_route_table_association" "subnet_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags =  {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_security_group" "default" {
  name_prefix = "default-"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
}

