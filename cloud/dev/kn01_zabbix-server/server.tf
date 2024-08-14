  resource "sakuracloud_server" "srv01" {
    name  = var.hostname
    zone  = var.default_zone
    disks = [sakuracloud_disk.os_disk.id]
    network_interface {
      upstream         = "shared"
    #  packet_filter_id = sakuracloud_packet_filter.filter.id
    }
    user_data = data.template_file.user_data.rendered
    #disk_edit_parameter {
    #  hostname        = var.hostname
    #  password        = var.root_password
    #  disable_pw_auth = false
    # ssh_key_ids     = ["<ID>", "<ID>"]
    # note {
    #  id         = "<ID>"
    #  api_key_id = "<ID>"
    #  variables = {
    #    foo = "bar"
    #  }
    # }
    #}
  }

  data "template_file" "user_data" {
    template = file("../cc/alma93_zabbix.yaml")
    vars = {
      hostname         = var.hostname
      root_password    = var.root_password
      password         = var.password
    }
  }

  data "sakuracloud_archive" "os" {
    #  os_type = "ubuntu"
    zone = var.default_zone
    filter {
      names = [var.os]
    }
  }

  resource "sakuracloud_disk" "os_disk" {
    name              = "${var.hostname}_os"
    zone              = var.default_zone
    source_archive_id = data.sakuracloud_archive.os.id
  }
