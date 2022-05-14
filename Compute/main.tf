
resource "aws_instance" "webapp" {
  ami           = "${var.tomcat_ami}"
  subnet_id     = "${var.public_subnet_a}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${var.public_sg_id}"]
  key_name = "${var.aws_keypair}"
  root_block_device {
    volume_type = "${var.root_type}"
    volume_size = "${var.root_block_size}"
    delete_on_termination = true
  }

  tags = "${merge(
    "${var.common_tags}",
    tomap({
        "Name" = "Tomcat-Centos8"
        })
  )}"
}

data "template_file" "host" {
  template = "${file("${path.module}/host_address.sh")}"
  vars = {
    tomcat_host = "${aws_instance.webapp.public_ip}"
  }
}

resource "null_resource" "local" {
  triggers = {
    template = "${data.template_file.host.rendered}"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.host.rendered}\" > address.sh"
  }
}

output "instance_id" { value = "${resource.aws_instance.webapp.id}"}
