resource "tls_private_key" "metabank_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "metabank_keypair" {
  key_name   = "metabank-key"
  public_key = tls_private_key.metabank_key.public_key_openssh
}

resource "local_file" "metabank_local" {
  filename        = "./keypair/metabank-key"
  content         = tls_private_key.metabank_key.private_key_pem
  file_permission = "0600"
}