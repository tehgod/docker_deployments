resource "docker_image" "portainer" {
  name = "portainer/portainer-ce"
  force_remove = true
}

resource "docker_container" "portainer" {
    name = "portainer"
    image = docker_image.portainer.latest
    restart = "unless-stopped"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    volumes {
        container_path = "/var/run/docker.sock"
        host_path = "/var/run/docker.sock"
    }
    volumes {
        container_path = "/data"
        host_path = "${pathexpand("~")}/config/app_config/portainer"
    }
    ports {
        internal = 8000
        external = 8000
    }
    ports {
        internal = 9443
        external = 9443
    }
}