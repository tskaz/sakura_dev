resource "sakuracloud_server" "zbx_sv" {
  count = var.zbx_sv["count"]
  zone  = var.zone
  name  = format("%s-%s%03d", module.label.id, var.zbx_sv["name"], "${count.index + 1}")
  core  = var.zbx_sv["core"]
  memory  = var.zbx_sv["memory"]
  disks = [sakuracloud_disk.os_disk[count.index].id]
  
  dynamic "network_interface" {
    for_each = var.sw_already_exisits == false ? [1] : [] 
    content {
      upstream        = sakuracloud_switch.new_sw[0].id
      user_ip_address = cidrhost(var.new_sw["nw"],var.zbx_sv["start_ip"] + count.index)
    }
  }

  dynamic "network_interface" {
    for_each = var.sw_already_exisits == true ? [1] : [] 
    content {
      upstream        = data.sakuracloud_switch.existing_sw.id
      user_ip_address = cidrhost(var.existing_sw["nw"],var.zbx_sv["start_ip"] + count.index)
    }
  }

  user_data = var.user_data_enable == true ? data.template_file.user_data[count.index].rendered : null

  dynamic "disk_edit_parameter" {
    for_each = var.diskedit_enable == true ? [1] : []
    content {
        hostname        = format("%s-%s%03d", module.label.id, var.zbx_sv["name"], count.index + 1)
        password        = var.password
        disable_pw_auth = true
        ip_address      = var.sw_already_exisits == true ? cidrhost(var.existing_sw["nw"],var.zbx_sv["start_ip"] + count.index) : cidrhost(var.new_sw["nw"],var.zbx_sv["start_ip"] + count.index)
        gateway      = var.sw_already_exisits == true ? var.existing_sw["gw"] : sakuracloud_vpc_router.vpcrt[0].private_network_interface[0].ip_addresses[0]
#        gateway      = var.sw_already_exisits == true ? var.existing_sw["gw"] : sakuracloud_vpc_router.vpcrt[0].private_network_interface[0].vip
        netmask         = var.sw_already_exisits == true ? var.existing_sw["netmask"] : sakuracloud_vpc_router.vpcrt[0].private_network_interface[0].netmask
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
  depends_on = [sakuracloud_ssh_key.zbx_keys]
}

data "template_file" "user_data" {
  count = var.zbx_sv["count"]
  template = file("userdata/alma93_zabbix.yaml")
  vars = {
    hostname         = format("%s-%s%03d", module.label.id, var.zbx_sv["name"], count.index + 1)
    password         = var.password
    ssh_pubkey       = [sakuracloud_ssh_key.zbx_keys[count.index].public_key]
    ip_address       = var.sw_already_exisits == true ? cidrhost(var.existing_sw["nw"], var.zbx_sv["start_ip"] + count.index) : cidrhost(var.new_sw["nw"],var.zbx_sv["start_ip"] + count.index)
    gateway      = var.sw_already_exisits == true ? var.existing_sw["gw"] : sakuracloud_vpc_router.vpcrt[0].private_network_interface[0].ip_addresses[0]
#    gateway      = var.sw_already_exisits == true ? var.existing_sw["gw"] : sakuracloud_vpc_router.vpcrt[0].private_network_interface[0].vip
    netmask         = var.sw_already_exisits == true ? var.existing_sw["netmask"] : sakuracloud_vpc_router.vpcrt[0].private_network_interface[0].netmask
    ssh_pubkey       = sakuracloud_ssh_key.zbx_keys[count.index].public_key
  }
}


data "sakuracloud_archive" "os" {
  zone = var.zone
  filter {
    names = [var.os]
  }
}
resource "sakuracloud_disk" "os_disk" {
  count = var.zbx_sv["count"]
  name              = format("%s-%s%03d%s", module.label.id, var.zbx_sv["name"], "${count.index + 1}","os_disk")
  zone              = var.zone
  source_archive_id = data.sakuracloud_archive.os.id
}