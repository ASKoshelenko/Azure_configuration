output "monitoring_vm_private_ip" {
  value = azurerm_network_interface.monitoring_nic.private_ip_address
}

output "monitoring_vm_id" {
  value       = azurerm_linux_virtual_machine.monitoring_vm.id
  description = "The ID of the monitoring VM"
}