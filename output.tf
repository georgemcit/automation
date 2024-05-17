output "azure_linux_app" {
  value = local.linux_app_list
}
output "names_linux_app" {
  value=[for app in local.linux_app_list : app.name]
}
output "os_linux_app" {
  value=[for app in local.linux_app_list : app.os_type]
}
output "sku_linux_app" {
  value=[for app in local.linux_app_list : app.sku_name]
}
output "linuxappconfiguration" {
  value = var.linuxappconfiguration
}
