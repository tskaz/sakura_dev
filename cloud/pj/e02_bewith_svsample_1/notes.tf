resource "sakuracloud_note" "script" {
  name    = "sv_script"
  class   = "shell"
  content = file("sv_script.sh")
}