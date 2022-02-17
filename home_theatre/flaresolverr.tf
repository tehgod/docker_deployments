resource "docker_image" "flaresolverr" {
  name = "linuxserver/sonarr:latest"
  force_remove = true
}

resource "docker_container" "flaresolverr" {
    name = "flaresolverr"
    image = docker_image.sonarr.latest
    restart = "unless-stopped"
    env = [
        "LOG_LEVEL=info"
    ]
    ports {
        internal = 8191
        external = 8191
    }
    volumes {
        container_path = "/config"
        host_path = "${pathexpand("~")}/config/app_config/flaresolverr"
    }
}