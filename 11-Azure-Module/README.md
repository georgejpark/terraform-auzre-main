# Azure Terraform Module

This module provisions a basic Azure Resource Group. Three subdirectories (`dev`, `stage`, `prod`) contain environment specific configuration files.

## Folder Structure

```
11-Azure-Module/
├── dev
├── stage
├── prod
├── main.tf
├── variables.tf
└── outputs.tf
```

Each environment folder includes a `backend.tf` used for remote state and a `terraform.tfvars` file that sets environment values such as resource names, VM sizes and monitoring options.

## Deploying an Environment

1. Change into the desired environment directory.
2. Run the Terraform workflow (`init`, `plan`, and `apply`).

Example for the **dev** environment:

```bash
cd 11-Azure-Module/dev
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Repeat the same steps from the `stage` or `prod` directories to deploy those environments.
