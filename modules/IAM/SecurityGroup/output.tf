output "security_group_id" {
    value = "${aws_security_group.securitygroup_1.id}"
}

output "frontend_security_group_id" {
    value = "${aws_security_group.frontend.id}"
}

output "newsfeed_security_group_id" {
    value = "${aws_security_group.newsfeed.id}"
}

output "quotes_security_group_id" {
    value = "${aws_security_group.quotes.id}"
}
