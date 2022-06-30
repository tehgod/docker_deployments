resource "docker_image" "ddclient" {
  name = "lscr.io/linuxserver/ddclient:latest"
  force_remove = true
}

resource "docker_container" "ddclient" {
  name = "ddclient"
  image = docker_image.syncthing.latest
  restart = "unless-stopped"
  env = [
      "PUID=1000",
      "PGID=1000",
      "TZ=America/Kentucky/Louisville"
  ]
  volumes {
      container_path = "/config"
      host_path = "${pathexpand("~")}/config/app_config/ddclient"
  }
}