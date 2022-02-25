output "s3" {
 value = aws_s3_bucket_website_configuration.s3-website.id
}
output "domain" {
 value = aws_s3_bucket.terraform-s3.bucket_regional_domain_name
}
