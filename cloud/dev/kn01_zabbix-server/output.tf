output "server_info" {
  value = {
    "hostname"        = data.template_file.user_data[*].vars.hostname,
    "os"              = data.sakuracloud_archive.os.name,
    "ip_address"      = sakuracloud_server.zbx_sv[*].network_interface[0].user_ip_address,
    "ssh_cmd_example" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.zbx_sv[0].ip_address)
  }
}

output "vpcrt_info" {
  value = {
    "vpcrt_ip"         = sakuracloud_vpc_router.vpcrt[*].public_ip,
    "zabbix_url" = format("http://%s:%s/zabbix ", sakuracloud_vpc_router.vpcrt[0].public_ip, lookup(element(sakuracloud_vpc_router.vpcrt[0].port_forwarding, 1), "public_port")),
    "wg_nwip"     = sakuracloud_vpc_router.vpcrt[*].wire_guard[0].ip_address,
    "wg_nwpubkey" = sakuracloud_vpc_router.vpcrt[*].wire_guard[0].public_key
  }
}
