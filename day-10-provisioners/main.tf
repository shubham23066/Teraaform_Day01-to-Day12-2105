# create vpc
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="cust_vpc"
  }
}

#create sg
resource "aws_security_group" "cust-sg" {
    vpc_id = aws_vpc.dev.id

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
# create subnet
resource "aws_subnet" "dev" {
vpc_id = aws_vpc.dev.id
cidr_block = "10.0.0.0/24"
}
# create IG and attach to vpc
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.dev.id

}
# create RT and attach configure IG (edit routes)
resource "aws_route_table" "dev" {
vpc_id = aws_vpc.dev.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.name.id 
    
}

}
# subnet associtation to add into RT
resource "aws_route_table_association" "dev" {
    route_table_id = aws_route_table.dev.id
    subnet_id = aws_subnet.dev.id
  
}
resource "aws_key_pair" "name12345" {
  key_name = "public-12345"
  public_key = file("C:/Users/prati/.ssh/id_ed25519.pub")
}
resource "aws_instance" "name" {
ami = "ami-08188dffd130a1ac2"
instance_type = "t2.micro"
subnet_id = aws_subnet.dev.id
key_name = aws_key_pair.name12345.key_name
associate_public_ip_address = true
vpc_security_group_ids = [aws_security_group.cust-sg.id]
tags = {
    Name = "provisioner-ec2"
}

connection {
  type = "ssh"
  user = "ec2-user"
  private_key = file("C:/Users/prati/.ssh/id_ed25519")
  host = self.public_ip
}
provisioner "local-exec" {
  command = "touch file100"
}
provisioner "file" {
  source = "D:/Teraaform_Day01-to=Day12/day-10-provisioners/file100"
  destination = "/home/ec2-user/file100"
  }
provisioner "remote-exec" {
inline = [
    "touch file200",
    "echo hello from shubham >> file200",
]

}
}

  
