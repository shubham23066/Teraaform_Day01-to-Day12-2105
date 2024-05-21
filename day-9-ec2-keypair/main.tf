resource "aws_key_pair" "name12345" {
  key_name = "public-12345"
  public_key = file("C:/Users/prati/.ssh/id_ed25519.pub")
}



resource "aws_instance" "test-ec2" {
    ami = "ami-08188dffd130a1ac2"
    instance_type = "t2.micro"
    key_name = aws_key_pair.name12345.key_name
     tags = {
    Name = "key-tf"
  }
}