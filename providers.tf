terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9f0d713a-62a6-4563-a169-9da23ac9c5cf"
}

provider "aws" {
  region = "us-west-2"
  # Additional AWS provider configuration can be placed here
}

provider "google" {
  project = "your-project-id"
  region  = "europe-west1"
  # Additional Google Cloud provider configuration can be placed here
}
