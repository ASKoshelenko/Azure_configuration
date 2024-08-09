output "vm_private_ip" {
  value = azurerm_network_interface.client_nginx_nic.private_ip_address
}