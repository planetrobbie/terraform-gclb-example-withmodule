variable group1_size {
  default = "2"
}

variable group2_size {
  default = "2"
}

module "mig1" {
  source            = "app.terraform.io/emea-se-playground/managed-instance-group/google"
  version           = "1.1.10"
  region            = "europe-west2"
  zone              = "europe-west2-b"
  network           = "${var.network}"
  name              = "group1"
  size              = "${var.group1_size}"
  target_tags       = ["allow-group1"]
  service_port      = 80
  service_port_name = "http"
  startup_script    = "${data.template_file.group-startup-script.rendered}"
}

module "mig2" {
  source            = "app.terraform.io/emea-se-playground/managed-instance-group/google"
  version           = "1.1.10"
  region            = "europe-west3"
  zone              = "europe-west3-b"
  network           = "${var.network}"
  name              = "group2"
  size              = "${var.group2_size}"
  target_tags       = ["allow-group2"]
  service_port      = 80
  service_port_name = "http"
  startup_script    = "${data.template_file.group-startup-script.rendered}"
}

data "template_file" "group-startup-script" {
  
  vars {
    PROXY_PATH = ""
  }

  template = "${var.startup_script}"
}