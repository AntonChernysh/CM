terraform {
  backend "s3" {
    bucket = "terraform-state-anton1"
    key    = "all/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
	region     = "us-east-2"	
	}

data "terraform_remote_state" "all" {
  backend = "s3"
  config {
    bucket = "terraform-state-anton1"
    key    = "all/terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_vpc" "main" {
	cidr_block = "10.80.0.0/16"
	enable_dns_hostnames  = "True"
	tags {
		Name = "${var.owner}_tf_managed"
		owner = "${var.owner}"
	}
}

resource "aws_subnet" "sub1" {
	vpc_id     = "${aws_vpc.main.id}"
	cidr_block = "10.80.1.0/24"
	map_public_ip_on_launch = "True"
	tags {
		Name = "${var.owner}_tf_managed"
		owner = "${var.owner}"
	}
}

resource "aws_internet_gateway" "gw" {
	vpc_id = "${aws_vpc.main.id}"
	tags {
		Name = "${var.owner}_tf_managed"
	}
}
resource "aws_route_table" "rt1" {
	vpc_id = "${aws_vpc.main.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.gw.id}"
	}
	tags {
		Name = "${var.owner}_tf_managed"
		owner = "${var.owner}"
	}
}
resource "aws_route_table_association" "a" {
	subnet_id      = "${aws_subnet.sub1.id}"
	route_table_id = "${aws_route_table.rt1.id}"
}
resource "aws_security_group" "allow_ssh" {
	name        = "allow_ssh"
	description = "Allow ssh inbound traffic"
	vpc_id      = "${aws_vpc.main.id}"
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
                from_port   = 80
                to_port     = 80
                protocol    = "TCP"
                cidr_blocks = ["0.0.0.0/0"]
        }
	ingress {
                from_port   = 443
                to_port     = 443
                protocol    = "TCP"
                cidr_blocks = ["0.0.0.0/0"]
        }

	egress {
		from_port       = 0
		to_port         = 0
		protocol        = "-1"
		cidr_blocks     = ["0.0.0.0/0"]
	}
	
	tags {
	        Name = "${var.owner}_tf_managed"
		owner =	"${var.owner}"
	}
}

resource "aws_instance" "linux" {
	ami           = "ami-916f59f4"
	instance_type = "t2.micro"
	subnet_id = "${aws_subnet.sub1.id}"
	key_name = "anton_tf"
	vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"] 
	count = 1
	tags {
		Name = "${var.owner}_tf_managed"
		owner = "${var.owner}"
	}
}


