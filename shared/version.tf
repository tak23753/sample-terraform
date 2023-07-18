terraform {
  required_version = "1.5.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "0.55.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
