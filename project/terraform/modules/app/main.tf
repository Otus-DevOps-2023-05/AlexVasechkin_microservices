terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_compute_instance" "app" {
  name = "${var.env}-app"

  labels = {
    tags = "${var.env}-app"
  }

  platform_id = "standard-v3"

  resources {
    cores         = 2
    core_fraction = 50
    memory        = 4
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
    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  provisioner "remote-exec" {
    script = "../files/init.sh"
  }
}
