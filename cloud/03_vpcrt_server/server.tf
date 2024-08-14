resource "sakuracloud_server" "srv01" {
  name  = "${var.authorname}-win"
  zone  = var.zone
  core  = var.core
  memory  = var.memory
  disks = [sakuracloud_disk.os_disk.id]
  network_interface {
    upstream        = sakuracloud_switch.sw.id
    user_ip_address = "192.168.100.11"
    #  packet_filter_id = sakuracloud_packet_filter.filter.id
  }
  #    user_data = data.template_file.user_data.rendered
  #    disk_edit_parameter {
  #      hostname        = var.hostname
  #      password        = 
  #      disable_pw_auth = true
  #      ssh_key_ids     = ["<ID>", "<ID>"]
  #   note {
  #    id         = "<ID>"
  #    api_key_id = "<ID>"
  #    variables = {
  #      foo = "bar"
  #    }
  #   }
  #  }
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
  name              = var.authorname
  zone              = var.zone
  plan              = "ssd"
  size              = 100
  source_archive_id = data.sakuracloud_archive.os.id
}
