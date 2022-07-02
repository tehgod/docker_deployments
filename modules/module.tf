terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "my_docker_image" {
  name = "${var.resource_location}"
  force_remove = var.force_remove
}

resource "docker_container" "my_docker_container" {
  name = "${var.container_name}"
  image = docker_image.my_docker_image.latest
  restart = var.restart
  env = var.env
  network_mode = var.network_mode
  stdin_open = var.stdin_open
  tty = var.tty
  dns = []
  dynamic "volumes" {
    for_each = var.docker_volumes
    content {
      container_path = volumes.value["container_path"]
      host_path = volumes.value["host_path"]
    }
  }
  dynamic "ports" {
    for_each = var.docker_ports
    content {
      internal = ports.value["internal"]
      external = ports.value["external"]
      protocol = ports.value["protocol"]
    }
  }
  
}
