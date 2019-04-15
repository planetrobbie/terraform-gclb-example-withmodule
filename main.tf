provider "google" {
  version = "1.20.0"
}

module "gce-lb-http" {
  source  = "app.terraform.io/emea-se-playground-2019/lb-http/google"
  version = "1.0.8"
  name        = "group-http-lb"

  target_tags = ["${module.mig1.target_tags}", "${module.mig2.target_tags}"]

  backends = {
    "0" = [
      {
        group = "${module.mig1.instance_group}"
      },
      {
        group = "${module.mig2.instance_group}"
      },
    ]
  }

  backend_params = [
    // health check path, port name, port number, timeout seconds.
    "/,http,80,10",
  ]
}
