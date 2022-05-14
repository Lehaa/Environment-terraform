locals {
    common_tags = {
      Owner = "Lucian-Curelaru"
      Environment = "Develop"
    }
}

terraform {
  backend "s3" {
    bucket = "lcurelaru-mybucket-test"
    key = "terraform.tfstate"
    region = "eu-central-1"
    profile = "lcurelaru"
  }
}

provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}


module "Data" {
  source = "./Data"
  tomcat_ami = "${var.tomcat_ami}"
  vpc_name = "${var.vpc_name}"
  environment = "${var.environment}"
}

module "Compute" {
  source = "./Compute"
  common_tags = "${local.common_tags}"
  tomcat_ami = "${module.Data.ami_tomcat}"
  public_subnet_a = "${module.Data.public_subnet_a}"
  public_sg_id = "${module.Data.public_sg_id}"
  aws_keypair = "${var.aws_keypair}"
}

resource "null_resource" "stable_instances" {
  provisioner "local-exec" {
    command = "aws --profile ${var.aws_profile} ec2 wait system-status-ok --instance-ids ${module.Compute.instance_id}"
  }
}