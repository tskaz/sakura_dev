output "server_info" {
  value = {
    "hostname"        = sakuracloud_server.srv01.hostname,
    "os"              = data.sakuracloud_archive.os.name,
    "ssh_cmd_example" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.srv01.ip_address),
  }
}


output "vpcrt_info" {
  value = {
    "vpcrt_ip"         = sakuracloud_vpc_router.vpcrt.public_ip,
    "wg_nwip"     = sakuracloud_vpc_router.vpcrt.wire_guard[0].ip_address,
    "wg_nwpubkey" = sakuracloud_vpc_router.vpcrt.wire_guard[0].public_key
  }
}