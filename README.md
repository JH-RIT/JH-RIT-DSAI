# JH-RIT-DSAI Infrastructure

# Terraform configuration for deploying OpenAI, Azure ML, and storage infrastructure with private networking.

# 

# Architecture

# Resource Groups

# JH-RIT-DSAI-PROD-RG - Additional storage

# JH-RIT-DSAI-OAI-RG - OpenAI services

# JH-RIT-DSAI-AML-RG - Azure ML workspace

# Resources

# OpenAI Cognitive Services with private endpoint

# Azure ML Workspace with Key Vault, Storage, and App Insights

# Additional Storage Account for data operations

# Private endpoints for secure networking

# Prerequisites

# Terraform >= 1.3

# Azure CLI authentication

# Pre-created resource groups and VNet/subnet

# Azure AD group: JH-RIT-DSAI

# Deployment

# bash

# Copy code

# \# Initialize

# terraform init -upgrade

# 

# \# Plan

# terraform plan -var-file="terraform.tfvars"

# 

# \# Deploy

# terraform apply -var-file="terraform.tfvars"

# Configuration

# Key values in terraform.tfvars:

# 

# hcl

# Copy code

# subscription\_id = "9c5d40b3-75aa-4bdf-b1aa-3f22cd0661c8"

# ritjira = "2820"

# project = "dsai" 

# application\_name = "dsaiaml"

# State Management

# Remote state stored in ritterraform storage account, container tfstate, file RIT-2820-DSAI.tfstate.

# 

# Files

# main.tf - Infrastructure configuration

# variables.tf - Variable definitions

# terraform.tfvars - Configuration values

# outputs.tf - Resource outputs

# Project: JH-RIT-DSAI | JIRA: RIT-2820 | Version: v0.063

