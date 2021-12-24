resource "docker_image" "sonarr" {
  name = "linuxserver/sonarr"
}

resource "docker_container" "sonarr" {
    name = "sonarr"
    image = docker_image.sonarr.latest
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
        container_path = "/config"
        host_path = "${pathexpand("~")}/config/app_config/sonarr"
    }
    volumes {
        container_path = "/tv_shows"
        host_path = "${pathexpand("~")}/config/complete/tv_shows"
    }
    volumes {
        container_path = "/data/completed"
        host_path = "${pathexpand("~")}/config/downloads/complete"
    }
}