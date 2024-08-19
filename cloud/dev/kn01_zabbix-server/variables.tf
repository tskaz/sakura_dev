variable "zone" {
  default = "is1b" # tk1b, is1b # tk1a, is1a
}

variable "label" {
  default = {
    namespace = "sakuracloud"
    stage     = "dev"
    name      = "zabbix2"
  }
}

variable "password" {
  default = ""
}

variable "zbx_sv" {
  default = {
    count            = 1
    core             = 2
    memory           = 4
    name             = "zbx"
    disable_pw_auth  = true
    start_ip         = 10
  }
}

variable "sw_already_exisits" {
  default = false
}

variable "existing_sw" {
  default = {
    sw_id = "113601169374"
    nw = "192.168.100.0/24"
    gw = "192.168.100.1"
    netmask = "24"
  }
}

variable "new_sw" {
  default = {
    nw = "192.168.1.0/24"
    gw = "192.168.1.1"
    netmask = "24"
  }
}

variable "vpcrt" {
  default = {
    plan = "standard"
    prv_nw = "192.168.1.0/24"
    prv_hostip = 1
#    prv_vip = "1"
#    prv_realip = ["2","3"]
    netmask = "24"
    wg_nw = "192.168.101.1/24"
    wg_user = "user"
    wg_user_ip = "192.168.101.100"
  }
}

variable "os" {   
  default = "Alma Linux 9.3 (cloudimg)"
}

variable "diskedit_enable" {
  default = false
}

variable "user_data_enable" {
  default = true
}
