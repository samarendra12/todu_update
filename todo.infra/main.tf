module "azurerm_resource_group" {
    source= "../modules/azurerm_resource_group"
    rg_name = "samar"
    rg_location = "west europe"
}
 module "azurerm_mssql_database" {
    source = "../modules/azurerm_sequal_database" 
    db_name = "samaridhi"
    server_id = "/subscriptions/ff2c3052-bd08-443f-80dd-1cabe7cbcd50/resourceGroups/samar/providers/Microsoft.Sql/servers/my-todo-sql-server1"
    collation = "SQL_Latin1_General_CP1_CI_AS"
    license_type= "LicenseIncluded"
    size_gb = 5
    sku_name = "S0"
    enclave_type= "VBS"
 }

 module "azurerm_mssql_server" {
   depends_on = [module.azurerm_resource_group]
    source = "../modules/azurerm_sql_server"
    resource_group_name = "samar"
    sql_server_name = "my-todo-sql-server1"
    location = "west us2"
    admin_login = "samarendra3"
    password = "Shivansh@123"

 }
module "azurerm_virtual_netwok" {
   depends_on = [module.azurerm_resource_group]
   source= "../modules/azurerm_virtual_network"
   name = "sam_vnet"
   location = "west europe"
   resource_group_name = "samar"
   address_space = ["10.0.0.0/24"]
}

 module "azurerm_frontend_subnet" {
   depends_on = [module.azurerm_virtual_netwok]
    source = "../modules/azurerm_subnet" 
    name= "shivfrontsub"
    resource_group_name = "samar"
    virtual_network_name = "sam_vnet"
    address_prefixes =   ["10.0.0.0/25"]
 }

module "azurerm_backend_subnet" {
    source = "../modules/azurerm_subnet" 
    depends_on = [module.azurerm_virtual_netwok] 
    name = "shivbackendsub"
    resource_group_name = "samar"
    virtual_network_name =  "sam_vnet"
    address_prefixes = ["10.0.0.128/25"]
 }

 module "azurerm_virtual_machine" {
    source = "../modules/azurerm_virtual_machine"
    nic_name = "nicfrontend"
    location = "west europe"
    resource_group_name = "samar"
    vm_name = "frontendvm"
    size= "Standard_DS1_v2"
    storage_account_type= "Standard_LRS"
    admin_username= "samarendra1"
    admin_password= "Shivansh@123"
 }

 module "azurerm_virtual_machine1" {
    source = "../modules/azurerm_virtual_machine"
    nic_name = "nicbackend"
    location = "west europe"
    resource_group_name = "samar"
    vm_name = "backendvm"
    size = "Standard_DS1_v2"
    storage_account_type = "Standard_LRS"
    admin_username = "samarendra"
    admin_password = "Shivansh@123"
 }

 module "azurerm_virtual_network" {
    source = "../modules/azurerm_virtual_network"
    name = "sam_vnet"
    location = "west europe"
    resource_group_name= "samar"
    address_space = ["10.0.0.0/24"]
 }
 
module "azurerm_public_front" {
  source = "../modules/arurerm_public_ip"
  pip_name = "front_ip"
  resource_group_name = "samar"
  location = "west europe"

}

module "azurerm_public_back" {
  source = "../modules/arurerm_public_ip"
  pip_name = "back_ip"
  resource_group_name = "samar"
  location = "west europe"

}

module "nic_front" {
   source = "../modules/nic"
   name ="nicfrontend"
   ip_name = "front_ip"
  location ="west europe"
  resource_group_name = "samar"
  pip_name = "front_ip"
  subnet_name = "shivfrontsub"
  virtual_network_name = "sam_vnet"
}

module "nic_back" {
   source = "../modules/nic"
   name ="nicbackend"
   ip_name = "back_ip"
  location ="west europe"
  resource_group_name = "samar"
  pip_name = "back_ip"
  subnet_name = "shivbackendsub"
  virtual_network_name = "sam_vnet"
}