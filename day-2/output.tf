output "ip" {
    value = aws_instance.dev.public_ip
    description = "calling public ip of ec2 instance"
}

output "ip2" {
    value = aws_instance.dev.private_ip
    description = "calling private ip in ec2 instance"
    sensitive = true
}