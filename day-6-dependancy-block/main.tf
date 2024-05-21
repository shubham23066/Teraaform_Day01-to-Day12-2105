resource "aws_instance" "depedancy-ec2-" {
    ami = "ami-098c93bd9d119c051"
    instance_type = "t2.micro"
    tags = {
        Name="depedancy-ec2"
    }
  
}

resource "aws_s3_bucket" "dependancy-buckett-" {
  bucket = "dependancy-s3-jhdgsgsgfrfr"
depends_on = [ aws_instance.depedancy-ec2- ]
}