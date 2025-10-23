# Subscription and Resource Groups
subscription_id         = "9c5d40b3-75aa-4bdf-b1aa-3f22cd0661c8"
resource_group_name     = "JH-RIT-DSAI-PROD-RG"      # Main RG for Additional Storage
aml_resource_group_name = "JH-RIT-DSAI-AML-RG"       # AML resources
oai_resource_group_name = "JH-RIT-DSAI-OAI-RG"       # OpenAI resources
oai_resource_group_name_east2 = "JH-RIT-DSAI-OAI-EAST2-RG" #OpenAI resources (East US 2)
aif_resource_group_name = "JH-RIT-DSAI-AIF-RG"       # AI Foundry resources (East US)
aif_resource_group_name_east2 = "JH-RIT-DSAI-AIF-EAST2-RG"  # AI Foundry resources (East US 2)
location               = "eastus"

# OpenAI Configuration
ritjira = "2820"
project = "dsai"

# AML Configuration  
jira_ticket      = "2820"
application_name = "dsaiaml"  
environment      = "prod"

# Additional Storage Configuration
additional_storage_hns         = false  # Set to true if using for Databricks
additional_storage_access_tier = "Hot"  # or "Cold" for archive storage

# Resource Creation Flags
create_new_workspace            = true
create_new_application_insights = true
create_new_storage_account      = true
create_new_key_vault           = true
create_private_endpoint        = true

# Existing Resources (set to null since creating new)
existing_application_insights_name = null
existing_storage_account_name      = null
existing_key_vault_name           = null

# Network Configuration - East US
vnet_name                    = "AZ-East-JH-RIT-DSAI-JHU-Academic-DC-10.209.250.0-24"
subnet_name                  = "10.209.250.0-25"

# Network Configuration - East US 2
vnet_name_east2              = "AZ-EAST2-JH-RIT-DSAI-JHU-Academic-DC-10.209.89.0-24"
subnet_name_east2            = "10.209.89.0-25"

network_resource_group_name  = "INFRASTRUCTURE-SVI-USE-ONLY-RG"

# AD Group
user_AD_group_name = "JH-RIT-DSAI"

# Tags
tags = {
  "Owner"            = "nandrew9"
  "Environment"      = "Prod"
  "Project"          = "JH-RIT-DSAI"
  "IRB"              = "N/A"
  "Data Sensitivity" = "No PHI"
  "PI"               = "nandrew9"
  "JIRA"             = "RIT-2820"
}