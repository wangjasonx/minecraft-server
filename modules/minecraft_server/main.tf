data "aws_caller_identity" "aws" {}

locals {
  tf_tags = {
    Name      = "Minecraft Server"
    Terraform = true
    By        = data.aws_caller_identity.aws.arn
  }
}

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
  tags = local.tf_tags
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key)
}

resource "aws_iam_role" "s3_access_role" {
  name               = "s3-access-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3_access_role_policy" {
  name   = "s3-access-role-policy"
  role   = aws_iam_role.s3_access_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::${var.bucket_name}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "s3_iam_instance_profile" {
  name = "s3-iam-instance-profile"
  role = aws_iam_role.s3_access_role.name
}

resource "aws_s3_bucket" "minecraft_server_s3_bucket" {
  bucket = var.bucket_name

  tags = local.tf_tags
}

resource "aws_instance" "minecraft_server" {
  ami                         = var.ami_image
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.s3_iam_instance_profile.id
  vpc_security_group_ids      = [aws_security_group.minecraft.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Minecraft Server"
  }
}
