variable "tomcat_ami" {
}

variable "public_subnet_a" {
  type = string
}

variable "public_sg_id" {
  type = string
}

variable "aws_keypair" {
  type = string
}

variable "root_block_size" {
  default = 10
}

variable "root_block_name" {
  default = "/dev/xvda/"
}

variable "root_type" {
  default = "gp2"
}

variable "common_tags" {
  type = map(string)
}