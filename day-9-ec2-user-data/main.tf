resource "aws_instance" "test-ec2" {
    ami = "ami-08188dffd130a1ac2"
    instance_type = "t2.micro"
    user_data = file("test.sh")
  tags = {
    Name = "ec2-test"
  }
}