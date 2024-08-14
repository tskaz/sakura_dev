resource "sakuracloud_internet" "rtsw" {
  name        = "${var.authorname}-rtsw"
  netmask     = 28
  band_width  = 100
  enable_ipv6 = false
  zone        = var.zone
}