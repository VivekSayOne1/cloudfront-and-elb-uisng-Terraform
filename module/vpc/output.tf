output "vpcid" {
  value = aws_vpc.terraform-vpc.id
  
  
}
output "subnetid" {
  value = aws_subnet.terraform-subnet.id
}
output "gatewayid" {
  value = aws_internet_gateway.terraform-gw
}
output "subnetid2" {
  value = aws_subnet.terraform-subnet2.id
}
