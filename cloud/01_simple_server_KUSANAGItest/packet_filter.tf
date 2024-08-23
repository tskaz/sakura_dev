data "http" "ip_address" {
  url = "https://api.ipify.org/"
}

resource "sakuracloud_packet_filter" "pf" {
  name        = "${var.authorname}-filter"
  zone        = var.zone  
  expression {
    protocol         = "ip"
    source_network   = data.http.ip_address.response_body
    description = "office_ip"
  }

  expression {
    protocol         = "tcp"
    destination_port = "80"
  }

  expression {
    protocol         = "tcp"
    destination_port = "443"
  }

  expression {
    protocol = "icmp"
  }

  expression {
    protocol = "fragment"
  }

  expression {
    protocol    = "udp"
    source_port = "123"
  }

  expression {
    protocol         = "tcp"
    destination_port = "32768-61000"
  }

  expression {
    protocol         = "udp"
    destination_port = "32768-61000"
  }

  expression {
    protocol    = "ip"
    allow       = false
    description = "Deny ALL"
  }
}