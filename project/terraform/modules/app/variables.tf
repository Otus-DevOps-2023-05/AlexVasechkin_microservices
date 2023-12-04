variable "env" {
  description = "Environment"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable "image_id" {
  description = "Image id for service app"
}
variable "subnet_id" {
  description = "Subnets for modules"
}
