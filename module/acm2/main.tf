provider "aws" {
 access_key        =  
 secret_key        = 
 region            = "us-east-1"
    
}
resource "aws_acm_certificate" "acm2" {
  domain_name       = "cdn.sayonewar123.tk"
  validation_method = "DNS"
}


resource "aws_acm_certificate_validation" "acm_validation2" {
  certificate_arn         = aws_acm_certificate.acm2.arn
  validation_record_fqdns = [for record in var.route53_record3 : record.fqdn]
}
