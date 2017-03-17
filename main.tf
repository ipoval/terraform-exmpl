/* IaaS config */
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "ec2" {
  source = "./modules/ec2"
}

/* Assign Elastic IP */
resource "aws_eip" "ip" {
  instance   = "${module.ec2.aws_instance_db_master_id}"
  vpc        = true
  /* explicit dependency */
  depends_on = ["module.ec2"]
}
