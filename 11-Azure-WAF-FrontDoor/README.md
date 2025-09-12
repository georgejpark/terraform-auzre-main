# Azure Front Door with WAF and Monitoring

This example provisions an Azure Front Door instance with Web Application Firewall rules,
a DDoS Protection plan and Azure Monitor.

## Usage

1. Adjust the variables in `terraform.tfvars` or supply them on the command line.
2. Initialize and apply the configuration.

```bash
cd terraform-manifests
terraform init
terraform apply
```

## Files

- `c1-versions.tf` - Terraform and provider versions
- `c2-variables.tf` - Common input variables
- `c3-main.tf` - Resources for Front Door, WAF, DDoS and Monitor
- `c4-outputs.tf` - Sample outputs
