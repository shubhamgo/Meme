resource "aws_s3_bucket" "data_bucket" {
  bucket = "${var.s3_bucket}"
  acl    = "private"

  tags = {
    
    application_name = "${var.application_name}"
  }
}