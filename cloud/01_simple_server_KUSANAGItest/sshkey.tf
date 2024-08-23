locals  {
  ssh_keys = "."
}


resource "null_resource" "ssh-keygen" {
  count = var.svcount
  provisioner "local-exec" {
    command = "ssh-keygen -m PEM  -C '' -N '' -f ${local.ssh_keys}/id_rsa_sv0${count.index+1}; exit 0"
  }
}

data "local_file" "ssh-keygen" {
  count = var.svcount
  filename   = "${local.ssh_keys}/id_rsa_sv0${count.index+1}.pub"
  depends_on = [null_resource.ssh-keygen]
}

output "pub_keys" {
  value = data.local_file.ssh-keygen[*].content
}

resource "sakuracloud_ssh_key" "keys" {
  count = var.svcount
  name       = "sshkey_${var.authorname}-sv0${count.index+1}"
  public_key = data.local_file.ssh-keygen[count.index].content
}