locals  {
  ssh_keys = "."
}


resource "null_resource" "ssh-keygen" {
  count = var.zbx_sv["count"]
  provisioner "local-exec" {
    command = "ssh-keygen -m PEM  -C '' -N '' -f ${local.ssh_keys}/id_rsa_zbx0${count.index+1}; exit 0"
  }
}

data "local_file" "zbx_ssh-keygen" {
  count = var.zbx_sv["count"]
  filename   = "${local.ssh_keys}/id_rsa_zbx0${count.index+1}.pub"
  depends_on = [null_resource.ssh-keygen]
}

#output "zbx_pub_keys" {
#  value = data.local_file.zbx_ssh-keygen[*].content
#}

resource "sakuracloud_ssh_key" "zbx_keys" {
  count = var.zbx_sv["count"]
  name       = "sshkey_zbx0${count.index+1}"
  public_key = data.local_file.zbx_ssh-keygen[count.index].content
}