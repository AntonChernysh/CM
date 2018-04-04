variable "region" {
  default = "us-east-2"
}
variable "owner" {
  default = "Anton"
}
variable "s3_state" {
  default = "terraform-state-anton1"
}
variable "key_name" {
  default = "anton_tf"
}
variable "ami" {
  default = "ami-916f59f4"
}
variable "private_key" {
  default = "/home/ec2-user/key.pem"
}
