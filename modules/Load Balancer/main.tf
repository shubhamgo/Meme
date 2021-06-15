data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_elb" "test" {
  
  name               = "${var.test_elb}"
  
  security_groups    = ["${var.security_group}"]
   subnets            = ["${var.subnet_public1_id}","${var.subnet_private1_id}"]
  internal ="false"

   listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8080
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "http"
    #ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }
  

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }
 idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  instances                   = ["${var.ec2_id}"]
  

  
  
    tags = {
    
    product_id  = "${var.application_name}"
  }
  
  

  
}

