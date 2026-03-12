# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "azurerm_linux_virtual_machine" "vm" {
  admin_password                                         = null # sensitive
  admin_username                                         = "azureuser"
  allow_extension_operations                             = true
  availability_set_id                                    = null
  bypass_platform_safety_checks_on_user_schedule_enabled = false
  capacity_reservation_group_id                          = null
  computer_name                                          = "vm"
  custom_data                                            = null # sensitive
  dedicated_host_group_id                                = null
  dedicated_host_id                                      = null
  disable_password_authentication                        = true
  disk_controller_type                                   = "NVMe"
  edge_zone                                              = null
  encryption_at_host_enabled                             = false
  eviction_policy                                        = null
  extensions_time_budget                                 = "PT1H30M"
  license_type                                           = null
  location                                               = "westeurope"
  max_bid_price                                          = -1
  name                                                   = "vm"
  network_interface_ids                                  = ["/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/rg-my/providers/Microsoft.Network/networkInterfaces/vm472"]
  os_managed_disk_id                                     = "/subscriptions/96098664-4ddf-4492-adc7-1f5b5e08ed51/resourceGroups/RG-MY/providers/Microsoft.Compute/disks/vm_OsDisk_1_8363f43708354ea4bd777cc0cc885cca"
  patch_assessment_mode                                  = "ImageDefault"
  patch_mode                                             = "ImageDefault"
  platform_fault_domain                                  = -1
  priority                                               = "Regular"
  provision_vm_agent                                     = true
  proximity_placement_group_id                           = null
  reboot_setting                                         = null
  resource_group_name                                    = "rg-my"
  secure_boot_enabled                                    = true
  size                                                   = "Standard_D2alds_v7"
  source_image_id                                        = null
  tags                                                   = {}
  user_data                                              = null
  virtual_machine_scale_set_id                           = null
  vtpm_enabled                                           = true
  zone                                                   = "1"
  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }
  admin_ssh_key {
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK1MUkjTrfefk2026qmOX25KXQVvN5IzYFKICFmsItJ/ erik@SandboxHost-639088058120638174"
    username   = "azureuser"
  }
  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
  os_disk {
    caching                          = "ReadWrite"
    disk_encryption_set_id           = null
    disk_size_gb                     = 30
    name                             = "vm_OsDisk_1_8363f43708354ea4bd777cc0cc885cca"
    secure_vm_disk_encryption_set_id = null
    security_encryption_type         = null
    storage_account_type             = "Premium_LRS"
    write_accelerator_enabled        = false
  }
  source_image_reference {
    offer     = "ubuntu-24_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }
}
