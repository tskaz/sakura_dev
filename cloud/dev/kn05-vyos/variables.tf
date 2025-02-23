variable "zone" {
  default = "tk1b" # tk1b, is1b # tk1a, is1a
}

variable "label" {
  default = {
    namespace = ""
    stage     = ""
    name      = "ktsuruta"
  }
}

variable "password" {
  default = ""
}

variable "vyos" {
  default = {
    count            = 1
    core             = 2
    memory           = 4
    name             = "vyos"
    start_ip         = 10
    disk_size        = 20     
  }
}