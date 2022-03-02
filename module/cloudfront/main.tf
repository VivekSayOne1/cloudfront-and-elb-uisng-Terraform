#locals {
#  s3_origin_id = "myS3Origin"
#}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.s3_domain
    #origin_id   = local.s3_origin_id
     origin_id   = "mys3"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_cloudfront.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "terraform-cloudfront"
  default_root_object = "index.html"

  #logging_config {
   # include_cookies = false
    #bucket          = ""
    #prefix          = "myprefix"
#}
default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    #target_origin_id = local.s3_origin_id
    target_origin_id = "mys3"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    compress               =  true
    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  

   restrictions {
    geo_restriction {
      restriction_type = "none"
      #locations        = [""]
    }
  }

 

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


resource "aws_cloudfront_origin_access_identity" "s3_cloudfront" {
  comment = "Some comment"
}
