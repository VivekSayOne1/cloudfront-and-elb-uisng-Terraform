resource "aws_elasticsearch_domain" "terraform" {
  domain_name           = "terraform-test"
  elasticsearch_version = var.elasticsearch_version
    


  cluster_config {
    instance_count = var.instance_count
    instance_type  = "t3.small.elasticsearch"
  
 }
  ebs_options {
      ebs_enabled = true
      volume_size = var.volume_size
  }
  advanced_security_options {
     enabled = true
     master_user_options {
       master_user_arn = "arn:aws:iam::857364090741:user/new"
     }
     
  }
  node_to_node_encryption {
    enabled = true
  }
  encrypt_at_rest {
     enabled = true
   }
  domain_endpoint_options {
     enforce_https = true
     tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
   }    
  tags = {
    Domain = "terraform"
  }
}
/*
resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = aws_elasticsearch_domain.terraform.domain_name
  access_policies = <<POLICIES
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::857364090741:user/new"
        ]
      },
      "Action": [
        "es:*"
      ],
      "Resource": "arn:aws:es:ap-south-1:857364090741:domain/terraform-test/*"
    }
  ]
}
POLICIES
}
*/
