resource "docker_image" "overseerr" {
  name = "sctx/overseerr"
  force_remove = true
}

resource "docker_container" "overseerr" {
    name = "overseerr"
    image = docker_image.overseerr.latest
    restart = "unless-stopped"
    env = [
        "LOG_LEVEL=debug",
        "TZ=America/Kentucky/Louisville"
    ]
    volumes {
        container_path = "/app/config"  
        host_path = "${pathexpand("~")}/config/app_config/overseerr"
    }
    ports {
        internal = 5055
        external = 5055
    }
}