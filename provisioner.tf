resource "aws_instance" "provisioner" {
  ami                         = data.aws_ami.centos.id
  availability_zone           = data.aws_availability_zones.available.names[3]
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.r1soft-task.key_name

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("~/.ssh/id_rsa")
      host        = aws_instance.provisioner.public_ip
    }
    inline = [
      "sudo yum install epel-release -y"
    ]
  }

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("~/.ssh/id_rsa")
      host        = aws_instance.provisioner.public_ip
    }
    source      = "r1soft.repo"
    destination = "/etc/r1soft.repos.d"
  }

provisioner "remote-exec" {
  connection {
    type        = "ssh"
    user        = "centos"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.provisioner.public_ip
  }
  inline = [
    "sudo yum install serverbackup-enterprise -y",
    "r1soft-setup --user admin  --pass redhat --http-port 80 --https-port 443",
    "/etc/init.d/cdp-server restart"
  ]
}
}