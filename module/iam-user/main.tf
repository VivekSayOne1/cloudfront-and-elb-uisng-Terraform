resource "aws_iam_user" "iam-user" {
    name = "max"
}
resource "aws_iam_user_policy" "new_policy" {
  name = "new"
  user = aws_iam_user.iam-user.id
policy = <<EOF
{
  "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutAccelerateConfiguration",
                "s3:PutAnalyticsConfiguration",
                "s3:PutBucketLogging",
                "s3:PutReplicationConfiguration",
                "s3:CreateBucket",
                "s3:PutBucketObjectLockConfiguration",
                "s3:PutBucketCORS"
            ],
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectRetention",
                "s3:PutObjectLegalHold"
            ],
            "Resource": "arn:aws:s3:::*/*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        }
    ]
}
EOF
}
resource "aws_iam_user_login_profile" "password-iam" {
  user    = aws_iam_user.iam-user.name
  pgp_key = "keybase:vivek1997"
  #password = "admin12345"
  password_reset_required = false
  
}

resource "aws_iam_role" "terraform_role" {
  name = "terraform_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  managed_policy_arns =    [aws_iam_policy.terra_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "terra_policy" {
    name = "terraform-policy1"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = [
                "es:DeleteDomain",
                "es:ESHttpGet",
                "cloudfront:GetInvalidation",
                "es:ESHttpDelete",
                "cloudfront:CreateInvalidation",
                "s3:PutObject",
                "s3:GetObject",
                "cloudwatch:PutMetricAlarm",
                "es:ESHttpHead",
                "cloudwatch:DescribeAlarmHistory",
                "cloudwatch:EnableAlarmActions",
                "cloudwatch:DisableAlarmActions",
                "es:ESHttpPost",
                "cloudfront:ListInvalidations",
                "es:DescribeDomains",
                "es:DescribeDomain",
                "cloudwatch:GetMetricStream",
                "cloudwatch:SetAlarmState",
                "es:ESHttpPut"
            ]
            Effect = "Allow"
            Resource = [
                "arn:aws:es:*:857364090741:domain/*",
                "arn:aws:s3:::*/*",
                "arn:aws:cloudwatch:*:857364090741:metric-stream/*",
                "arn:aws:cloudwatch:*:857364090741:alarm:*",
                "arn:aws:cloudfront::857364090741:distribution/*"
            ]
        },       
{  
            Effect: "Allow"
            Action: "s3:ListBucket"
            Resource: "arn:aws:s3:::*"
        },
        {   
            Effect: "Allow"
            Action: [
                "es:ListVersions",
                "es:ListDomainNames",
                "cloudwatch:PutMetricData",
                "s3:ListAllMyBuckets",
                "cloudwatch:GetMetricData",
                "es:CreatePackage",
                "cloudwatch:PutAnomalyDetector",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:ListMetrics",
                "es:ListElasticsearchVersions",
                "cloudwatch:DescribeAnomalyDetectors"
            ]
            Resource: "*"
        }
        
          ]
    })
  
  
}

resource "aws_iam_instance_profile" "terraform_profile" {
  name = "terraform_profile"
  role = aws_iam_role.terraform_role.name
}