output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.public-subnet1.id
}
output "public_subnet2_id" {
  value = aws_subnet.public-subnet2.id
}
output "public_subnet3_id" {
  value = aws_subnet.public-subnet3.id
}

output "project-name" {
  value = var.project-name
}