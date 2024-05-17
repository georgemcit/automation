locals{
  window_app=[for f in fileset("${path.module}/${var.dev}", "[^_]*.yaml") : yamldecode(file("${path.module}/${var.dev}/${f}"))]
  window_app_list = flatten([
    for app in local.window_app : [
      for windowapps in try(app.listofwindowsapp, []) :{
        name=windowapps.name
        os_type=windowapps.os_type
        sku_name=windowapps.sku_name

      }
    ]
])
}
resource "azurerm_service_plan" "george" {
  name                = {for sp in local.window_app: "${sp.name}"=>sp }
  resource_group_name = azurerm_resource_group.george_ibrahim.name
  location            = azurerm_resource_group.george_ibrahim.location
  sku_name            = each.value.name
  os_type             = each.value.type
}

resource "azurerm_windows_web_app" "george1980" {
  name                = azurerm_service_plan.george
  resource_group_name = azurerm_resource_group.george_ibrahim.name
  location            = azurerm_service_plan.george_ibrahim.location
  service_plan_id     = each.value.id

  site_config {}
}
