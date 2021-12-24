resource "docker_image" "radarr" {
  name = "linuxserver/radarr/latest"
  force_remove = true
}

resource "docker_container" "radarr" {
    name = "radarr"
    image = docker_image.radarr.latest
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
        host_path = "${pathexpand("~")}/config/app_config/radarr"
    }
    volumes {
        container_path = "/downloads"
        host_path = "${pathexpand("~")}/config/complete/movies"
    }
    volumes {
        container_path = "/data/completed"
        host_path = "${pathexpand("~")}/config/downloads/complete"
    }
}





