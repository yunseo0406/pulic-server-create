resource "ncloud_server" "test-server" {
  subnet_no                 = ncloud_subnet.public_subnet.id
  name                      = "test-server"
  server_image_number       = "23214590" # ubuntu 22.04-base
  server_spec_code          = "s2-g3"
  login_key_name            = ncloud_login_key.key.key_name
  access_control_group_configuration_no_list = [ncloud_access_control_group.acg.id]
}

resource "ncloud_public_ip" "public_ip" {
  server_instance_no = ncloud_server.test-server.id
}