variable "s3_domain" {
 description = "s3 domain"
}
variable "allowed_methods" {
  description = "allowed methods we can define here"
}
variable "cached_methods" {
  description = "cached_methods we can define here"
}
variable "viewer_protocol_policy" {
  description = "viewer_protocol_policy we can define here"
}
variable "origin_id" {
  description = "added the origin name"
}
variable "acm_certificate" {
  description = "new acm2 certificate"
}