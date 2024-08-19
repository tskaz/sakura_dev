resource "wireguard_asymmetric_key" "wg_key" {
  count  = var.sw_already_exisits == true ? 0 : 1
}

resource "null_resource" "wg_keys" {
  count  = var.sw_already_exisits == true ? 0 : 1
  provisioner "local-exec" {
    command = "echo ${wireguard_asymmetric_key.wg_key[0].public_key} >> ./wg_keys && echo ${wireguard_asymmetric_key.wg_key[0].private_key} >> ./wg_keys; exit 0"
  }
}
