/**********************************************************
  # Create Ec2 Instance called tf_demo_ec2_instance
**********************************************************/
resource "aws_instance" "ssm_instances" {
  ami                         = data.aws_ami.ssm_ami_filter.id
  instance_type               = var.ssm_instance_type
  key_name                    = aws_key_pair.ssm_key.key_name
  count                       = var.ssm_instance_count
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_profile.name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ssm_web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    # Install Apache
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd

    # Create web root
    mkdir -p /var/www/html
    chown -R apache:apache /var/www/html

    # Ensure SSM agent is running (should already be on AL2023)
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
  EOF

  tags = {
    Name        = "SSM Instance ${count.index + 1}"
    Environment = "Development-${var.build_number}"
  }
}