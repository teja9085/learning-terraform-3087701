output "instance_id" {
  value = aws_instance.blog.id
}

output "public_ip" {
  value = aws_instance.blog.public_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}
