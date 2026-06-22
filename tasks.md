# Tasks
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Tracks implementation tasks against architecture requirements.

| Task ID | Task title | Requirement source | Description | Acceptance criteria | Dependencies | Test coverage required | Status |
|---|---|---|---|---|---|---|---|
| T-001 | Add SQL staging storage account | Architecture sections 2, 5, 6 | Create a private SQL staging storage account for test data. | Terraform declares a SQL staging storage account using RIT-4525 naming inputs. | None. | Terraform format, validate, and plan review. | Completed |
| T-002 | Add SQL production storage account | Architecture sections 2, 5, 6, 8 | Create a private SQL production storage account for production data. | Terraform declares a SQL production storage account using RIT-4525 naming inputs. | None. | Terraform format, validate, and plan review. | Completed |
| T-003 | Add lifecycle deletion policies | Architecture sections 2, 6, 11 | Delete blobs from both SQL storage accounts after the configured retention period. | Terraform declares lifecycle rules for SQL staging and SQL production storage accounts using `blob_retention_days`, default 7. | T-001, T-002. | Terraform format, validate, and plan review. | Completed |
| T-004 | Document external RBAC boundary | Architecture sections 8, 14, 15 | Document that RBAC is managed outside this project. | `architecture.md` clearly states RBAC is out of scope and must be handled externally. | None. | Documentation review. | Completed |