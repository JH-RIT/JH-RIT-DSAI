# Architecture
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Documents infrastructure architecture, constraints, and guardrails.

## 1. Project Purpose

This Terraform project deploys Azure infrastructure for JH-RIT-DSAI, including Azure OpenAI, Azure AI Foundry, Azure Machine Learning, supporting private networking, and storage resources.

## 2. Functional Requirements

- Deploy Azure OpenAI resources in East US and East US 2.
- Deploy Azure AI Foundry resources in East US and East US 2.
- Deploy Azure Machine Learning dependencies and workspace resources.
- Deploy two additional secure storage accounts in `JH-RIT-DSAI-App-RG` for SQL slot data stores.
- Provide a SQL staging blob storage account for test data that authorized users can see and edit through externally managed RBAC.
- Provide a SQL production blob storage account that users cannot see or edit, while a user-assigned identity can access through externally managed RBAC.
- Use RIT-4525 naming inputs for the SQL production and SQL staging storage accounts.
- Automatically delete blobs from the SQL staging and SQL production storage accounts after the configured retention period, initially 7 days.

## 3. Non-Functional Requirements

- Use private networking where supported by the referenced Terraform modules.
- Keep blob data retention short to satisfy data minimization expectations.
- Prefer simple Terraform resources and existing JH-RIT modules over custom modules where practical.
- Keep configuration values parameterized through Terraform variables.
- Avoid storing secrets or credentials in source files.

## 4. Tech Stack

- Terraform >= 1.3.
- AzureRM Terraform provider >= 3.0.
- JH-RIT Terraform modules from `git@github.com:JH-RIT/RIT-Azure.git`.
- Azure OpenAI, Azure AI Foundry, Azure Machine Learning, Azure Storage, Azure Key Vault, Application Insights, Private Endpoints.

## 5. Architecture Overview

The project is split into Terraform files by resource area. `main.tf` resolves shared data sources such as VNets, subnets, and client configuration. Azure service modules deploy OpenAI, AI Foundry, AML, Key Vault, storage, and Application Insights resources. `storage.tf` provisions the existing production storage module plus separate SQL production and SQL staging storage accounts for slot-scoped blob data stores.

## 6. Data Flow

- Application or workflow data is written to the SQL slot-specific storage accounts.
- Test data flows to the SQL staging storage account.
- Production slot data flows to the SQL production storage account.
- Blob lifecycle management deletes blobs after `blob_retention_days` days since creation.
- The system assumes canonical copies are retained in the database, so blob stores are temporary operational stores.

## 7. API and Interface Contracts

- Infrastructure inputs are Terraform variables in `variables.tf` and values in `terraform.tfvars`.
- Infrastructure outputs are declared in `outputs.tf`.
- SQL data store resource group is controlled by `app_resource_group_name` and currently resolves to `JH-RIT-DSAI-App-RG`.
- SQL data store account naming is controlled by `data_store_jira`, `sqlprod_storage_project`, and `sqlstage_storage_project`; current names resolve to `rit4525dsaisqlprod` and `rit4525dsaisqlstage`.
- Retention is controlled by `blob_retention_days`.
- SQL data store tags inherit project tags and override `JIRA` with `RIT-4525`.

## 8. Security Considerations

- SQL production and SQL staging storage accounts disable public network access and use blob private endpoints.
- RBAC is intentionally managed outside this Terraform project.
- External RBAC must grant appropriate data-plane access to the SQL staging storage account for authorized users.
- External RBAC must grant SQL production storage account data-plane access only to the required user-assigned managed identity.
- Do not grant broad user access to the SQL production storage account through this project.
- Do not commit secrets, storage keys, connection strings, or managed identity credentials.

## 9. Error Handling Strategy

Terraform failures should be handled by reviewing provider diagnostics, correcting configuration, and rerunning `terraform plan` before `terraform apply`. Storage lifecycle deletion is asynchronous and should be validated after deployment through Azure Storage lifecycle policy inspection.

## 10. Logging and Observability Strategy

Azure platform diagnostics and resource activity logs provide deployment and operational visibility. This repository does not configure application-level logging. Logs must not include secrets, storage keys, or sensitive data values.

## 11. Testing Strategy

- Run `terraform fmt -check` to verify formatting.
- Run `terraform validate` after provider/module initialization.
- Run `terraform plan -var-file="terraform.tfvars"` before deployment.
- Review the plan to confirm only expected SQL production/staging storage accounts and lifecycle policy changes are introduced.
- Confirm external RBAC assignments outside this project before production use.

## 12. Coding Guardrails

- Keep Terraform files focused by resource area.
- Use variables for configurable values.
- Do not add inline secrets or credentials.
- Do not manage RBAC assignments in this project unless the architecture is explicitly changed.
- Keep data retention short and documented.

## 13. Project Structure

- `providers.tf`: Terraform backend and provider configuration.
- `main.tf`: Shared Azure data sources.
- `storage.tf`: existing production storage module, SQL production/staging storage accounts, and lifecycle policies.
- `aml.tf`: Azure Machine Learning and related dependencies.
- `ai-foundry-east1.tf`, `ai-foundry-east2.tf`: AI Foundry modules.
- `openai.tf`, `openai-east2.tf`: Azure OpenAI modules.
- `variables.tf`: Terraform input variable declarations.
- `terraform.tfvars`: Environment-specific variable values.
- `outputs.tf`: Terraform outputs.
- `architecture.md`, `tasks.md`, `tests.md`: Living planning and validation documents.

## 14. Deployment and Runtime Assumptions

- Resource groups, VNets, and subnets referenced in `terraform.tfvars` already exist, including `JH-RIT-DSAI-App-RG` for SQL data stores.
- Terraform state is stored in the configured Azure Storage backend.
- The deploying identity has permissions to create and update the declared Azure resources.
- External RBAC administrators will configure blob data-plane permissions after deployment.
- The database contains the retained source copy for data that is temporarily staged in blob storage.

## 15. Known Constraints and Tradeoffs

- RBAC is deliberately out of scope for this project, which reduces Terraform blast radius but requires a separate operational step.
- SQL storage account names are explicit Azure Storage account names derived from RIT-4525 and the `dsaisqlprod`/`dsaisqlstage` project segments.
- Lifecycle deletion does not delete blobs immediately at the exact retention boundary; Azure applies lifecycle policies asynchronously after the configured number of days since blob creation.