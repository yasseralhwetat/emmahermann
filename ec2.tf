provider "aws" {
    region = "us-east-1"
    access_key = "AKIAVJMGIVLQW3HJZMLQ"
    secret_key = "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"
}
resource "aws_instance" "emmaEC2" {
     ami = "ami-0fd63e471b04e22d0"
     instance_type = "t2.micro"
     key_name= "id_rsa"
     tags = {
       "Name" = "OpenEDX Emma"
     }
     connection {
      type        = "ssh"
      user        = "ubuntu"
      password    = ""
      private_key = file("./id_rsa")
      host        = self.public_ip
      }
 
      provisioner "file" {
       source      = "./config.yaml"
       destination = "/home/ubuntu/config.yaml"
       }
      provisioner "remote-exec" {
        inline = [
          "sudo apt update -y",
          "sudo apt install  wget git -y",
          "export OPENEDX_RELEASE=open-release/maple.1",
          "wget https://raw.githubusercontent.com/edx/configuration/open-release/maple.1/util/install/ansible-bootstrap.sh -O - | sudo -EH bash",
          "wget https://raw.githubusercontent.com/edx/configuration/open-release/maple.1/util/install/native.sh -O - | bash",
        ]
      }
}
  resource "aws_security_group" "main" {
   egress {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
   ingress  {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
   ingress  {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 80
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 80
  }
   ingress  {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 443
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 443
  }
    
}

resource "aws_key_pair" "deployer" {
  key_name   = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSFU25UqiEprvbc4TnQE6wlWGcAKmpepUURoKvYuGUQlZM43x02ntXvqymgjQRj7ouHU1rdsYW0jwL1nqdCz+IeWjkl07cKypYDxn6lAn3Qs4afCuAz0VXnTskJ6Yaq5JZraL4cLpK1Dv3wbwoiG9q3pLw2XdfkrR3ib2nAV1AT27NPSNxK8uqgf9aBoZ9LsOdEheBilZbkMw9JH5qpXqcqjhq36REkPOI47FD6+lZtnwoIzlo7I10IqLj0LDgAkB0uRLu4s4ng3mP0AwzuBqp/AH+vcPJcnou2yvVXedlQHti9EiRngu7XiV5fsTvfOkz3vVkFqx4eNf+v25bH5j6JJphN3nJQlGXZV8ud7sYy22NnwTZORcx1DqYLbHa6GCfesx5jwIpMnycjMG6G+NuhftCD/xMsVvQTEEXIXU/Wv/AweveqnUOsJC+Y80xE6ckGrKag77x4Z0n36QXDvIljiI4fxabMDnnVuQm10bIx/TAJuZOLDytZU05ZHCkJ+s= yasser@rootex"
}

output "pub_ip" {
  value = aws_instance.emmaEC2.public_ip
}
