/* Spin-up an instance */
resource "aws_instance" "db_master" {
  ami           = "ami-16efb076"
  subnet_id     = "subnet-5bca4b03"
  instance_type = "t2.micro"

  /* basic provisioning */
  provisioner "local-exec" {
    command = "echo ${aws_instance.db_master.public_ip} > db_master_ip.txt"
  }
}
