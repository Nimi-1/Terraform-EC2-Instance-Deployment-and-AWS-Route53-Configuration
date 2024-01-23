# create a vpc

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.project-name}-vpc"
  }
}

##########################################################################################

# create a public subnet

resource "aws_subnet" "public-subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 4, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project-name}-public-subnet1"
  }
}
resource "aws_subnet" "public-subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 4, 1)
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project-name}-public-subnet2"
  }
}
resource "aws_subnet" "public-subnet3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 4, 2)
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project-name}-public-subnet3"
  }
}
##########################################################################################

# create an internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project-name}-igw"
  }
}

##########################################################################################

# create a route table

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project-name}-public-route-table"
  }
}

##########################################################################################

# associate the route table with the public subnet

resource "aws_route_table_association" "public-subnet-route-table-association" {
 
   count  = 3
  subnet_id      = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id, aws_subnet.public-subnet3.id][count.index]
  route_table_id = aws_route_table.public-route-table.id
}

##########################################################################################

