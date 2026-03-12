#main rg
resource "azurerm_resource_group" "my" {
  name     = "rg-my"
  location = "West Europe"
}



resource "azurerm_virtual_network" "my" {
  name                = "vnet-my"
  location            = azurerm_resource_group.my.location
  resource_group_name = azurerm_resource_group.my.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "Poc"
  }
}

resource "azurerm_subnet" "main" {
  name                 = "subnet-main"
  resource_group_name  = azurerm_resource_group.my.name
  virtual_network_name = azurerm_virtual_network.my.name
  address_prefixes     = ["10.0.11.0/27"]
}

data "azurerm_client_config" "current" {
}
data "azurerm_subscription" "subscription" {
}
resource "azurerm_key_vault" "my" {
  name                            = "my-kv-90345689023"
  resource_group_name             = azurerm_resource_group.my.name
  location                        = azurerm_resource_group.my.location
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  rbac_authorization_enabled      = true
  soft_delete_retention_days      = 90
  purge_protection_enabled        = false
  sku_name                        = "standard"
  public_network_access_enabled   = true
}


# resource "azurerm_role_assignment" "af_vault_certificates_officer" {
#   scope                            = data.azurerm_subscription.subscription.id
#   role_definition_name             = "Key Vault Certificates Officer"
#   principal_id                     = azurerm_function_app_flex_consumption.my.identity[0].principal_id
#   skip_service_principal_aad_check = true
# }

resource "azurerm_private_dns_zone" "my" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.my.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "plink-my"
  resource_group_name   = azurerm_resource_group.my.name
  private_dns_zone_name = azurerm_private_dns_zone.my.name
  virtual_network_id    = azurerm_virtual_network.my.id
}

# resource "azurerm_private_dns_a_record" "main" {
#   name    = format("%s%s",azurerm_key_vault.my.name,".vault.azure.net")
#   ttl     = 10
#   records = [azurerm_private_endpoint.my.private_service_connection[0].private_ip_address]

#   zone_name           = azurerm_private_dns_zone.my.name
#   resource_group_name = azurerm_resource_group.my.name
# }


resource "azurerm_private_dns_zone" "test" {
  name                = "erik.local"
  resource_group_name = azurerm_resource_group.my.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "test" {
  name                  = "plink-my"
  resource_group_name   = azurerm_resource_group.my.name
  private_dns_zone_name = azurerm_private_dns_zone.test.name
  virtual_network_id    = azurerm_virtual_network.my.id
}

resource "azurerm_private_dns_a_record" "test" {
  name    = "test.erik.local"
  ttl     = 10
  records = ["10.0.10.10"]

  zone_name           = azurerm_private_dns_zone.test.name
  resource_group_name = azurerm_resource_group.my.name
}

#keyvault roles for ejbca appliances
resource "azurerm_role_assignment" "ejbca_key_vault_crypto_officer" {
  scope                            = data.azurerm_subscription.subscription.id
  role_definition_name             = "Key Vault Crypto Officer"
  principal_id                     = azurerm_linux_virtual_machine.ejbca-ca.identity[0].principal_id
  skip_service_principal_aad_check = true
}


resource "azurerm_role_assignment" "acme_private_zone_assignment" {
  scope                 = data.azurerm_subscription.subscription.id
  role_definition_name  = "Private DNS Zone Contributor"
  principal_id          = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "key_vault_certificates_officer" {
  scope                 = data.azurerm_subscription.subscription.id
  role_definition_name  = "Key Vault Certificates Officer"
  principal_id          = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

