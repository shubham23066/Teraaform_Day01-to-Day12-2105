variable "ami_id" {
  description = "this will give the value of ami"
  type = string
  default = ""
}

variable "instance_type" {
    description = "this will give the value of instance type"
    type = string
    default = "t2.micro"
}
