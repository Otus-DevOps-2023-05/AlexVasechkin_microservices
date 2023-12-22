variable "service_account_key_file" {
  description = "Service account key file"
}

variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "subnet_id" {
  description = "Subnet"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}

variable "app_image_id" {
  description = "App image id"
}
