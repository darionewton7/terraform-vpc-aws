resource "aws_vpc" "aws-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name = "${var.prefix}-vpc"
  }
}

data "aws_availability_zones" "available_zones" {}
# output "azs" {
#   value = "${data.aws_availability_zones.available_zones.names}"
# }

resource "aws_subnet" "subnets" {
  count = 2
    availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id = aws_vpc.aws-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  } 
}

resource "aws_internet_gateway" "new_igw" {
  vpc_id = aws_vpc.aws-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
  
}

#Internet Gateway
resource "aws_route_table" "new_route_table" {
  vpc_id = aws_vpc.aws-vpc.id
  route {
  
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_igw.id
  }
  tags = {
    Name = "${var.prefix}-route-table"
  }
}


# route Teble
resource "aws_route_table_association" "new_route_table_association" {
  count = 2
  subnet_id = aws_subnet.subnets.*.id[count.index]
  route_table_id = aws_route_table.new_route_table.id
  depends_on = [aws_subnet.subnets]
  
}


# resource "aws_subnet" "aws-subnet-2" {
#     availability_zone = "us-east-1b"
#   vpc_id = aws_vpc.aws-vpc.id
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "${var.prefix}-subnet-2"
#   } 
# }