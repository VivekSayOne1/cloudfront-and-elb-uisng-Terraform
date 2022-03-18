output "acm_cert" {
  value = aws_acm_certificate.acm.id
}
output "acm_domain_options" {
   value = aws_acm_certificate.acm.domain_validation_options
}
