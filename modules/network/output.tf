# Add output variables
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}
output "vpc_id" {
  value = aws_vpc.main.id
}
