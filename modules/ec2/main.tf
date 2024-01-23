# declare the key pair protocol

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}


# create the key pair

resource "aws_key_pair" "key-pair" {
  key_name = "${var.project-name}-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "private-key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "${var.project-name}-key-pair.pem"
}

# create an ec2 instance in the public subnet

resource "aws_instance" "pub-ec2-instance1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = aws_key_pair.key-pair.key_name
  vpc_security_group_ids = [var.public_sg_id]
  subnet_id = var.public_subnet1_id
  
  tags = {
    Name = "${var.project-name}-ec2-instance1"

  }
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' > ./host-inventory"
  }

}
resource "aws_instance" "pub-ec2-instance2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = aws_key_pair.key-pair.key_name
  vpc_security_group_ids = [var.public_sg_id]
  subnet_id = var.public_subnet2_id
  
  
  tags = {
    Name = "${var.project-name}-ec2-instance2"

  }
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> ./host-inventory"
  }
  depends_on = [ aws_instance.pub-ec2-instance1 ]

}
  resource "aws_instance" "pub-ec2-instance3" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = aws_key_pair.key-pair.key_name
  vpc_security_group_ids = [var.public_sg_id]
  subnet_id = var.public_subnet3_id
  
  tags = {
    Name = "${var.project-name}-ec2-instance3"
  }
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> ./host-inventory"
  }
  depends_on = [ aws_instance.pub-ec2-instance1 ]

}
  
resource "aws_instance" "ansible" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = aws_key_pair.key-pair.key_name
  vpc_security_group_ids = [var.public_sg_id]
  subnet_id = var.public_subnet3_id
  user_data = file("${path.module}/installer.sh")
  
  tags = {
    Name = "${var.project-name}-ec2-ansible"
  }

}
