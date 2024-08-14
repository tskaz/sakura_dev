resource "sakuracloud_vpc_router" "vpcrt" {
  name                = "${var.authorname}-vpcrt"
  plan                = var.vpcrt_plan
  internet_connection = true
  zone                = var.zone
#  public_network_interface {
#    switch_id    = sakuracloud_internet.rtsw.switch_id
#    vip          = sakuracloud_internet.rtsw.ip_addresses[0]
#    ip_addresses = [sakuracloud_internet.rtsw.ip_addresses[1], sakuracloud_internet.rtsw.ip_addresses[2]]
#    aliases      = [sakuracloud_internet.rtsw.ip_addresses[3]]
#    vrid         = 1
#  }

  private_network_interface {
    index        = 1
    switch_id    = sakuracloud_switch.sw.id
    ip_addresses   = ["192.168.100.1"]
#    vip          = "192.168.100.1"
#    ip_addresses = ["192.168.100.2", "192.168.100.3"]
    netmask      = 24
  }

  wire_guard {
    ip_address = "192.168.101.1/24"
    peer {
      name       = "user01"
      ip_address = "192.168.101.11"
      public_key = "JcK2UgHclTX/dNW1PSJ4obDdndO0MGDCSKhNw4JbQEI="
    }
  }
}
