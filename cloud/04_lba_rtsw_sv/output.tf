output "server_info" {
  value = {
    "svname1"        = sakuracloud_server.server[0].name,
    "svname2"        = sakuracloud_server.server[1].name,
    "os"              = data.sakuracloud_archive.os.name,
    "ip_address1"      = sakuracloud_server.server[0].ip_address,
    "ip_address2"      = sakuracloud_server.server[1].ip_address,
    "ssh_cmd_example1" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.server[0].ip_address),
    "ssh_cmd_example2" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.server[1].ip_address)
  }
}


output "lba_info" {
  value = {
    "lba_ip"         = sakuracloud_load_balancer.lba.network_interface[0].ip_addresses,
    "vip"     = sakuracloud_load_balancer.lba.vip[0].vip,
    "real_server1_ip"     = sakuracloud_load_balancer.lba.vip[0].server[0].ip_address,
    "real_server2_ip"     = sakuracloud_load_balancer.lba.vip[0].server[1].ip_address
  }
}