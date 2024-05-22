resource "aws_instance" "multi-ec2-" {
    ami = "ami-098c93bd9d119c051"
    instance_type = "t2.micro"
    key_name = "my-key"
    tags = {
        Name="multi-resource-ec2"
    }
  
}

resource "aws_s3_bucket" "name" {
  bucket = "gcdxdxzszszdcgvhbhbhb"
}



