resource "aws_instance" "new-ec2" {
    ami =  "ami-098c93bd9d119c051"
    instance_type = "t2.micro"

    tags = {
      Name = "newdev"
    }
}

