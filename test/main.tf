module "main-mod" {
  source = "./../main-mod"
  env = "${var.env}"
  region = "${var.region}"
}