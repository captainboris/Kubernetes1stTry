provider "aws" {
  region = "ap-southeast-2"
  # version = "= 5.41.0"
}


provider "kubernetes" {
  config_path = "~/.kube/config"
}