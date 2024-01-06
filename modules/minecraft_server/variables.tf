variable "admin_ip" {
  type        = string
  description = "Whitelisted ip for SSH access to EC2 instance"
}

variable "ami_image" {
  type        = string
  description = "ami image for EC2 instance"
}

variable "bucket_name" {
  type = string
  description = "Name of S3 bucket that is being created to persist files"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance type"
}

variable "server_region" {
  type        = string
  description = "The region that the EC2 instance will be created"
}

variable "ssh_key_name" {
  type        = string
  description = "SSH Key name for WSL Ubuntu Instance"
}

variable "ssh_public_key" {
  type        = string
  description = "Directory to find the ssh public key for ssh access to machine"
}
