# Azure Infrastructure Project for IT Marathon

This project sets up an Azure infrastructure using Terraform, including a virtual network, Linux VMs with Nginx, a MySQL Flexible Server, storage account, and an App Service.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 0.14.x)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- An active Azure subscription

## Project Structure
```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── 01_network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── 02_security/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── 03_vm/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── init_script.sh
│   ├── 04_database/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── 05_storage/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── 06_monitoring/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── init_script.sh
│   └── 07_app_service/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── terraform.tfvars
├── README.md
└── .gitignore
```

## Configuration

1. Clone this repository.
2. Navigate to the project directory.
3. Create a `terraform.tfvars` file and set the required variables (see `variables.tf` for reference).
4. Ensure you have an SSH key for VM access.

### terraform.tfvars example
```hcl
location                        = "North Europe"
project_name                    = "projectName"
environment                     = "test"
vnet_address_space              = ["10.0.0.0/16"]
services_subnet_address_prefix  = "10.0.1.0/24"
mysql_subnet_address_prefix     = "10.0.3.0/24"
allowed_ip_ranges = [
  "86.57.255.94/32",    # vpn-by.epam.com
  "213.184.231.20/32",  # vpn-by-minsk.epam.com
  "202.65.196.242/32",  # vpn-cn.epam.com
  "195.56.119.209/32",  # vpn-eu.epam.com
  "195.56.119.212/32",  # vpn-eu.epam.com
  "204.153.55.4/32",    # vpn-eu2.epam.com
  "203.170.48.2/32",    # vpn-in.epam.com
  "85.223.209.18/32",   # vpn-ua.epam.com
  "174.128.60.160/32",  # vpn-us.epam.com
  "174.128.60.162/32"   # vpn-us.epam.com
]

route_table_name = "main-route-table"
routes = [
  {
    name                   = "route-to-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name                   = "route-to-datacenter"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.1.4"
  }
]

vm_config = {
  size           = "Standard_B1s"
  admin_username = "azureuser"
}

admin_ssh_keys = [
  "ssh-rsa AAAAB...",

]

mysql_config = {
  admin_username = "mysqladmin"
  admin_password = "SecurePassword123!"
  sku_name       = "B_Standard_B1s"
  version        = "8.0.21"
}

storage_config = {
  account_tier             = "Standard"
  account_replication_type = "LRS"
  container_name           = "itmarathoncontainer"
}

enable_app_service_vnet_integration = false
```

## Usage

### Running the entire project

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Review the planned changes:
   ```
   terraform plan
   ```

3. Apply the changes:
   ```
   terraform apply
   ```

4. When you're done, destroy the resources:
   ```
   terraform destroy
   ```

### Running individual modules

To run individual modules, you can use the `-target` option with Terraform commands. Here are examples for each module:

1. Network Module:
   ```
   terraform apply -target=module.network
   ```

2. Security Module:
   ```
   terraform apply -target=module.security
   ```

3. VM Module:
   ```
   terraform apply -target=module.vm
   ```

4. Database Module:
   ```
   terraform apply -target=module.database
   ```

5. Storage Module:
   ```
   terraform apply -target=module.storage
   ```

6. Monitoring Module:
   ```
   terraform apply -target=module.monitoring
   ```

7. App Service Module:
   ```
   terraform apply -target=module.app_service
   ```

Note: When running individual modules, ensure that their dependencies (like the network module) have been applied first.

## Modules

- **Network**: Sets up the virtual network, subnets, route tables, and resource group.
- **Security**: Configures network security groups with rules for HTTP, HTTPS, SSH, and Grafana.
- **VM**: Deploys a Linux VM with Nginx installed and MySQL client configured with SSL.
- **Database**: Provisions a MySQL Flexible Server and a database with SSL enforcement.
- **Storage**: Sets up an Azure Storage account with a container.
- **Monitoring**: Deploys a separate VM for monitoring purposes, with Grafana installed.
- **App Service**: Deploys an Azure App Service for hosting web applications.

## Security Features

- SSL enforcement for MySQL connections
- Network security groups to control inbound and outbound traffic
- Separate subnets for different resources (services, database)
- Automatic configuration of MySQL client with SSL on VMs
- Private DNS zones for secure database access

## Customization

To customize the deployment, modify the `terraform.tfvars` file or the individual module files as needed.

## Security Note

- Access to resources is restricted to specified IP ranges.
- Ensure that sensitive information like passwords are not committed to version control. Use environment variables or secure secret management solutions for production deployments.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)