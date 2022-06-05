resource "docker_image" "prowlarr" {
<<<<<<< HEAD
  name = "linuxserver/prowlarr:develop"
=======
  name = "lscr.io/linuxserver/prowlarr:develop"
>>>>>>> fb0aab61f4194218a316eb9567b08ac4754d2878
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
