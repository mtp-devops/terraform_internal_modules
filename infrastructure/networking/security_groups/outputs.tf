output "security_group_id" {
  value = {
    for security_group in aws_security_group.sg_group:
      security_group.name => security_group.id
  }
}
