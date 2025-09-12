output "frontdoor_id" {
  description = "ID of the Front Door"
  value       = azurerm_frontdoor.fd.id
}

output "ddos_plan_id" {
  description = "ID of the DDoS protection plan"
  value       = azurerm_network_ddos_protection_plan.ddos.id
}
