output "some_output" {
  value = "${data.null_data_source.test.outputs["some_value"]}"
}
