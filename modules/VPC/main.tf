data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_vpc" "main_vpc" {
   
    cidr_block = "${var.cidr_block}"
    enable_dns_support = "true"#gives you an internal domain name
    enable_dns_hostnames = "true"#gives you an internal host name
    
    instance_tenancy = "default"   
    
    tags = {
        Name = "${var.application_name}-${var.enviroment_details}"
        application_name = "${var.application_name}"
    }
}

// subnet 
resource "aws_subnet" "subnet_public1_id"{
 cidr_block ="${var.subnet_cidr_block[0]}"
  availability_zone  = "${data.aws_availability_zones.available.names[1]}"
 vpc_id = "${aws_vpc.main_vpc.id}"
 map_public_ip_on_launch = "true"
  tags = {
        Name = "${var.application_name}-PublicSubnet"
        application_name = "${var.application_name}"
    }
}

resource "aws_subnet" "subnet_private_1" {
 cidr_block ="${var.subnet_cidr_block[1]}"
 availability_zone  = "${data.aws_availability_zones.available.names[0]}"
  vpc_id = "${aws_vpc.main_vpc.id}"
   tags = {
        Name = "${var.application_name}-PrivateSubnet"
        application_name = "${var.application_name}"
    }
}
//Internet gateway 
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
     application_name = "${var.application_name}"
  }
}
//route table 
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
 tags = {
     Name = "${var.application_name}-InternetGateway"
     application_name = "${var.application_name}"
  }
  
}



// route table association to subnet 

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.subnet_public1_id.id
  route_table_id = aws_route_table.public_rt.id
}
/*
resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = aws_subnet.subnet_private_1.id
  route_table_id = aws_route_table.bar.id
}*/

