resource "aws_acm_certificate" "acm" {
  domain_name       = "sayonewar123.tk"
  validation_method = "DNS"
}


resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn         = aws_acm_certificate.acm.arn
  validation_record_fqdns = [for record in var.route53_record : record.fqdn]
}
