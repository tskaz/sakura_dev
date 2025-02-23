resource "sakuracloud_server" "vyos_sv" {
  count = var.vyos["count"]
  zone  = var.zone
  name  = format("%s-%s%03d", module.label.id, var.vyos["name"], "${count.index + 1}")
  core  = var.vyos["core"]
  memory  = var.vyos["memory"]
  disks = [sakuracloud_disk.os_disk[count.index].id]
  network_interface {
    upstream = "shared"
  }
#  cdrom_id = sakuracloud_cdrom.iso.id
}

resource "sakuracloud_disk" "os_disk" {
  count = var.vyos["count"]
  name              = format("%s-%s%03d%s", module.label.id, var.vyos["name"], "${count.index + 1}","os_disk")
  zone              = var.zone
  
  size              = var.vyos["disk_size"]
}