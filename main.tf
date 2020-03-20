resource "aws_instance" "server" {
  ami = "ami-0c322300a1dd5dc79"

  # INSTACNE TYPE
  instance_type = "${var.ec2-type}"

  # CONFIG INSTANCE
  availability_zone = "${var.availability-zone}"

  # ADD STORAGE
  root_block_device {
    delete_on_termination = "true"
    volume_size = "${var.root-ebs-size}"
    volume_type = "${var.root-ebs-type}"
  }

  ebs_block_device {
    delete_on_termination = "true"
    device_name = "${var.data-ebs-device}"
    volume_size = "${var.data-ebs-size}"
    volume_type = "${var.data-ebs-type}"
  }

  # ADD TAGS
  tags = {
    Name = "${var.host-tag}"
  }

  volume_tags = {
    Name =  "${var.host-tag}"
  }

  # SECURITY GROUPS
  security_groups = ["${var.security-group}"]

  # SSH KEY
  key_name = "${var.ec2-key}"

}
