resource "azurerm_storage_account" "logic_app" {
  name                     = "eklogicappsa"
  resource_group_name      = azurerm_resource_group.logic_app.name
  location                 = azurerm_resource_group.logic_app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "logic_app" {
  name                  = "json"
  storage_account_name  = azurerm_storage_account.logic_app.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "logic_app" {
  scope              = azurerm_storage_account.logic_app.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id       = azurerm_logic_app_workflow.logic_app.identity[0].principal_id
}
