resource "sakuracloud_switch" "sw" {
  name = "${var.authorname}-sw"
  zone = var.zone
}

