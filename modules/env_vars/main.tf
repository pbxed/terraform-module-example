locals {
  common = merge(
    var.common_env_vars,
    {
      "module_sourced_variable" : "example2"
    })
}