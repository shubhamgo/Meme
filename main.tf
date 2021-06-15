module "s3" {
    source = "./modules/S3/"
    application_name ="${var.application_name}"
    s3_bucket = "${var.s3_bucket}"
}
module "vpc" {
    source = "./modules/VPC/"
    enviroment_details ="${var.enviroment_details}"
    application_name ="${var.application_name}"
    cidr_block ="${var.cidr_block}"
    subnet_cidr_block ="${var.subnet_cidr_block}"
}
module "policies" {
    source = "./modules/IAM/Policy/"
     application_name ="${var.application_name}"
    
}
module "role" {
    source = "./modules/IAM/Roles/"
      application_name ="${var.application_name}"
    iam_instance_profile_role_name ="${var.iam_instance_profile_role_name}"
}
module "securitygroup" {
    source = "./modules/IAM/SecurityGroup/"
    vpc_id = "${module.vpc.vpc_id}"
     application_name ="${var.application_name}"
    
}
module "ec2" {
    source = "./modules/EC2/"
     application_name ="${var.application_name}"
    subnet_public1_id = "${module.vpc.subnet_public1_id}"
    iam_instance_profile_id ="${module.role.iam_instance_profile_id}"
    security_group = "${module.securitygroup.security_group_id}"
    instance_type ="${var.instance_type}"
}

module "elb" {
    source = "./modules/Load Balancer/"
     application_name ="${var.application_name}"
      subnet_public1_id = "${module.vpc.subnet_public1_id}"
      subnet_private1_id ="${module.vpc.subnet_private1_id}"
      test_elb = "${var.test_elb}"
      vpc_id = "${module.vpc.vpc_id}"
      ec2_id ="${module.ec2.ec2_id}"
      security_group = "${module.securitygroup.security_group_id}"

}