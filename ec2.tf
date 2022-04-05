provider "aws" {
    region = "us-east-1"
    access_key = "AKIAVJMGIVLQW3HJZMLQ"
    secret_key = "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"
}
resource "aws_instance" "emmaEC2" {
     ami = "ami-00e87074e52e6c9f9"
     instance_type = "t2.micro"
     tags = {
       "Name" = "Centos7 Emma"
     }
     
}
