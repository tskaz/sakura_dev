output "server_info" {
  value = {
    "svname"        = sakuracloud_server.server[0].name,
    "os"              = data.sakuracloud_archive.os.name,
    "ip_address"      = sakuracloud_server.server[0].ip_address,
    "ssh_cmd_example" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.server[0].ip_address)
  }
}

