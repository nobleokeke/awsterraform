resource "aws_instance" "server" {
  ami = "ami-0c322300a1dd5dc79"

  # INSTACNE TYPE
  instance_type = "t2.micro"

  # CONFIG INSTANCE
  availability_zone = "us-east-1e"

  # ADD STORAGE
  root_block_device {
    delete_on_termination = "true"
    volume_size = "40"
    volume_type = "standard"
  }

  ebs_block_device {
    delete_on_termination = "true"
    device_name = "/dev/sdb"
    volume_size = "80"
    volume_type = "standard"
  }

  # ADD TAGS
  tags = {
    Name = "NobleDB"
  }

  volume_tags = {
    Name =  "NobleDB"
  }

  # SECURITY GROUPS
  security_groups = ["Oracle Database 11-2-0-4 Enterprise Edition -Oracle Enterprise Linux 7-5-v0-1-AutogenByAWSMP-"]

  # SSH KEY
  key_name = "DevopsKey"

}
