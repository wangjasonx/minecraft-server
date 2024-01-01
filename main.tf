resource "aws_security_group" "minecraft" {
  ingress {
    description = "Receive SSH from home."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ip}/32"]
  }
  ingress {
    description = "Receive Minecraft server requests from everywhere."
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Send everywhere."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Minecraft"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key)
}

# us-east-1 Jammy Jellyfish 22.04 LTS Ubuntu amd64 ami image

resource "aws_instance" "minecraft_server" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.large"
  vpc_security_group_ids      = [aws_security_group.minecraft.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Minecraft Server"
  }
}
