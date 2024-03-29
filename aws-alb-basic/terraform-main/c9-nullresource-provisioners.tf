# Create a Null Resource and Provisioners
resource "null_resource" "name" {

  depends_on = [module.ec2_public, aws_key_pair.generated_key]

  ## Connection Blocks for Provisioners to connect to EC2 instance
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_eip.bastion_eip.public_ip
    private_key = file("private-key/${var.instance_keypair}.pem")
  }

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "private-key/${var.instance_keypair}.pem"
    destination = "/tmp/terraform-key.pem"
  }

  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key.pem"
    ]
  }

  # Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    # on_failure = continue
  }

  ## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Destroy Resource)
  # provisioner "local-exec" {
  #   command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
  #   working_dir = "local-exec-output-files/"
  #   when = destroy
  #   # on_failure = continue
  # }

}
