output "subnet_public1_id" {
    value = "${aws_subnet.subnet_public1_id.id}"
}

output "subnet_private1_id" {
    value = "${aws_subnet.subnet_private_1.id}"
}

output "vpc_id" {
    value = "${aws_vpc.main_vpc.id}"
}