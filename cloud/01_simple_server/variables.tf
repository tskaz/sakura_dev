variable "authorname" {
  default = "ktsuruta"
}

variable "password" {
  default = "1221sakura"
}

variable "root_password" {
  default = "1221sakura!"
}

variable "zone" {
  default = "is1b" # tk1b, is1b # tk1a, is1a
}

variable "os" {   

  default = "Ubuntu Server 22.04.3 LTS 64bit (cloudimg)"
#  default = "Ubuntu Server 22.04.4 LTS 64bit"
#  default = "Alma Linux 9.3 (cloudimg)"
}

variable "diskedit_enable" {
  default = false
}

variable "user_data_enable" {
  default = true
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

