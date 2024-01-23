# create a hosted zone
resource "aws_route53_zone" "r53-zone" {
  name = var.domain_name
}

# create a record for domain
resource "aws_route53_record" "domain" {
  zone_id = aws_route53_zone.r53-zone.zone_id
  name    = var.sub_domain_name
  type    = "A"

  alias {
    name                           = var.load_balancer-dns-name
    zone_id                        = var.load_balancer-zone-id
    evaluate_target_health         = true
  }
}

