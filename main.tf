terraform {
required_version = ">=0.15.0"
required_providers {
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = "0.3.0"
    }
  }
}