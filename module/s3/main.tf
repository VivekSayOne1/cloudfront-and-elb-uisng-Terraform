resource "aws_s3_bucket" "terraform-s3" {
  bucket = var.bucket

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
/*
resource "aws_s3_bucket_acl" "s3-acl" {
  bucket = aws_s3_bucket.terraform-s3.id
  acl    = "private"
}*/



resource "aws_s3_bucket_website_configuration" "s3-website" {
  bucket = aws_s3_bucket.terraform-s3.bucket



  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  #routing_rule {
   # condition {
    #  key_prefix_equals = "docs/"
   # }
    #redirect {
     # replace_key_prefix_with = "documents/"
   # }
  #}
}

#resource "aws_s3_bucket_versioning" "versioning_example" {
  #bucket = aws_s3_bucket.terraform-s3.id
  #versioning_configuration {
   # status = "Enabled"
  #}
#}
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.terraform-s3.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
 statement {
     principals {
     type        = "AWS"
     identifiers = [var.cloudfront_origin_arn]
      #identifiers  = ["aws_iam_user.iam-user.id"]
    }  
    actions = [
       "s3:GetObject"
       
    ]

    resources = [
      
      "${aws_s3_bucket.terraform-s3.arn}/*",
     ]

          }
 /*
 statement {
     principals {
      type        = "AWS"
     identifiers = ["arn:aws:iam::857364090741:user/new"]
      #identifiers  = ["aws_iam_user.iam-user.id"]
    }  
    actions = [
       "s3:GetObject",
       "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.terraform-s3.arn,
      "${aws_s3_bucket.terraform-s3.arn}/*",    
     ]           
    
	  } */
}
