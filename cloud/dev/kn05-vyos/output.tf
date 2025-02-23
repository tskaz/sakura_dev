output "server_info" {
  value = {
    "hostname"        = sakuracloud_server.vyos_sv[*].hostname,
    "ip_address"      = sakuracloud_server.vyos_sv[*].network_interface[0].user_ip_address,
    "ssh_cmd_example" = format("ssh vyos@%s -i [ssh_key]", sakuracloud_server.vyos_sv[0].ip_address)
  }
}
