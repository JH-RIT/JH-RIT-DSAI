# Tests
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Documents validation coverage for infrastructure changes.

| Test ID | Related task ID | Requirement source | Test type | Scenario | Expected result | Edge cases covered | Failure modes covered | Automation status |
|---|---|---|---|---|---|---|---|---|
| TEST-001 | T-001 | Architecture sections 2, 6 | Static validation | Run Terraform formatting and validation for the SQL staging storage account declaration. | Configuration is formatted and valid. | Storage account naming inputs. | Invalid Terraform syntax or invalid naming inputs. | Manual |
| TEST-002 | T-002 | Architecture sections 2, 6, 8 | Static validation | Run Terraform formatting and validation for the SQL production storage account declaration. | Configuration is formatted and valid. | Storage account naming inputs. | Invalid Terraform syntax or invalid naming inputs. | Manual |
| TEST-003 | T-003 | Architecture sections 2, 6, 11 | Plan review | Run Terraform plan and inspect lifecycle management policies. | Plan includes enabled deletion rules for both SQL storage accounts using 7-day default retention since blob creation. | Retention range validation. | Missing lifecycle rule or incorrect retention value. | Manual |
| TEST-004 | T-004 | Architecture sections 8, 14, 15 | Documentation review | Review planning docs for RBAC scope. | Documentation states RBAC is managed outside this project. | Separation of infrastructure and access management. | Accidental RBAC resources in Terraform. | Manual |