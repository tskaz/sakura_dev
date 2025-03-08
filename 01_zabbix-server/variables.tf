variable "zone" {
  default = "tk1b" # tk1b, is1b # tk1a, is1a
}

variable "label" {
  default = {
    namespace = "sakuracloud"
    stage     = "dev"
    name      = "zabbix"
  }
}

variable "password" {
}

variable "zbx_sv" {
  default = {
    count            = 1
    core             = 2
    memory           = 4
    name             = "zbx"
    disable_pw_auth  = true
    start_ip         = 100
  }
}

variable "sw_already_exisits" {
  default = false
}

variable "existing_sw" {
  default = {
    sw_id = "113601077660"
    nw = "192.168.100.0/24"
    gw = "192.168.100.254"
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
    netmask = "24"
    pf_zabbix_pub = "8080"
    pf_zabbix_prv = "8080"
    pf_ssh_pub = "10022"
    pf_ssh_prv = "22"
  }
}
