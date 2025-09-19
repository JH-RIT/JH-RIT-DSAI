**JH-RIT-DSAI Infrastructure**

Terraform configuration for OpenAI, Azure ML, and storage infrastructure with private networking.

**Architecture**

JH-RIT-DSAI-PROD-RG - Additional storage
JH-RIT-DSAI-OAI-RG - OpenAI services
JH-RIT-DSAI-AML-RG - Azure ML workspace

**Resources**
OpenAI Cognitive Services with private endpoint
Azure ML Workspace (Key Vault, Storage, App Insights)

**Additional Storage Account**
Private endpoints for secure networking
Prerequisites
Terraform >= 1.3
Azure CLI authentication
Pre-created resource groups, VNet/subnet, and Azure AD group (JH-RIT-DSAI)
