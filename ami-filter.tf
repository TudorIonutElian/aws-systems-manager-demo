/**********************************************************
  # Added data source to filter the ami called ssm_ami_filter
  # Uses standard AL2023 AMI (NOT minimal) which includes SSM agent
**********************************************************/

data "aws_ami" "ssm_ami_filter" {
  owners      = ["amazon"]
  most_recent = true

  # Standard AL2023 AMI pattern (NOT minimal variant)
  # Format: al2023-ami-2023.X.XXXXXXXX.X-kernel-6.X-x86_64
  # Minimal would be: al2023-ami-minimal-2023...
  filter {
    name   = "name"
    values = ["al2023-ami-2023.?*.?*-kernel-?*.?*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}