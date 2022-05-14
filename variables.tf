variable "aws_profile" {
    type = string
    default = "lcurelaru"
}

variable "aws_region" {
    type = string
    default = "eu-central-1"
}

variable "aws_keypair" {
    type = string
    default = "lcurelaru"

}

variable "tomcat_ami" {
    type = string
    default = "ami-centos8-tomcat"
}

variable "vpc_name" {
    type = string
    default = "VPC-Project"
}

variable "environment" {
    type = string
    default = "Develop"
}