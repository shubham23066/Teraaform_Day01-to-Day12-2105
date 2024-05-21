locals {
  bucket-name = "${var.layer}-${var.env}-bucket-shubham12345"
}



resource "aws_s3_bucket" "test-bucket-12345" {
  bucket = local.bucket-name
  tags = {
    Name = local.bucket-name
    Environment = var.env

  }
}