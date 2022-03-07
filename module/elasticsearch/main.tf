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

  
}
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
          "arn:aws:iam::857364090741:user/terraform"
        ]
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:es:ap-south-1:857364090741:domain/terraform/*"
    }
  ]
}
POLICIES
}
