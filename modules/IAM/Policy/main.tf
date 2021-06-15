resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"
  tags = {
    
    product_id  = "${var.application_name}"
  }
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      
   
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:ListStorageLensConfigurations",
                "s3:ListAccessPointsForObjectLambda",
                "s3:GetAccessPoint",
                "s3:PutAccountPublicAccessBlock",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:ListAccessPoints",
                "s3:ListJobs",
                "s3:PutStorageLensConfiguration",
                "s3:CreateJob"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::test-bucket-iowiow8989998"
        }
    ]

    
  })
}