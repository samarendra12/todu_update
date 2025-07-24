resource "azurerm_mssql_database" "database" {
  name         = var.db_name
  server_id    = var.server_id
  collation    = var.collation
  license_type = var.license_type
  max_size_gb  = var.size_gb
  sku_name     = var.sku_name
  enclave_type = var.enclave_type

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}