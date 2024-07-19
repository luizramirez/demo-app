resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHT1512ZU5G5KVwV5UtCstTKzCASWq7YNVagnBBleRbp hoch.engineer@mail.com"
}

# EC2 resource
resource "aws_instance" "flask" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  # add security groups to allow http and ssh access
  vpc_security_group_ids = [
    aws_security_group.flask.id,
    aws_security_group.ssh_from_local.id,
  ]
  key_name = aws_key_pair.deployer.key_name
  # add to public subnet
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  tags = {
    Name = "HelloWorld"
  }
}

# associate an EIP to our flask instance
resource "aws_eip" "flask" {
  instance = aws_instance.flask.id
  domain   = "vpc"

  depends_on = [
    aws_instance.flask
  ]
  tags = {
  "Name" = "flask-eip" }
}

# null resource to run ansible for configuration managemet
resource "null_resource" "ansible-init" {
  provisioner "local-exec" {
    command = <<EOT
          sleep 60; ansible-playbook -u ec2-user --private-key hoch-engineer.pub -i '${aws_eip.flask.public_ip}', ansible/ansible-playbook.yml -e branch='master' -v
        EOT
  }
  depends_on = [aws_instance.flask]
}