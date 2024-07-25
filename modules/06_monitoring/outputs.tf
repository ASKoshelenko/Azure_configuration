output "monitoring_vm_private_ip" {
  value       = azurerm_network_interface.monitoring_nic.private_ip_address
  description = "The private IP address of the monitoring VM"
}

output "monitoring_vm_id" {
  value       = azurerm_linux_virtual_machine.monitoring_vm.id
  description = "The ID of the monitoring VM"
}