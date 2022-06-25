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

resource "docker_image" "terraria" {
  name = "kaysond/docker-terraria"
  force_remove = true
}

resource "docker_container" "terraria" {
    name = "terraria"
    image = docker_image.terraria.latest
    rm = true
    stdin_open = true
    tty = true
    ports {
        internal = 7777
        external = 7777
    }
    env = [
        "PUID=1000",
        "PGID=1000"
    ]
    volumes {
        container_path = "/world"
        host_path = "${pathexpand("~")}/config/app_config/terraria/world"
    }
    volumes {
        container_path = "/config"
        host_path = "${pathexpand("~")}/config/app_config/terraria/config"
    }
}