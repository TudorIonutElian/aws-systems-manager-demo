/**********************************************************
  # Added data source to filter the ami called ssm_ami_filter
**********************************************************/

data "aws_ami" "ssm_ami_filter" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  # Exclude minimal AMIs (they don't have SSM agent pre-installed)
  filter {
    name   = "name"
    values = ["*"]
  }
}