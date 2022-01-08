resource "docker_image" "syncthing" {
  name = "linuxserver/syncthing:latest"
  force_remove = true
}

resource "docker_container" "syncthing" {
  name = "syncthing"
  image = docker_image.syncthing.latest
  restart = "unless-stopped"
  network_mode = "host"
  log_driver = "json-file"
  env = [
      "PUID=1000",
      "PGID=1000"
  ]
  volumes {
      container_path = "/etc/localtime"
      host_path = "/etc/localtime"
      read_only = true
  }
  volumes {
      container_path = "/config"
      host_path = "${pathexpand("~")}/config/app_config/syncthing"
  }
  ports {
        internal = 8384
        external = 8384
    }
    ports {
        internal = 22000
        external = 22000
    }
    ports {
        internal = 21027
        external = 21027
    }
}