resource "aws_key_pair" "r1soft-task" {
  key_name   = "r1soft-task"
  public_key = file("~/.ssh/id_rsa.pub")
}
