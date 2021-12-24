resource "docker_image" "heimdall" {
  name = "linuxserver/heimdall"
  force_remove = true
}

resource "docker_container" "heimdall" {
    name = "heimdall"
    image = docker_image.heimdall.latest
    restart = "unless-stopped"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    volumes {
        container_path = "/config"
        host_path = "${pathexpand("~")}/config/app_config/heimdall"
    }
    ports {
        internal = 443
        external = 4443
    }
    ports {
        internal = 80
        external = 7888
    }
}