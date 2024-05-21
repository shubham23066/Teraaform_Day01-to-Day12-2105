provider "aws" {
  region = "eu-central-1" 
}

# Define bucket
resource "aws_s3_bucket" "namhhhththththte" {
    bucket = "kkxbsssxsjcnxscnsjcsc"
  
}

#Define ec2
resource "aws_instance" "new-ec2" {
    ami =  "ami-098c93bd9d119c051"
    instance_type = "t2.micro"

    tags = {
      Name = "newdev"
    }
}

#Define iam user
resource "aws_iam_user" "example_user" {
  name = "example-user"
}


# Define IAM role
resource "aws_iam_role" "example_role" {
  name               = "ExampleRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    },
         ]
  })

  tags = {
    Name = "Example Role"
  }
}

# Define IAM policy
resource "aws_iam_policy" "example_policy" {
  name        = "ExamplePolicy"
  description = "Example policy for the IAM role"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = ["s3:*"],
      Resource  = "*"
    }]
  })
}

# Attach policy to the IAM role
resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = aws_iam_policy.example_policy.arn
}

# Define IAM instance profile
resource "aws_iam_instance_profile" "example_instance_profile" {
  name = "ExampleInstanceProfile"
  role = aws_iam_role.example_role.name
}

# Attach IAM policy to IAM user allowing to assume the role
resource "aws_iam_user_policy_attachment" "example_policy_attachment" {
  user       = "example-user" # Replace with the name of your IAM user
  policy_arn = aws_iam_policy.example_policy.arn # ARN of the policy allowing assuming the role
}