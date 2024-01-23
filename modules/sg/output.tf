output "public_sg_id" {
  value = aws_security_group.public-sg.id
}


output "load_balancer_sg" {
  value = aws_security_group.load_balancer_sg.id
}