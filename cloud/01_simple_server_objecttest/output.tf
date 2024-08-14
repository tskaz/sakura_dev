output "server_info" {
  value = {
    "hostname"        = sakuracloud_server.srv01.hostname,
    "os"              = data.sakuracloud_archive.os.name,
    "ssh_cmd_example" = format("ssh root@%s -i [ssh_key]", sakuracloud_server.srv01.ip_address),
  }
}