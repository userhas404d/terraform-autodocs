data "null_data_source" "test" {
  inputs = {
    some_value = "${var.echo_var}"
  }
}
