resource "azurerm_resource_group" "example" {
  name     = "STrg00"
  location = "West Europe"
}
resource "random_id" "rd" {
  keepers = {
    # Generate a new id only when a new resource group is defined
    resource_group = azurerm_resource_group.example.name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "example" {
  name                     = "tststact${random_id.rd.hex}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}