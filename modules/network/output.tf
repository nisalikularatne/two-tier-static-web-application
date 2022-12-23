# Add output variables
output "public_subnet_ids" {
  value = aws_subnet.publicSubnet[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.privateSubnet[*].id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}
output "vpc_id" {
  value = aws_vpc.main.id
}
