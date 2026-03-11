# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/ejbca-ca_group/providers/Microsoft.Network/networkSecurityGroups/ejbca-ca-nsg"
resource "azurerm_network_security_group" "ejbca_nsg" {
  location            = "westeurope"
  name                = "ejbca-ca-nsg"
  resource_group_name = "ejbca-ca_group"
  security_rule = [{
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "SSH"
    priority                                   = 1030
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "443"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "SSL-TLS_Traffic"
    priority                                   = 1020
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "80"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "Public_Web"
    priority                                   = 1010
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }]
  tags = {}
}

# __generated__ by Terraform from "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/ejbca-ca_group/providers/Microsoft.Network/publicIPAddresses/ejbca-ca-ip-9ac7b0a6"
resource "azurerm_public_ip" "ejbca_public_ip" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  ddos_protection_plan_id = null
  domain_name_label       = null
  domain_name_label_scope = null
  edge_zone               = null
  idle_timeout_in_minutes = 15
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "westeurope"
  name                    = "ejbca-ca-ip-9ac7b0a6"
  public_ip_prefix_id     = null
  resource_group_name     = "ejbca-ca_group"
  reverse_fqdn            = null
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags                    = {}
  zones                   = ["2"]
}

# __generated__ by Terraform from "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/ejbca-ca_group/providers/Microsoft.Network/networkInterfaces/ejbca-ca537-9ac7b0a6"
resource "azurerm_network_interface" "nic1" {
  accelerated_networking_enabled = false
  auxiliary_mode                 = null
  auxiliary_sku                  = null
  dns_servers                    = []
  edge_zone                      = null
  internal_dns_name_label        = null
  ip_forwarding_enabled          = false
  location                       = "westeurope"
  name                           = "ejbca-ca537-9ac7b0a6"
  resource_group_name            = "ejbca-ca_group"
  tags = {
    fastpathenabled = "True"
  }
  ip_configuration {
    name                          = "ejbca-ca537-defaultIpConfiguration"
    primary                       = true
    private_ip_address            = "10.0.11.4"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/ejbca-ca_group/providers/Microsoft.Network/publicIPAddresses/ejbca-ca-ip-9ac7b0a6"
    subnet_id                     = "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/rg-my/providers/Microsoft.Network/virtualNetworks/vnet-my/subnets/subnet-main"
  }
}

# __generated__ by Terraform from "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/ejbca-ca_group/providers/Microsoft.Compute/sshPublicKeys/ejbca-ca_key"
resource "azurerm_ssh_public_key" "ejbca_ssh_public_key" {
  location            = "westeurope"
  name                = "ejbca-ca_key"
  public_key          = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtHrNZMgENF0pgsqEBi4Eob4jrd0P8u53kWCXzY84sE generated-by-azure"
  resource_group_name = "ejbca-ca_group"
  tags                = {}
}
