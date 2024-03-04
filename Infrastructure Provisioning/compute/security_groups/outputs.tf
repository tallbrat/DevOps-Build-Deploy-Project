output "public_security_group_ids" {
  value = aws_security_group.public_sg[*].id
}

output "private_sg_ids_$${element(keys(var.no-of-private-instance-in-each-tier), count.index)}" {
  value = [for sg in aws_security_group.private_sg : sg.id
    if sg.name == element(keys(var.no-of-private-instance-in-each-tier), count.index) ] 
}
