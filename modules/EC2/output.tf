output "ec2_id" {
    value = "${aws_instance.front_end.id}"
}