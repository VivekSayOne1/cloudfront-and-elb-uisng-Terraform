resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = var.tags
}
resource "aws_subnet" "terraform-subnet" {
  vpc_id  = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.1.0/24"
  
   availability_zone = var.availability_zone


tags = var.tags
}
resource "aws_subnet" "terraform-subnet2" {
  vpc_id  = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.3.0/24"

   availability_zone = var.availability_zone2


tags = var.tags
}
resource "aws_internet_gateway" "terraform-gw" {
  vpc_id = aws_vpc.terraform-vpc.id
}
resource "aws_route_table" "terraform-route-table" {
vpc_id = aws_vpc.terraform-vpc.id 
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.terraform-gw.id
}
}
resource "aws_route_table_association" "terraform-asso" {
  subnet_id = aws_subnet.terraform-subnet.id
  route_table_id = aws_route_table.terraform-route-table.id
  
}
resource "aws_route_table_association" "terraform-asso2" {
  subnet_id = aws_subnet.terraform-subnet2.id
  route_table_id = aws_route_table.terraform-route-table.id
  
}
