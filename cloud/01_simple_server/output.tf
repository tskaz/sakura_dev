output "server_info" {
  value = {
    "svname1"        = sakuracloud_server.server[0].name,
#    "svname2"        = try(sakuracloud_server.server[1],sakuracloud_server.server[1].name),
    "os"              = data.sakuracloud_archive.os.name,
    "ip_address1"      = sakuracloud_server.server[0].ip_address,
#    "ip_address2"      = sakuracloud_server.server[1].ip_address,
    "ssh_cmd_example1" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.server[0].ip_address),
#    "ssh_cmd_example2" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.server[1].ip_address)
  }
}