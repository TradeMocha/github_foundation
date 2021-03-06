# Provider for GitHub resources
provider "github" {
  token        = var.github_token
  organization = var.github_organization
}

# Terraform cloud integration. Note the resources must already exist below for this to work.
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "TradeMocha"

    workspaces {
      name = "github_foundation"
    }
  }
}