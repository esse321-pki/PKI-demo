import {
  to = azurerm_resource_group.ejbca-ca_group
  id = "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/ejbca-ca_group"
}

# azurerm_linux_virtual_machine.ejbca-ca:
resource "azurerm_linux_virtual_machine" "ejbca-ca" {
    admin_username                                         = "azureuser"
    allow_extension_operations                             = true
    bypass_platform_safety_checks_on_user_schedule_enabled = false
    computer_name                                          = "ejbca-ca"
    encryption_at_host_enabled                             = false
    extensions_time_budget                                 = "PT1H30M"
    location                                               = "westeurope"
    name                                                   = "ejbca-ca"
    network_interface_ids                                  = [
        "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/ejbca-ca_group/providers/Microsoft.Network/networkInterfaces/ejbca-ca537-9ac7b0a6",
    ]
    patch_assessment_mode                                  = "ImageDefault"
    patch_mode                                             = "ImageDefault"

    priority                                               = "Regular"
    zone                                                   = "2"
    admin_ssh_key {
        public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtHrNZMgENF0pgsqEBi4Eob4jrd0P8u53kWCXzY84sE generated-by-azure" 
        username   = "azureuser" 
    }    
    resource_group_name                                    = "ejbca-ca_group"
    size                                                   = "Standard_D2ds_v4"
    identity {
        type         = "SystemAssigned"
    }
    os_disk {
        caching                          = "ReadWrite"
        disk_size_gb                     = 49
        storage_account_type             = "Premium_LRS"
    }

    plan {
        name      = "ejbca_enterprise_8x5"
        product   = "ejbca_enterprise_cloud_edition_private_vhd"
        publisher = "primekey"
    }

    source_image_reference {
        offer     = "ejbca_enterprise_cloud_edition_private_vhd"
        publisher = "primekey"
        sku       = "ejbca_enterprise_8x5"
        version   = "latest"
    }
}
