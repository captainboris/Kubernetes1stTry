provider "aws"{
    region = "ap-southeast-2"
}


provider "kubernetes" {
  config_path = "~/.kube/config"
}