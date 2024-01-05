#### Network configuration


# Get available aws avail zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create the VPC, reference variables for IP network and DNS hostname
resource "aws_vpc" "VPC-1" {
  cidr_block           = var.vpc_network
  enable_dns_hostnames = var.enable_dns

  tags = {
    Name = "${local.naming_prefix}-VPC"
  }

}

# Create Internet Gateway for above created VPC
resource "aws_internet_gateway" "AIG-VPC-1" {
  vpc_id = aws_vpc.VPC-1.id

  tags = {
    Name = "${local.naming_prefix}-AIG"
  }
}

# Create subnet in above created VPC. Use variable subnet_count to set number of subnets
# Function cidrsubnet creates the subnets with a /27 mask
resource "aws_subnet" "subnets" {
  count                   = var.subnet_count
  cidr_block              = cidrsubnet(var.vpc_network, 3, count.index)
  vpc_id                  = aws_vpc.VPC-1.id
  map_public_ip_on_launch = var.map_public_ip
  availability_zone       = data.aws_availability_zones.available.names[(count.index % var.subnet_count)]

  tags = {
    Name = "${local.naming_prefix}-subnet-${count.index}"
  }
}

# Crate route table for above VPC
# Route default GW towards Internet Gateway created above
resource "aws_route_table" "RT-VPC-1" {
  vpc_id = aws_vpc.VPC-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.AIG-VPC-1.id
  }

  tags = {
    Name = "${local.naming_prefix}-RT"
  }
}

# Associate subnets with the route table
resource "aws_route_table_association" "RTA-VPC-1" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.RT-VPC-1.id
}

