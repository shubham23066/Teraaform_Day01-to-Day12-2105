data "aws_ami" "amzlinux123" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-gp2"]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]

    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
    filter {
      name = "architecture"
      values = ["x86_64"]
    }
}

data "aws_subnet" "selected-subnet" {
    filter {
      name = "tag:Name"
      values = ["test-subnet"]
    }
  
}


resource "aws_instance" "depedancy-ec2-" {
    ami = data.aws_ami.amzlinux123.id
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.selected-subnet.id
    tags = {
        Name="filter-ec2"
    }
}