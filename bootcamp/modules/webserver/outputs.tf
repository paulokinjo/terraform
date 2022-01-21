output "aws_instance" {
  value = aws_instance.bootcamp-server
}

output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image
}