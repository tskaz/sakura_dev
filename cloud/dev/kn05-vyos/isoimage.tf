locals {
  vyos_iso = "vyos-1.5-rolling-202502170007-generic-amd64.iso"
}


resource "sakuracloud_cdrom" "iso" {
  name           = "vyos_iso"
  size           = 5
  iso_image_file = local.vyos_iso
  description    = "vyos_iso"
  zone              = var.zone
}