#----KEY-keypair.tf

# data "external" "public_key" {
#   program = ["bash", "-c", "cat ~/.ssh/pbl19-key.pub"]
# }

variable "private_key_path" {
  default = "terraform-cloud/modules/KEY/pbl19-key.pub"
}

resource "aws_key_pair" "terraform-pbl19" {
  key_name   = "pbl19-key"
  public_key = file(var.private_key_path)
  ##file("~/.ssh/pbl19-key.pub")
}