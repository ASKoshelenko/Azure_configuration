# Azure Infrastructure Project

This project sets up an Azure infrastructure using Terraform, including a virtual network, a Linux VM with Nginx, a MySQL Flexible Server, and an App Service.

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
│   ├── 02_security/
│   ├── 03_vm/
│   ├── 04_database/
│   ├── 05_storage/
│   ├── 06_monitoring/
│   └── 07_app_service/
├── terraform.tfvars
├── README.md
└── .gitignore
```

## Configuration

1. Clone this repository.
2. Navigate to the project directory.
3. Create a `terraform.tfvars` file and set the required variables (see `variables.tf` for reference).
4. Ensure you have an SSH key at `~/.ssh/id_rsa.pub` or modify the VM module to use a different key.

## Usage

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

## Modules

- **Network**: Sets up the virtual network, subnets, and route tables.
- **Security**: Configures network security groups with rules for HTTP, HTTPS, SSH, and Grafana.
- **VM**: Deploys a Linux VM with Nginx installed.
- **Database**: Provisions a MySQL Flexible Server and a database.
- **Storage**: Sets up an Azure Storage account with a container.
- **Monitoring**: Deploys a separate VM for monitoring purposes, with Grafana installed.
- **App Service**: Deploys an Azure App Service for hosting web applications.

## Security Note

- Access to resources is restricted to the IP range specified in the `allowed_ip_range` variable.
- Ensure that sensitive information like passwords are not committed to version control. Use environment variables or secure secret management solutions for production deployments.

## Customization

To customize the deployment, modify the `terraform.tfvars` file or the individual module files as needed.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)