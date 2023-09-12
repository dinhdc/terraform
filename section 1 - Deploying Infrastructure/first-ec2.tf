resource "aws_instance" "first-ec2-terraform" {
    ami = "ami-ccecf5af"
    instance_type = "t2.micro"
}