resource "azurerm_network_interface" "client_nginx_nic" {
  name                = "nic-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }
}

resource "azurerm_linux_virtual_machine" "client_nginx_vm" {
  name                = "vm-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.client_nginx_nic.id,
  ]

  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_keys
    content {
      username   = var.admin_username
      public_key = admin_ssh_key.value
    }
  }

  os_disk {
    name                 = "osdisk-${var.project_name}-${var.environment}"
    caching              = var.os_disk_config.caching
    storage_account_type = var.os_disk_config.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  custom_data = base64encode(file("${path.module}/init_script.sh"))

  identity {
    type = "SystemAssigned"
  }
}