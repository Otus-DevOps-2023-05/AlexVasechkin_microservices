terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source           = "../modules/app"
  env              = "prod"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  image_id         = var.app_image_id
  subnet_id        = var.subnet_id
}
