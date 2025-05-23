# Terraform AWS Modules

This repository contains a collection of example Terraform modules demonstrating how to deploy AWS infrastructure. Each module lives in a directory numbered `01-` through `10-` and focuses on a particular topic or resource type.

## Module overview

- **01-Infrastructure-as-Code-IaC-Basics** – Introduction to Infrastructure as Code concepts.
- **02-Terraform-Basics** – Installing the CLI and learning Terraform language syntax.
- **03-Terraform-Settings-Providers-Resources** – Using providers and resource blocks to create simple EC2 instances.
- **04-Terraform-Variables-and-Datasources** – Working with input variables, data sources and output values.
- **05-Terraform-Loops-MetaArguments-SplatOperator** – Examples for the `count` and `for_each` meta-arguments and looping techniques.
- **06-AWS-VPC** – Building a custom VPC using reusable Terraform modules.
- **07-AWS-EC2Instance-and-SecurityGroups** – Provisioning EC2 instances and related security groups.
- **08-AWS-ELB-Classic-LoadBalancer** – Deploying a classic load balancer in front of your instances.
- **09-AWS-ALB-Application-LoadBalancer-Basic** – Basic setup of an Application Load Balancer.
- **10-ALB-Path-Based-Routing** – Path based routing rules for an Application Load Balancer.

Azure specific configurations are not yet implemented; all current examples target AWS resources.

## Getting started

Clone the repository and change into the project directory:

```bash
git clone <REPO_URL>
cd terraform-auzre-main
```

Each module contains its Terraform configuration in a `terraform-manifests` directory (some introductory folders only contain documentation). To run a module, navigate to that directory and execute Terraform commands:

```bash
cd <MODULE_DIRECTORY>/terraform-manifests
terraform init
terraform plan
terraform apply
```

Make sure your AWS credentials are configured before running the examples. Repeat these steps for any other module directory you wish to experiment with.
