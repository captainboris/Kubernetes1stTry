terraform {
    required_version = ">= 1.2.4"
    required_providers {
      aws = {
        source = "hashicrop/aws"
        version = ">= 4.24.0"
      }
    }
}