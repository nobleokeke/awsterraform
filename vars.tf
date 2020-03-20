variable "access_key" {}
variable "secret_key" {}
variable "region" {}

variable "ec2-type" {
 default = "t2.large"
}

variable "availability-zone" {
 default = "us-east-1e"
}

variable "host-tag" {
 default = "Oracle Dev"
}

variable "security-group" {
 default = "Oracle Database 11-2-0-4 Enterprise Edition -Oracle Enterprise Linux 7-5-v0-1-AutogenByAWSMP-"
}

variable "ec2-key" {
 default = "oracleKey"
}

variable "root-ebs-size" {
 default = "40"
}

variable "root-ebs-type" {
 default = "standard"
}

variable "data-ebs-device" {
 default = "/dev/sdb"
}

variable "data-ebs-size" {
 default = "80"
}

variable "data-ebs-type" {
 default = "standard"
}
