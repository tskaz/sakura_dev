variable "pjname" {
  default = "ktsuruta"
}

variable "password" {
  default = "1221sakura"
}

variable "root_password" {
  default = "sacloud_test!"
}

variable "zone" {
  default = "is1b" # tk1b, is1b # tk1a, is1a
}

variable "os" {   
  default = "Ubuntu Server 22.04.4 LTS 64bit"
}

variable "diskedit_enable" {
  default = true
}

variable "user_data_enable" {
  default = false
}

variable "core" {
  default = "2"
}

variable "memory" {
  default = "4"
}

variable "svcount" {
  default = "1"
}

variable "rtswid_front" {
  default = "113501924551"
}

variable "swid_backend" {
  default = "113501118025"
}

variable "pfid_front" {
  default = "113601574652"
}

variable "pfid_backend" {
  default = "113601574655"
}

variable "ip_backend" {
  default = "192.168.200.212"
}

variable "gw_backend" {
  default = "192.168.200.1"
}

variable "netmask_backend" {
  default = "24"
}

variable "source_disk_id" {
  default = "113601575860"
}

