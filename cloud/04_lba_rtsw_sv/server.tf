resource "sakuracloud_server" "server" {
  name  = "${var.authorname}-sv0${count.index+1}"
  count = var.svcount
  zone  = var.zone
  core  = var.core
  memory  = var.memory
  disks = [sakuracloud_disk.os_disk[count.index].id]
  network_interface {
#    upstream        = "shared"
    upstream        = sakuracloud_internet.rtsw.switch_id
    user_ip_address = sakuracloud_internet.rtsw.ip_addresses[count.index]
    packet_filter_id = sakuracloud_packet_filter.pf.id
  }
  user_data = var.user_data_enable == true ? data.template_file.user_data[count.index].rendered : 0

  dynamic "disk_edit_parameter" {
    for_each = var.diskedit_enable == true ? [1] : []
    content {
        hostname        = "${var.authorname}-sv0${count.index+1}"
        password        = var.root_password
        disable_pw_auth = true
        ip_address      = sakuracloud_internet.rtsw.ip_addresses[count.index]
        gateway         = sakuracloud_internet.rtsw.gateway
        netmask         = sakuracloud_internet.rtsw.netmask
        ssh_keys        = [sakuracloud_ssh_key.keys[count.index].id]
    }
  }
  depends_on = [sakuracloud_ssh_key.keys]
}

  data "template_file" "user_data" {
    count  = var.user_data_enable == true ? var.svcount : null
    template = file("../cc/alma93_lba.yaml")
    vars = {
      hostname         = "${var.authorname}-sv0${count.index+1}"
      root_password    = var.root_password
      password         = var.password
      sshkey_pub       = sakuracloud_ssh_key.keys[count.index].public_key
      ip_address       = sakuracloud_internet.rtsw.ip_addresses[count.index]
      netmask          =  sakuracloud_internet.rtsw.netmask
      gateway          = sakuracloud_internet.rtsw.gateway
      lba_vip          = sakuracloud_internet.rtsw.ip_addresses[6]
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
  name              = "${var.authorname}-sv0${count.index+1}_os"
  zone              = var.zone
  plan              = "ssd"
  size              = 100
  source_archive_id = data.sakuracloud_archive.os.id
}
