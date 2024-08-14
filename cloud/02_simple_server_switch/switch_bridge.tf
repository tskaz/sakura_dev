resource "sakuracloud_switch" "sw-tk1b-webap" {
  name        = "sw-tk1b-apdb"
  zone        = "tk1b"
}
resource "sakuracloud_switch" "sw-tk1b-apdb" {
  name        = "sw-tk1b-apdb"
  zone        = "tk1b"
  bridge_id = sakuracloud_bridge.br-tk1b-is1b-apdb.id
}

resource "sakuracloud_switch" "sw-tk1b-dbrep" {
  name        = "sw-tk1b-dbrep"
  zone        = "tk1b"
  bridge_id = sakuracloud_bridge.br-tk1b-is1b-dbrep.id

}

resource "sakuracloud_switch" "sw-is1b-webap" {
  name        = "sw-is1b-webap"
  zone        = "is1b"
}
resource "sakuracloud_switch" "sw-is1b-apdb" {
  name        = "sw-is1b-apdb"
  zone        = "is1b"
  bridge_id = sakuracloud_bridge.br-tk1b-is1b-apdb.id
}

resource "sakuracloud_switch" "sw-is1b-dbrep" {
  name        = "sw-is1b-dbrep"
  zone        = "is1b"
  bridge_id = sakuracloud_bridge.br-tk1b-is1b-dbrep.id
}

resource "sakuracloud_bridge" "br-tk1b-is1b-apdb" {
  name        = "br-tk1b-is1b-apdb"
  zone        = "tk1b"
}

resource "sakuracloud_bridge" "br-tk1b-is1b-dbrep" {
  name        = "br-tk1b-is1b-dbrep"
  zone        = "tk1b"
}