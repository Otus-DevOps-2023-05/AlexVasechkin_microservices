terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.12.19"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "otus-kuber-master-1" {
  name = "kuber-master-1"

  labels = {
    tags = "kuber-master-1"
  }

  platform_id = "standard-v3"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.otus-kuber-master-1.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "files/install_docker.sh"
  }

  provisioner "remote-exec" {
    script = "files/install_k8s.sh"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "yandex_compute_instance" "otus-kuber-worker-1" {
  name = "kuber-worker-1"

  labels = {
    tags = "kuber-worker-1"
  }

  platform_id = "standard-v3"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.otus-kuber-worker-1.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "files/install_docker.sh"
  }

  provisioner "remote-exec" {
    script = "files/install_k8s.sh"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
