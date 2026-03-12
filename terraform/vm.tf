
resource "azurerm_linux_virtual_machine" "vm" {
  admin_username                                         = "azureuser"
  allow_extension_operations                             = true
  bypass_platform_safety_checks_on_user_schedule_enabled = false
  computer_name                                          = "vm"
  disable_password_authentication                        = true
  disk_controller_type                                   = "NVMe"
  encryption_at_host_enabled                             = false
  location                                               = "westeurope"
  name                                                   = "vm"
  resource_group_name                                    = "rg-my"
  secure_boot_enabled                                    = true
  size                                                   = "Standard_D2alds_v7"
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
    type         = "SystemAssigned"
  }
  os_disk {
    caching                          = "ReadWrite"
    disk_size_gb                     = 30
    write_accelerator_enabled        = false
  }
  source_image_reference {
    offer     = "ubuntu-24_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }
}
