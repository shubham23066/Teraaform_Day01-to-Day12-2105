module "test-module" {
    source = "../day-8-modules"
    ami_id="ami-098c93bd9d119c051"
    instance_type = "t2.nano"
  
}