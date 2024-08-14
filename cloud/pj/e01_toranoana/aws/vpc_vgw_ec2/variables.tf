# environmental variables
variable "office_cidr" {
  default = "192.168.101.0/24"
}

# tag
variable "label" {
  default = {
    namespace = "saleseng"
    stage     = "dev"
    name      = "awsdx-s3endpoints"
  }
}

# network
variable "vpc" {
  default = {
    cidr = "172.16.0.0/16"
  }
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "sakura_cidr" {
  default = ["192.168.100.0/23"]
}

# ami
variable "instance_common" {
  default = {
    destribution = "ubuntu"
    version      = "bionic"
  }
}
