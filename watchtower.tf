resource "docker_image" "watchtower" {
  name = "containrrr/watchtower"
  force_remove = true
}

resource "docker_container" "watchtower" {
    name = "watchtower"
    image = docker_image.watchtower.latest
    restart = "unless-stopped"
    volumes {
        container_path = "/var/run/docker.sock"
        host_path = "/var/run/docker.sock"
    }
}