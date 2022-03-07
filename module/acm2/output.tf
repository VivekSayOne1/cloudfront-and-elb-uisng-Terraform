output "acm_domain_options2" {
   value = aws_acm_certificate.acm2.domain_validation_options
}
output "acm_cert2" {
  value = aws_acm_certificate.acm2.id
}