#create-vpc
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
}

#create sg
resource "aws_security_group" "cust-sg" {
  vpc_id = aws_vpc.my-vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
      }
      egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

#create pvt subnet
resource "aws_subnet" "pvt-subnet" {
vpc_id = aws_vpc.my-vpc.id
cidr_block = "10.0.1.0/24"
}

#create pub subnet
resource "aws_subnet" "pub-subnet" {
vpc_id = aws_vpc.my-vpc.id
cidr_block = "10.0.0.0/24"
  }

# create IG and attach to vpc
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.my-vpc.id
}

#create pub RT and attach to ig (edit routes)
resource "aws_route_table" "pub-rt" {
vpc_id = aws_vpc.my-vpc.id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
}
}  

# subnet association to add into pub RT
resource "aws_route_table_association" "assoc" {
    route_table_id = aws_route_table.pub-rt.id
    subnet_id = aws_subnet.pub-subnet.id
  
}
# create pub instance
resource "aws_instance" "pub-ec2" {
ami = "ami-098c93bd9d119c051"
key_name = "my-key"
instance_type = "t2.micro"
subnet_id = aws_subnet.pub-subnet.id
vpc_security_group_ids = [aws_security_group.cust-sg.id]
associate_public_ip_address = true
tags = {
    Name = "pub-ec2"
}
}

#add elastic ip
resource "aws_eip" "eip" {
domain = "vpc"
}

#create nat-gw
resource "aws_nat_gateway" "nat-gw" {
allocation_id = aws_eip.eip.id
subnet_id = aws_subnet.pub-subnet.id
}

# create Pvt RT and attach to nat-gw
resource "aws_route_table" "pvt-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id

  }
}
# subnet association to add into pvt RT
resource "aws_route_table_association" "assoc-pvt" {
    route_table_id = aws_route_table.pvt-rt.id
    subnet_id = aws_subnet.pvt-subnet.id
  
}
#

#create ec2
resource "aws_instance" "private-ec2" {
  ami =  "ami-098c93bd9d119c051"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pvt-subnet.id
  vpc_security_group_ids = [aws_security_group.cust-sg.id]
  key_name = "my-key"
  tags = {
    Name = "pvt-ec2"
}
}