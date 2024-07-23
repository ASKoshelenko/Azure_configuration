# Azure Infrastructure Project

This project sets up an Azure infrastructure using Terraform, including a virtual network, a Linux VM with Nginx, and a MySQL Flexible Server.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 0.14.x)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- An active Azure subscription

## Project Structure
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vm/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── database/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── terraform.tfvars
├── README.md
└── .gitignore


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

- **Network**: Sets up the virtual network, subnet, and network security group.
- **VM**: Creates a Linux VM with Nginx installed.
- **Database**: Provisions a MySQL Flexible Server and a database.

## Customization

To customize the deployment, modify the `terraform.tfvars` file or the individual module files as needed.

## Security Note

Ensure that sensitive information like passwords are not committed to version control. Use environment variables or secure secret management solutions for production deployments.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
