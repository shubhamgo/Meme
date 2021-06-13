resource "aws_iam_instance_profile" "test_profile" {
  name = "${var.iam_instance_profile_role_name}"
  role = aws_iam_role.ec2_role.name

    tags = {
    
    product_id  = "${var.application_name}"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.iam_instance_profile_role_name}"
  path = "/"
    tags = {
    
    product_id  = "${var.application_name}"
  }

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

