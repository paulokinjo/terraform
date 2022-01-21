output "ec2_public_ip" {
  value = module.bootcamp-webserver.aws_instance.public_ip
}