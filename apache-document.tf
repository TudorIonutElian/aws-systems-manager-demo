resource "aws_ssm_document" "apache_document" {
  name            = "apache_document"
  document_format = "YAML"
  document_type   = "Command"

  content = file("documents/apache-server.yaml")
}

resource "aws_ssm_document" "block_port_80" {
  name            = "block_port_80"
  document_format = "YAML"
  document_type   = "Automation"

  content = file("documents/block-port-80.yaml")
}

resource "aws_ssm_document" "unblock_port_80" {
  name            = "unblock_port_80"
  document_format = "YAML"
  document_type   = "Automation"

  content = file("documents/unblock-port-80.yaml")
}

resource "aws_ssm_document" "install_httpd" {
  name            = "install_httpd"
  document_format = "YAML"
  document_type   = "Command"

  content = file("documents/install-httpd.yaml")
}

resource "aws_ssm_document" "create_httpd_instances" {
  name            = "create_httpd_instances"
  document_format = "YAML"
  document_type   = "Automation"

  content = file("documents/create-httpd-instances.yaml")
}

resource "aws_ssm_document" "deploy_by_tag" {
  name            = "deploy_by_tag"
  document_format = "YAML"
  document_type   = "Automation"

  content = file("documents/deploy-by-tag.yaml")
}

resource "aws_ssm_document" "destroy_by_tag" {
  name            = "destroy_by_tag"
  document_format = "YAML"
  document_type   = "Automation"

  content = file("documents/destroy-by-tag.yaml")
}
