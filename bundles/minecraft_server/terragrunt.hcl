terraform {
    source = "../../modules//minecraft_server"
}

inputs = {
    ssh_public_key = "~/.ssh/id_rsa.pub"
    ssh_key_name   = "ssh_key"
    server_region  = "us-east-1"
}
