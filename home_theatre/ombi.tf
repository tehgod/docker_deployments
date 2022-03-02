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

resource "docker_image" "ombi" {
  name = "linuxserver/ombi:development"
  force_remove = true
}

resource "docker_container" "ombi" {
    name = "ombi"
    image = docker_image.ombi.latest
    restart = "unless-stopped"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville",
        "BASE_URL=/ombi"
    ]
    volumes {
        container_path = "/config"
        host_path = "${pathexpand("~")}/config/app_config/ombi"
    }
    ports {
        internal = 3579
        external = 3579
    }
}
