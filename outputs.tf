# Output what the up of the EC2 instance is for Minecraft Server

output "instance_ip_addr" {
  value = aws_instance.minecraft_server.public_ip
}
