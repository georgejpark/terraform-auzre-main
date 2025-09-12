# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# DDoS Protection Plan
resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = "${var.prefix}-ddos"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.prefix}-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Data Collection Rule
resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "${var.prefix}-dcr"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  destinations {
    log_analytics {
      name                  = "logAnalytics"
      workspace_resource_id = azurerm_log_analytics_workspace.law.id
    }
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["logAnalytics"]
  }
}

# Associate the Azure Monitor Agent with a VM or App Service when an ID is supplied
resource "azurerm_monitor_data_collection_rule_association" "monitor_assoc" {
  count                   = var.vm_or_appservice_id == "" ? 0 : 1
  name                    = "${var.prefix}-assoc"
  target_resource_id      = var.vm_or_appservice_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
}

# Front Door
resource "azurerm_frontdoor" "fd" {
  name                = "${var.prefix}-fd"
  resource_group_name = azurerm_resource_group.rg.name

  routing_rule {
    name               = "rule1"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontend"]
    forwarding_configuration {
      forwarding_protocol = "HttpsOnly"
      backend_pool_name   = "backendpool"
    }
  }

  backend_pool_load_balancing {
    name = "loadbalance"
  }

  backend_pool_health_probe {
    name                = "probe"
    protocol            = "Https"
    path                = "/"
    interval_in_seconds = 30
  }

  backend_pool {
    name = "backendpool"
    backend {
      host_header = "example.com"
      address     = "example.com"
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name = "loadbalance"
    health_probe_name   = "probe"
  }

  frontend_endpoint {
    name      = "frontend"
    host_name = "${var.prefix}.azurefd.net"
  }
}

# WAF Policy
resource "azurerm_frontdoor_firewall_policy" "waf" {
  name                = "${var.prefix}-waf"
  resource_group_name = azurerm_resource_group.rg.name

  custom_rule {
    name      = "BlockBadIps"
    priority  = 1
    rule_type = "MatchRule"
    action    = "Block"
    match_condition {
      match_variable = "RemoteAddr"
      operator       = "IPMatch"
      match_values   = ["192.0.2.0/24"]
    }
  }
}

# Associate WAF Policy with Front Door
resource "azurerm_frontdoor_firewall_policy_association" "waf_assoc" {
  frontdoor_id      = azurerm_frontdoor.fd.id
  firewall_policy_id = azurerm_frontdoor_firewall_policy.waf.id
}
