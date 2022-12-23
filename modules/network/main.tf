# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
}
# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}
# Local variables
locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}
# Create a new VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-VPC"
    }
  )
}
# Add provisioning of the public subnet in the the VPC
resource "aws_subnet" "publicSubnet" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-public-subnet-${count.index}"
    }
  )
}
# Add provisioning of the private subnet in the the VPC
resource "aws_subnet" "privateSubnet" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-private-subnet-${count.index}"
    }
  )
}
# Create Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-igw"
    }
  )
}
# Route table to route add default gateway pointing to Internet Gateway (IGW)
resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${local.name_prefix}-route-public-route_table"
  }
}

# Associate subnets with the custom route table
resource "aws_route_table_association" "publicRouteTableAssociation" {
  count          = length(aws_subnet.publicSubnet[*].id)
  route_table_id = aws_route_table.publicRouteTable.id
  subnet_id      = aws_subnet.publicSubnet[count.index].id
}
resource "aws_eip" "this" {
  vpc = true
  tags = {
    Name = "${local.name_prefix}-EIP"
  }
}
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.publicSubnet[1].id

  tags = {
    Name = "${local.name_prefix}-NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.this]
}
# Priviate Route table
resource "aws_route_table" "privateRouteTable" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "${local.name_prefix}-route-private-route-table"
  }
}

# Associate subnets with the custom route table
resource "aws_route_table_association" "privateRouteTableAssociation" {
  count          = length(aws_subnet.privateSubnet[*].id)
  route_table_id = aws_route_table.privateRouteTable.id
  subnet_id      = aws_subnet.privateSubnet[count.index].id
}
