
output "s3_bucket_name" {
  value = aws_s3_bucket.bishal_bucket.bucket
}

output "iam_bishal_user" {
    value = aws_iam_user.bishal_user.name
}

output "security_bishal_group" {
    value = aws_security_group.bishal_security_group.id
}

output "instance_bishal" {
    value = aws_instance.bishal_instance[*].id
}