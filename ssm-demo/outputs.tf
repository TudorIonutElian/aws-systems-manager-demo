output "instance_ids" {
  description = "IDs of the SSM demo EC2 instances"
  value       = aws_instance.ssm_instances[*].id
}

output "instance_public_ips" {
  description = "Public IP addresses of the SSM demo EC2 instances"
  value       = aws_instance.ssm_instances[*].public_ip
}

output "website_urls" {
  description = "URLs to access the sample website on each instance"
  value       = [for ip in aws_instance.ssm_instances[*].public_ip : "http://${ip}"]
}

output "artifact_bucket_name" {
  description = "S3 bucket used for React build artifacts"
  value       = aws_s3_bucket.artifacts.bucket
}

output "security_group_id" {
  description = "ID of the web security group"
  value       = aws_security_group.ssm_web_sg.id
}
