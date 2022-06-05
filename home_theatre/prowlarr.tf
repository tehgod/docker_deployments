resource "docker_image" "prowlarr" {
  name = "linuxserver/prowlarr:develop"
  force_remove = true
}

resource "docker_container" "prowlarr" {
    name = "prowlarr"
    image = docker_image.prowlarr.latest
    restart = "unless-stopped"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    volumes {
        container_path = "/config"
        host_path = "${pathexpand("~")}/config/app_config/prowlarr"
    }
    ports {
        internal = 9696
        external = 9696
    }
}
