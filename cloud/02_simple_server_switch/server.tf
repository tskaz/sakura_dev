resource "sakuracloud_server" "sv" {
  count       = 2
  name        = "sv0[count.index]"
  disks       = [sakuracloud_disk.foobar.id]
  description = ""
  tags        = ["ktsuruta"]

  network_interface {
    upstream         = "shared"
    packet_filter_id = sakuracloud_packet_filter.foobar.id
  }

  disk_edit_parameter {
    hostname        = sakuracloud_server.sv.name
    password        = "Sacloud!"
    disable_pw_auth = false

    # ssh_key_ids     = ["<ID>", "<ID>"]
    # note {
    #  id         = "<ID>"
    #  api_key_id = "<ID>"
    #  variables = {
    #    foo = "bar"
    #  }
    # }
  }
}

resource "sakuracloud_packet_filter" "foobar" {
  name        = "foobar"
  description = "test"

  expression {
    protocol         = "tcp"
    destination_port = "22"
  }
  expression {
    protocol    = "ip"
    allow       = false
    description = "Deny ALL"
  }
}

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu"
}

resource "sakuracloud_disk" "foobar" {
  name              = "srv01"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
}
