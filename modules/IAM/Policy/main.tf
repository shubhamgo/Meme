resource "aws_iam_policy" "ECR_policy" {
  name        = "ECR_Full_Access"
  path        = "/"
  description = "ECR FUll acess"
  tags = {
    
    product_id  = "${var.application_name}"
  }
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ecr:*",
            "Resource": "*"
        }
   
       
       
    ]

    
  })
}