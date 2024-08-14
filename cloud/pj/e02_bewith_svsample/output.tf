output "server_info" {
  value = {
    "svname"        = sakuracloud_server.server[*].name,
    "os"              = data.sakuracloud_archive.os.name,
    "ip_address"      = sakuracloud_server.server[*].ip_address
  }
}

