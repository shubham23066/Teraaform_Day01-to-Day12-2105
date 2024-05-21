provider "aws" {
  region = "us-east-1"
  alias = "test-123"
}

provider "aws" {
    region = "eu-central-1"
    
  
}

resource "aws_s3_bucket" "multiproviders-hggfrads" {
    bucket = "sndsnsnjdbcdbchscbs"
    provider = aws.test-123
}
resource "aws_s3_bucket" "namhhhththththte" {
    bucket = "kkxbsssxsjcnxscnsjcsc"
  
}
