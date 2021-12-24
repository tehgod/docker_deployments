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

resource "docker_image" "jackett" {
  name = "linuxserver/jackett/latest"
  force_remove = true
}

resource "docker_container" "jackett" {
  name = "jackett"
  image = docker_image.jackett.latest
  restart = "unless-stopped"
  network_mode = "host"
  env = [
      "PUID=1000",
      "PGID=1000",
      "TZ=America/Kentucky/Louisville"
  ]
  volumes {
      container_path = "/etc/localtime"
      host_path = "/etc/localtime"
      read_only = true
  }
  volumes {
      container_path = "/downloads"
      host_path = "${pathexpand("~")}/config/downloads/torrent-blackhole"
  }
  volumes {
      container_path = "/config"
      host_path = "${pathexpand("~")}/config/app_config/jackett"
  }
}