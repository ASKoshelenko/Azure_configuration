resource "azurerm_public_ip" "monitoring_pip" {
  name                = "${var.project_name}-monitoring-pip-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "monitoring_nic" {
  name                = "${var.project_name}-monitoring-nic-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.monitoring_pip.id
  }
}

resource "azurerm_network_security_group" "monitoring_nsg" {
  name                = "${var.project_name}-monitoring-nsg-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowGrafana"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "monitoring_nsg_association" {
  network_interface_id      = azurerm_network_interface.monitoring_nic.id
  network_security_group_id = azurerm_network_security_group.monitoring_nsg.id
}

resource "azurerm_linux_virtual_machine" "monitoring_vm" {
  name                = "${var.project_name}-monitoring-vm-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.monitoring_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
              #!/bin/bash
              set -e

              wait_for_apt() {
                while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
                  echo "Waiting for other apt-get instances to finish..."
                  sleep 1
                done
              }

              wait_for_apt

              sudo apt-get update
              sudo apt-get install -y apt-transport-https software-properties-common wget
              sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
              echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
              sudo apt-get update
              sudo apt-get install -y grafana
              sudo systemctl enable grafana-server
              sudo systemctl start grafana-server
            EOF
  )
}