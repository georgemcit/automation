output "azure_window_app" {
  value = local.window_app_list
}
output "names_window_app" {
  value=[for app in local.window_app_list : app.name]
}
output "os_window_app" {
  value=[for app in local.window_app_list : app.os_type]
}
output "sku_window_app" {
  value=[for app in local.window_app_list : app.sku_name]
}
output "dev" {
  value = var.vev
}
