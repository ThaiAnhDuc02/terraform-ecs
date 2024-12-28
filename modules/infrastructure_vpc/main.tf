# Setup VPC
resource "aws_vpc" "mainvpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.network_root_name}-vpc"
    Type = "VPC"
    Author = var.author
  }
}

# Setup subnet public 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.network_root_name}-subnet-public1-${var.region}a"
    Type = "Subnet"
    Author = var.author
  }
}

# Setup subnet private 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.128.0/20"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.network_root_name}-subnet-private1-${var.region}a"
    Type = "Subnet"
    Author = var.author
  }
}

# Setup subnet public 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.network_root_name}-subnet-public2-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

# Setup subnet private 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.144.0/20"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.network_root_name}-subnet-private2-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

# Setup subnet private 3
resource "aws_subnet" "private_subnet_3" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.32.0/20"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.network_root_name}-subnet-private3-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

# Setup subnet private 4
resource "aws_subnet" "private_subnet_4" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.64.0/20"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.network_root_name}-subnet-private4-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

## Setup internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = "${var.network_root_name}-igw"
    Type = "Internet-Gateway"
    Author = var.author
  }
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc" 

  tags = {
    Name = "${var.network_root_name}-nat-eip"
    domain = "vpc"
    Author = var.author
  }
}

# Create the NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_2.id  # Use one of your public subnets

  tags = {
    Name = "${var.network_root_name}-nat-gateway"
    Type = "NAT-Gateway"
    Author = var.author
  }
}

## Setup route table public
resource "aws_route_table" "public_route_table_1" {
  vpc_id = aws_vpc.mainvpc.id

  # Internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  # Local
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.network_root_name}-rtb-public"
    Type = "Route-Table"
    Author = var.author
  }
}

## Setup route table private 1 and 2
resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.mainvpc.id

  # Local
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.network_root_name}-rtb-private"
    Type = "Route-Table"
    Author = var.author
  }
}

## Setup route table private 3 and 4
resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.mainvpc.id

  # Local
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  # Route for internet access via NAT Gateway
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.network_root_name}-rtb-private2"
    Type = "Route-Table"
    Author = var.author
  }
}

## Add Subnet for Route table (edit association)
resource "aws_route_table_association" "public_association_1" {
  route_table_id = aws_route_table.public_route_table_1.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_association_2" {
  route_table_id = aws_route_table.public_route_table_1.id
  subnet_id = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "private_association_1" {
  route_table_id = aws_route_table.private_route_table_1.id
  subnet_id = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private_association_2" {
  route_table_id = aws_route_table.private_route_table_1.id
  subnet_id = aws_subnet.private_subnet_2.id
}

resource "aws_route_table_association" "private_association_3" {
  route_table_id = aws_route_table.private_route_table_2.id
  subnet_id = aws_subnet.private_subnet_3.id
}

resource "aws_route_table_association" "private_association_4" {
  route_table_id = aws_route_table.private_route_table_2.id
  subnet_id = aws_subnet.private_subnet_4.id
}