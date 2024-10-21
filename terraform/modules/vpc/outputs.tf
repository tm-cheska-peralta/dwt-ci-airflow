output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "nat_gateway_ip" {
  value = aws_eip.nat_gateway[0].public_ip
}

output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

output "database_subnets" {
  value = aws_subnet.database_subnet.*.id
}
