/* IaaS config */
provider "aws" {
  access_key = "AKIAJQGRSBW2TESPZ57A"
  secret_key = "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"
  region     = "us-west-1"
}

resource "aws_instance" "another" {
  ami           = "ami-16efb076"
  instance_type = "t2.micro"
  subnet_id     = "subnet-5bca4b03"
}

/* Spin-up an instance */
resource "aws_instance" "example" {
  ami           = "ami-16efb076"
  instance_type = "t2.micro"
  subnet_id     = "subnet-5bca4b03"
}

/* Assign Elastic IP */
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
  /* explicit dependency */
  depends_on = ["aws_instance.example"]
}
