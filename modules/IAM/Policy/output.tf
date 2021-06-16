output "ECR_RW_policy_arn" {
    value = "${aws_iam_policy.ECR_policy.arn}"
}