/* IaaS config */
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "db_replica" {
  ami           = "ami-16efb076"
  instance_type = "t2.micro"
  subnet_id     = "subnet-5bca4b03"
}

/* Spin-up an instance */
resource "aws_instance" "db_master" {
  ami           = "ami-16efb076"
  instance_type = "t2.micro"
  subnet_id     = "subnet-5bca4b03"

  /* basic provisioning */
  provisioner "local-exec" {
    command = "echo ${aws_instance.db_master.public_ip} > db_master_ip.txt"
  }
}

/* Assign Elastic IP */
resource "aws_eip" "ip" {
  instance = "${aws_instance.db_master.id}"
  vpc      = true
  /* explicit dependency */
  depends_on = ["aws_instance.db_master"]
}
