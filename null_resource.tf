resource "null_resource" "remote" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("~/.ssh/id_rsa")
      host        = aws_instance.provisioner.public_ip
    }
    inline = [
      "sudo yum install epel-release -y",

    ]
  }

  #   provisioner "file" {
  #     connection {
  #       type        = "ssh"
  #       user        = "centos"
  #       private_key = file("~/.ssh/id_rsa")
  #       host        = aws_instance.provisioner.public_ip
  #     }
  #     source  = "r1soft.repo.md"
  #     destination = "/etc/r1soft.repo."

  #   }
  # }

}