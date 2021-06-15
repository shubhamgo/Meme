
//load balancer sg 
resource "aws_security_group" "securitygroup_1" {
  name        = "test_sg_1"
  description = "Allow  inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    description      = "testing app"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

     tags = {
    
    product_id  = "${var.application_name}"
  }
}