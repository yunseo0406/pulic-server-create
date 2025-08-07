resource "ncloud_login_key" "key" {
  key_name = "yunseo-key"
}
output "private_key" {
  value     = ncloud_login_key.key.private_key
  sensitive = true
}