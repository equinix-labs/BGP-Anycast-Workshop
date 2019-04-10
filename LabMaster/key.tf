resource "tls_private_key" "default" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "local_file" "private_key_pem" {

  depends_on = ["tls_private_key.default"]

  content    = "${tls_private_key.default.private_key_pem}"
  filename   = "default.pem"
}

resource "null_resource" "chmod" {
  depends_on = ["local_file.private_key_pem"]

  triggers = {
    local_file_private_key_pem = "local_file.private_key_pem"
  }

  provisioner "local-exec" {
    command = "chmod 600 default.pem"
  }
}

