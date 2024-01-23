output "load_balancer-arn" {
  value = aws_lb.load_balancer.arn
}
output "load_balancer-dns-name" {
  value = aws_lb.load_balancer.dns_name
}
output "load_balancer-zone-id" {
  value = aws_lb.load_balancer.zone_id
}