data "sakuracloud_packet_filter" "pf_front" {
  zone = var.zone
  filter {
    id = var.pfid_front
  }
}


data "sakuracloud_packet_filter" "pf_backend" {
  zone = var.zone
  filter {
    id = var.pfid_backend
  }
}
