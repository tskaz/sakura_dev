data "sakuracloud_internet" "rtsw_front" {
  zone = var.zone
  filter {
    id = var.rtswid_front
  }
}

data "sakuracloud_switch" "sw_backend" {
  zone = var.zone
  filter {
    id = var.swid_backend
  }
}