resource "aws_instance" "centos" {
  ami               = data.aws_ami.centos.id
  availability_zone = data.aws_availability_zones.available.names[3]
  instance_type     = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}
