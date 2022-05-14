data "aws_ami" "tomcat" {
  most_recent      = true
  owners           = ["408636776942"]

  filter {
    name   = "name"
    values = ["${var.tomcat_ami}"]
  }
}

data "aws_vpc" "project" {
  filter {
    name = "tag:Name"
    values = ["${var.vpc_name}"]
  }
  filter {
    name = "tag:Environment"
    values = ["${var.environment}"]
  }
}

data "aws_subnet" "public_a" {
  vpc_id = "${data.aws_vpc.project.id}"
  availability_zone = "eu-central-1a"
  filter {
    name = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_subnet" "public_b" {
  vpc_id = "${data.aws_vpc.project.id}"
  availability_zone = "eu-central-1b"
  filter {
    name = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_subnet" "private_a" {
  vpc_id = "${data.aws_vpc.project.id}"
  availability_zone = "eu-central-1a"
  filter {
    name = "tag:Tier"
    values = ["Private"]
  }
}

data "aws_subnet" "private_b" {
  vpc_id = "${data.aws_vpc.project.id}"
  availability_zone = "eu-central-1b"
  filter {
    name = "tag:Tier"
    values = ["Private"]
  }
}

data "aws_security_group" "publicSG" {
  vpc_id = "${data.aws_vpc.project.id}"
  filter {
    name = "tag:Tier"
    values = ["Public"]
  }
}
data "aws_security_group" "privateSG" {
  vpc_id = "${data.aws_vpc.project.id}"
  filter {
    name = "tag:Tier"
    values = ["Private"]
  }

}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.project.id}"

  tags = {
    Tier = "Public"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.project.id}"
 
 tags = {
   Tier = "Private"
 }
}


output "ami_tomcat" { value = "${data.aws_ami.tomcat.id}"}
output "vpc_id" { value = "${data.aws_vpc.project.id}"}
output "public_subnet_a" { value = "${data.aws_subnet.public_a.id}"}
output "public_subnet_b" { value = "${data.aws_subnet.public_b.id}"}
output "private_subnet_a" { value = "${data.aws_subnet.private_a.id}"}
output "private_subnet_b" { value = "${data.aws_subnet.private_b.id}"}
output "public_sg_id" { value = "${data.aws_security_group.publicSG.id}"}
output "private_sg_id" { value = "${data.aws_security_group.privateSG.id}"}
output "private_subnets" { value = "${data.aws_subnet_ids.private.id}"}
output "public_subnets" { value = "${data.aws_subnet_ids.public.id}"}
