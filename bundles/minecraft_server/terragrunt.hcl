terraform {
    source = "../../modules//minecraft_server"
}

inputs = {
    ssh_public_key = "~/.ssh/id_rsa.pub"
    ssh_key_name   = "ssh_key"
    server_region  = "us-east-1"
    ami_image      = "ami-0c7217cdde317cfec" // us-east-1 Jammy Jellyfish 22.04 LTS Ubuntu amd64 ami image
    instance_type  = "t2.large"
    bucket_name    = "minecraft-server-s3-bucket"
}
