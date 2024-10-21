output "instance_profile_name" {
  value = aws_iam_instance_profile.vm_profile.name
}

output "vm_role" {
  value = aws_iam_role.vm_role.name
}