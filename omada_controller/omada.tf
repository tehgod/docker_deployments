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

resource "docker_image" "omada" {
  name = "mbentley/omada-controller:latest"
  force_remove = true
}

resource "docker_container" "omada" {
  name = "omada"
  image = docker_image.omada.latest
  restart = "unless-stopped"
  network_mode = "host"
  env = [
      "PUID=1000",
      "PGID=1000",
      "TZ=America/Kentucky/Louisville",
      "MANAGE_HTTP_PORT=8088",
      "MANAGE_HTTPS_PORT=8043",
      "PORTAL_HTTP_PORT=8088",
      "PORTAL_HTTPS_PORT=8043",
      "SHOW_SERVER_LOGS=true",
      "SHOW_MONGODB_LOGS=false"
  ]
  volumes {
      container_path = "/opt/tplink/EAPController/data"
      host_path = "${pathexpand("~")}/config/app_config/omada/data"
  }
  volumes {
      container_path = "/opt/tplink/EAPController/work"
      host_path = "${pathexpand("~")}/config/app_config/omada/work"
  }
  volumes {
      container_path = "/opt/tplink/EAPController/logs"
      host_path = "${pathexpand("~")}/config/app_config/omada/logs"
  }
}