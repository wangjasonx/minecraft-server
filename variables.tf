variable "admin_ip" {
  type        = string
  description = "Whitelisted ip for SSH access to EC2 instance"
}

variable "server_region" {
  type        = string
  default     = "us-east-1"
  description = "The region that the EC2 instance will be created"
}

variable "ssh_key_name" {
  type        = string
  default     = "ssh_key"
  description = "SSH Key name for WSL Ubuntu Instance"
}

variable "ssh_public_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Directory to find the ssh public key for ssh access to machine"
}
