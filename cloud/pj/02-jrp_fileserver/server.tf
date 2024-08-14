locals {
  hostname = "${var.authorname}-${var.pj}_winsv"
}

resource "sakuracloud_server" "srv01" {
  name  = local.hostname
  zone  = var.zone
  core  = var.core
  memory  = var.memory
  disks = [sakuracloud_disk.os_disk.id,sakuracloud_disk.data_disk.id]
  network_interface {
    upstream        = sakuracloud_switch.sw.id
    user_ip_address = "192.168.100.11"
    #  packet_filter_id = sakuracloud_packet_filter.filter.id
  }
  #    user_data = data.template_file.user_data.rendered
  disk_edit_parameter {
    hostname        = local.hostname
    ip_address      = "192.168.100.11"
    netmask         = "24"
    gateway         = "192.168.100.1"
  }

}

#  data "template_file" "user_data" {
#    template = file("cloud-config.yaml")
#    vars = {
#      hostname         = var.hostname
#      password         = var.password
#    }
#  }

#  resource "sakuracloud_packet_filter" "filter" {
#    name = var.authorname
#    zone = var.zone
#
#    expression {
#      protocol         = "tcp"
#      destination_port = "22"
#    }
#    expression {
#      protocol    = "ip"
#      allow       = false
#      description = "Deny ALL"
#    }
#  }

data "sakuracloud_archive" "os" {
  #  os_type = "ubuntu"
  zone = var.zone
  filter {
    names = [var.os]
  }
}

resource "sakuracloud_disk" "os_disk" {
  name              = "${var.authorname}-${var.pj}-winsv_os"
  zone              = var.zone
  plan              = "ssd"
  size              = 100
  source_archive_id = data.sakuracloud_archive.os.id
}

resource "sakuracloud_disk" "data_disk" {
  name              = "${var.authorname}-${var.pj}-winsv_data"
  zone              = var.zone
  plan              = "ssd"
  size              = 20
}

