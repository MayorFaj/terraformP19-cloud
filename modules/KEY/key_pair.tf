#----KEY-keypair.tf

data "external" "public_key" {
  program = ["bash", "-c", "cat ~/.ssh/pbl19-key.pub"]
}

resource "aws_key_pair" "terraform-pbl19" {
  key_name   = "pbl19-key"
  public_key = data.external.public_key.result
  ##file("~/.ssh/pbl19-key.pub")
}