# VPC
output "vpc_id" {
  value = aws_vpc.mainvpc.id
}

output "vpc_arn" {
  value = aws_vpc.mainvpc.arn
}

# Subnet
output "subnet_public1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "subnet_private1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "subnet_public2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "subnet_private2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "subnet_private3_id" {
  value = aws_subnet.private_subnet_3.id
}

output "subnet_private4_id" {
  value = aws_subnet.private_subnet_4.id
}

output "subnet_public1_arn" {
  value = aws_subnet.public_subnet_1.arn
}

output "subnet_private1_arn" {
  value = aws_subnet.private_subnet_1.arn
}

output "subnet_public2_arn" {
  value = aws_subnet.public_subnet_2.arn
}

output "subnet_private2_arn" {
  value = aws_subnet.private_subnet_2.arn
}

output "subnet_private3_arn" {
  value = aws_subnet.private_subnet_3.arn
}

output "subnet_private4_arn" {
  value = aws_subnet.private_subnet_4.arn
}

# Internet gateway
output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "igw_arn" {
  value = aws_internet_gateway.igw.arn
}

# NAT Gateway
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}

output "nat_gateway_eip_id" {
  value = aws_eip.nat_eip.id
}
