resource "aws_s3_bucket" "lkcfgdhenntunnxnnxfjjfjriiymmyut" {
  bucket = "defgthyjujujuyefef"
  
}

 #resource "aws_s3_bucket_acl" "test" {
    #bucket = aws.s3.bucket.remote.id
    #acl = "private"}

resource "aws_s3_bucket_versioning" "versioning-name" {
  bucket = aws_s3_bucket.lkcfgdhenntunnxnnxfjjfjriiymmyut.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamo-db-terraform-state-lock-shubham" {
  name = "terraform-state-lock-dynamo-shubham123"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
  attribute {
  name = "LockID"
  type = "S"
  }
  }
