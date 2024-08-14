variable "pjname" {
#pjの固有名称,接頭辞など /Unique names of pj, prefixes, etc.
  default = "ktsuruta"
}

variable "root_password" {
#OS管理ユーザのパスワード /Password for OS admin user
  default = "sacloud_test!"
}

variable "zone" {
#使用するゾーン(東京第２はtk1b) /Zone to be used (tk1b for Tokyo 2) 
  default = "is1b" # tk1b, is1b # tk1a, is1a
  #  default = "is1b" # tk1b, is1b # tk1a, is1a
}

variable "os" {   
#使用するOSイメージ名 /Name of OS image to be used 
  default = "Ubuntu Server 22.04.4 LTS 64bit"
}

variable "diskedit_enable" {
#ディスク修正の利用フラグ /Disk modification use flag (contents of svscript.sh will be executed)
  default = true
}

variable "core" {
#サーバのコア数 /Enter the number of cores in the server
  default = "2"
}

variable "memory" {
#サーバのメモリ数 /Enter the number of RAM in the server
  default = "4"
}

variable "svcount" {
#サーバの台数 /Enter the number of servers
  default = "2"
}

variable "nw_backend" {
# バックエンドNICのNWアドレス(第３オクテットまで) /NW address of backend NIC (up to the third octet)
#  default = "192.168.200."
}

variable "hostip_backend" {
# バックエンドNICのNWアドレス /Enter the NW address of the backend NIC
  type = number
#  default = 211
}

variable "gw_backend" {
# バックエンドNICのGWアドレス
#  default = "192.168.200.1"
}

variable "netmask_backend" {
# バックエンドNICのネットマスク値
#  default = "24"
}

##既存リソースのサービスコードを入力 /Enter the service code of an existing resource
variable "rtswid_front" {
#フロントルータ+スイッチのサービスコード /Enter the service code for the front router + switch
  default = "999999999999"
}

variable "swid_backend" {
#バックエンドスイッチのサービスコード /Enter the service code for the backend switch
  default = "999999999999"
}

variable "pfid_front" {
#フロントNIC用パケットフィルタのサービスコード /Enter the service code of the packet filter for the front NIC
  default = "999999999999"
}

variable "pfid_backend" {
# バックエンドNIC用パケットフィルタのサービスコード /Enter the service code of the packet filter for the backend NIC
  default = "999999999999"
}