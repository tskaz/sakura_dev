resource "sakuracloud_vpc_router" "vpcrt" {
  count  = var.sw_already_exisits == true ? 0 : 1
  name                = format("%s-%s", module.label.id, "vpcrt")
  plan                = var.vpcrt["plan"]
  internet_connection = true
  zone                = var.zone
#  public_network_interface {
#    switch_id    = sakuracloud_internet.new_rtsw.switch_id
#    vip          = sakuracloud_internet.new_rtsw.ip_addresses[0]
#    ip_addresses = [sakuracloud_internet.new_rtsw.ip_addresses[1], sakuracloud_internet.new_rtsw.ip_addresses[2]]
#    aliases      = [sakuracloud_internet.new_rtsw.ip_addresses[3]]
#    vrid         = 1
#  }

  private_network_interface {
    index        = 1
    switch_id    = sakuracloud_switch.new_sw[0].id
    ip_addresses   = [cidrhost(var.vpcrt["prv_nw"],var.vpcrt["prv_hostip"])]
#    vip          = cidrhost(var.vpcrt["prv_nw"],var.vpcrt["prv_vip"])
#    ip_addresses = [for i in var.vpcrt["prv_realip"] : ciderhost(var.vpcrt["prv_nw"],i)]
    netmask      = var.vpcrt["netmask"]
  }
  port_forwarding {
    protocol     = "tcp"
    public_port  = 8080
    private_ip   = var.sw_already_exisits == true ? cidrhost(var.existing_sw["nw"], var.zbx_sv["start_ip"] + count.index) : cidrhost(var.new_sw["nw"],var.zbx_sv["start_ip"] + count.index)
    private_port = 8080
    description  = "zabbix-web"
  }
  
  wire_guard {
    ip_address = var.vpcrt["wg_nw"]
    peer {
      name       = var.vpcrt["wg_user"]
      ip_address = var.vpcrt["wg_user_ip"]
      public_key = wireguard_asymmetric_key.wg_key[0].public_key
    }
  }
}
