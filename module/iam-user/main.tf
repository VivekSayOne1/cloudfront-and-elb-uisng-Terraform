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

