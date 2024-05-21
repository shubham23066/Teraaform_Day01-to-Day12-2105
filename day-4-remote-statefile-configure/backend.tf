terraform {
  backend "s3" {
    bucket = "defgthyjujujuyefef"
    key = "terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-state-lock-dynamo-shubham123"
    encrypt = true
  }
}
