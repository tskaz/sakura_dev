resource "sakuracloud_load_balancer" "lba" {
  name = "${var.authorname}-lba"
  plan = "standard"
  zone = var.zone

  network_interface {
    switch_id    = sakuracloud_internet.rtsw.switch_id
    vrid         = 1
    ip_addresses = [sakuracloud_internet.rtsw.ip_addresses[5]]
    netmask      = 28
    gateway      = sakuracloud_internet.rtsw.gateway
  } 

  vip {
    vip          = sakuracloud_internet.rtsw.ip_addresses[6]
    port         = 80
    delay_loop   = 10

    server {
      ip_address = sakuracloud_server.server[0].ip_address
      protocol   = "ping"
    }
    server {
      ip_address = sakuracloud_server.server[1].ip_address
      protocol   = "ping"
    }
  }
}