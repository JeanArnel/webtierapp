# Database Tier - Azure Database for MySQL
resource "azurerm_mysql_server" "mysql" {
  name                = "mysqlserver"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  administrator_login = var.administrator_login
  administrator_login_password = var.administrator_login_password
  sku_name            = "GP_Gen5_2"
  storage_mb          = 5120
  version             = "5.7"
  auto_grow_enabled   = true
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  public_network_access_enabled = false
  ssl_enforcement_enabled       = true

}

resource "azurerm_mysql_database" "exampledb" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}

# Output the Public IP of the Web VM
output "web_vm_public_ip" {
  value = azurerm_linux_virtual_machine.web_vm.public_ip_address
}
