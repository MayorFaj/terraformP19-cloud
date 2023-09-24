#---KEY-keypair.tf

resource "aws_key_pair" "terraform-pbl19" {
  key_name   = "pbl19-key"
  public_key = file("../modules/KEY/pbl19-key.pub")
}