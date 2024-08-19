data "sakuracloud_switch" "existing_sw" {
  zone = var.zone
  filter {
    id = var.existing_sw["sw_id"]
  }
}

resource "sakuracloud_switch" "new_sw" {
  count  = var.sw_already_exisits == true ? 0 : 1
  name = format("%s-%s", module.label.id, "sw")
  zone = var.zone
}

#resource "sakuracloud_internet" "new_rtsw" {
#  name        = format("%s-%s", module.label.id, "rtsw")
#  netmask     = 28
#  band_width  = 100
#  enable_ipv6 = false
#  zone        = var.zone
#}