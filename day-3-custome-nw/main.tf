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

resource "aws_instance" "name" {
ami = var.ami_id
instance_type = var.instance_type
subnet_id = aws_subnet.dev.id
vpc_security_group_ids = [aws_security_group.cust-sg.id]
tags = {
    Name = "new-test"
}
}

  
