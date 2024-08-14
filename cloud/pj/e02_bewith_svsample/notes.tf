resource "sakuracloud_note" "script" {
  name    = "sv_script"
  class   = "shell"
  content = file("scripts/sv_script.sh")
}