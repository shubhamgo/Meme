
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

// frontend ec2

 resource "aws_instance" "front_end" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  key_name      = "Application"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  iam_instance_profile = "${var.iam_instance_profile_id}"



  subnet_id = "${var.frontend_security_group_id}"

  vpc_security_group_ids = [
    "${var.security_group}"
  ]

  tags = {
    Name = "${var.application_name}-frontend"
    createdBy = "infra-${var.iam_instance_profile_id}/news"
  }

  connection {
    host = "${self.public_ip}"
    type = "ssh"
     agent = false
    user = "ec2-user"
    private_key = "${file("${path.module}/Application.pem")}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision-docker.sh"
  }
}


// quotes application

resource "aws_instance" "quotes" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  key_name      = "Application"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  iam_instance_profile = "${var.iam_instance_profile_id}"


  subnet_id = "${var.quotes_security_group_id}"

  vpc_security_group_ids = [
   "${var.security_group}"
  ]

  tags = {
    Name = "${var.application_name}-quotes"
    createdBy = "infra-${var.iam_instance_profile_id}/news"
  }

  connection {
    host = "${self.public_ip}"
    type = "ssh"
     agent = false
    user = "ec2-user"
    private_key = "${file("${path.module}/Application.pem")}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision-docker.sh"
  }
}

// news-feed

resource "aws_instance" "newsfeed" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  key_name      = "Application"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  iam_instance_profile = "${var.iam_instance_profile_id}"


  subnet_id = "${var.newsfeed_security_group_id}"

  vpc_security_group_ids = [
    "${var.security_group}"
  ]

  tags = {
  Name = "${var.application_name}-newsfeed"
    createdBy = "infra-${var.iam_instance_profile_id}/news"
  }

  connection {
    host = "${self.public_ip}"
    type = "ssh"
     agent = false
    user = "ec2-user"
    private_key = "${file("${path.module}/Application.pem")}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision-docker.sh"
  }
}


/* working 
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  iam_instance_profile  = "${var.iam_instance_profile_id}"
  subnet_id ="${var.subnet_public1_id}"
  security_groups  =["${var.security_group}"]
   user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

    tags = {
    
    product_id  = "${var.application_name}"
  }
} */