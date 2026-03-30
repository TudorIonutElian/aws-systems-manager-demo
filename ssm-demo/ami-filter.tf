/**********************************************************
  # Added data source to filter the ami called ssm_ami_filter
**********************************************************/

data "aws_ami" "ssm_ami_filter" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.startsWith}-*-${var.endsWith}"]
  }

  filter {
    name   = "architecture"
    values = ["${var.architecture}"]
  }
}