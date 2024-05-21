module "second-module" {
  source = "github.com/CloudTechDevOps/Terraform-10-30am/day-3-custom-NW"
  ami_id = "ami-08188dffd130a1ac2"
  instance_type = "t2.micro"
}