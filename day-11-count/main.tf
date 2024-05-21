resource "aws_instance" "name" {
ami = var.ami_id
instance_type = var.instance_type
tags = {
    Name = var.typeOfEnv[count.index]
}
count = length(var.typeOfEnv)
}
