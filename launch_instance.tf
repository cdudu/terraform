provider "aws" {
        access_key = "AKIAJHV46UAYPSMDLQLA"
        secret_key = "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"
        region = "eu-west-2"
}

resource "aws_instance" "terraform_testing" {
        ami = "ami-00846a67"
        instance_type = "t2.micro"
        key_name = "aws.admin.cdudu"
	tags = {
    	  Name = "Terraform [ test ]"
  	}
}

resource "aws_security_group" "terraform" {
  name = "terraform"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "terraform" {
	cidr_block 	 = "172.10.0.0/16"
	instance_tenancy = "default"
	tags {
	   Name = "terraform"
	   Location = "London"
	}
}

resource "aws_subnet" "subnet1" {
	  vpc_id = "${aws_vpc.terraform.id}"
	  cidr_block = "172.10.1.0/24"
	  tags {
	    Name = "Subnet1"
	}
}
