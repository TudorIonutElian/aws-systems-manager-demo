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
