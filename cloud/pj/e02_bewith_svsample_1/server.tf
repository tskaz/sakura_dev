resource "sakuracloud_server" "server" {
  name  = "${var.pjname}-sv0${count.index+2}"
  count = var.svcount
  zone  = var.zone
  core  = var.core
  memory  = var.memory
  disks = [sakuracloud_disk.os_disk[count.index].id]
  
  network_interface {
    upstream        = data.sakuracloud_internet.rtsw_front.switch_id
    user_ip_address = data.sakuracloud_internet.rtsw_front.ip_addresses[1]
    packet_filter_id = data.sakuracloud_packet_filter.pf_front.id
  }

  network_interface {
    upstream        = data.sakuracloud_switch.sw_backend.id
    user_ip_address = var.ip_backend
    packet_filter_id = data.sakuracloud_packet_filter.pf_backend.id
  }

  user_data = var.user_data_enable == true ? data.template_file.user_data[count.index].rendered : null

  dynamic "disk_edit_parameter" {
    for_each = var.diskedit_enable == true ? [1] : []
    content {
        hostname        = "${var.pjname}-sv0${count.index+2}"
        password        = var.root_password
        disable_pw_auth = true
        ip_address      = data.sakuracloud_internet.rtsw_front.ip_addresses[1]
        gateway         = data.sakuracloud_internet.rtsw_front.gateway
        netmask         = data.sakuracloud_internet.rtsw_front.netmask
        ssh_keys        = [sakuracloud_ssh_key.keys[count.index].public_key]
          note {
            id = sakuracloud_note.script.id
            variables = {
              ip_backend = "${var.ip_backend}",
              gw_backend = "${var.gw_backend}",
              netmask_backend = "${var.netmask_backend}"
            }
          }
    }
  }
  depends_on = [sakuracloud_ssh_key.keys]
}

data "template_file" "user_data" {
  count  = var.user_data_enable == true ? var.svcount : 0
  template = file("../../cc/ubuntu2204.yaml")
  vars = {
    hostname         = "${var.pjname}-sv0${count.index+1}"
    root_password    = var.root_password
    password         = var.password
    sshkey_pub       = sakuracloud_ssh_key.keys[count.index].public_key
    ip_address       = data.sakuracloud_internet.rtsw_front.ip_addresses[0]
    gateway          = data.sakuracloud_internet.rtsw_front.gateway
    netmask          = data.sakuracloud_internet.rtsw_front.netmask
  }
}


data "sakuracloud_archive" "os" {
  #  os_type = "ubuntu"
  zone = var.zone
  filter {
    names = [var.os]
  }
}

resource "sakuracloud_disk" "os_disk" {
  count             = var.svcount
  name              = "${var.pjname}-sv0${count.index+1}_os"
  zone              = var.zone
  plan              = "ssd"
  size              = 100
  source_disk_id = var.source_disk_id
}
