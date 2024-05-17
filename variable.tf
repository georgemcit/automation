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
  name                = "george"
  resource_group_name = azurerm_resource_group.george_ibrahim.name
  location            = azurerm_resource_group.george_ibrahim.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "george1980" {
  name                = "george1980"
  resource_group_name = azurerm_resource_group.george_ibrahim.name
  location            = azurerm_service_plan.george_ibrahim.location
  service_plan_id     = azurerm_service_plan.george.id

  site_config {}
}
