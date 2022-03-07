data "aws_route53_zone" "acm_zone" {
  name         = "sayonewar123.tk"
  private_zone = false
}

resource "aws_route53_record" "new_record" {
  for_each = {
    for dvo in var.acm_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.acm_zone.zone_id
  
}
resource "aws_route53_record" "new_record3" {
  for_each = {
    for dvo in var.acm_options2 : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.acm_zone.zone_id
  
}

resource "aws_route53_record" "new_record2" {
  zone_id = data.aws_route53_zone.acm_zone.zone_id
  name    = "sayonewar123.tk"
  type    = "A"
  #ttl     = "300"
  #records = [var.alb_dns]

  alias {
    name                   = var.alb_dns
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "new_record4" {
  zone_id = data.aws_route53_zone.acm_zone.zone_id
  name    = "cdn.sayonewar123.tk"
  type    = "A"
  #ttl     = "300"
  #records = [var.alb_dns]

  alias {
    name                   = var.cf_domain
    zone_id                = var.cf_zone_id
    evaluate_target_health = true
  }
}