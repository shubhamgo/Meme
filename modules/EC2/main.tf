
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



  subnet_id = "${var.subnet_public1_id}"

  vpc_security_group_ids = [
    "${var.frontend_security_group_id}"
  ]
    user_data = <<-EOF
              #!/bin/bash
              lsb_release -a
              lscpu
              uname -m
              apt install unzip -y
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
               sudo ./aws/install
               /usr/local/bin/aws --version
               sudo apt-get remove docker docker-engine docker.io containerd runc
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update
              sudo apt-get install docker-ce docker-ce-cli -y
              sudo groupadd docker
              sudo gpasswd -a $USER docker
              aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-frontend
              docker pull  976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-frontend:frontend.latest
              docker run -it 976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-frontend:frontend.latest -p 8080:8080
              EOF
  
  tags = {
    Name = "${var.application_name}-frontend"
    createdBy = "infra-${var.iam_instance_profile_id}/news"
  }
/*
  connection {
    host = "${self.public_ip}"
    type = "ssh"
     agent = false
    user = "ec2-user"
    private_key = "${file("${path.module}/Application.pem")}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision-docker.sh"
  }*/
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


  subnet_id = "${var.subnet_public1_id}"

  vpc_security_group_ids = [
   "${var.quotes_security_group_id}"
  ]
  user_data = <<-EOF
              #!/bin/bash
              lsb_release -a
              lscpu
              uname -m
              apt install unzip -y
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
               sudo ./aws/install
               /usr/local/bin/aws --version
               sudo apt-get remove docker docker-engine docker.io containerd runc
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update
              sudo apt-get install docker-ce docker-ce-cli -y
              sudo groupadd docker
              sudo gpasswd -a $USER docker
              aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-quotes
              docker pull 976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-quotes:quotes.latest
              docker run -it 976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-quotes:quotes.latest -p 8082:8082
              EOF

  tags = {
    Name = "${var.application_name}-quotes"
    createdBy = "infra-${var.iam_instance_profile_id}/news"
  }
/*
  connection {
    host = "${self.public_ip}"
    type = "ssh"
     agent = false
    user = "ec2-user"
    private_key = "${file("${path.module}/Application.pem")}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision-docker.sh"
  } */
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


  subnet_id = "${var.subnet_public1_id}"

  vpc_security_group_ids = [
    "${var.newsfeed_security_group_id}"
  ]
user_data = <<-EOF
              #!/bin/bash
              lsb_release -a
              lscpu
              uname -m
              apt install unzip -y
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
               sudo ./aws/install
               /usr/local/bin/aws --version
               sudo apt-get remove docker docker-engine docker.io containerd runc
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update
               sudo apt-get install docker-ce docker-ce-cli -y
               sudo groupadd docker
              sudo gpasswd -a $USER docker
              aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-newsfeed
              docker pull  976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-newsfeed:newsfeed.latest
              docker run -it 976108646567.dkr.ecr.eu-central-1.amazonaws.com/tw-repo-newsfeed:newsfeed.latest -p 8081:8081
              EOF
  tags = {
  Name = "${var.application_name}-newsfeed"
    createdBy = "infra-${var.iam_instance_profile_id}/news"
  }
/*
  connection {
    host = "${self.public_ip}"
    type = "ssh"
     agent = false
    user = "ec2-user"
    private_key = "${file("${path.module}/Application.pem")}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision-docker.sh"
  } */
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