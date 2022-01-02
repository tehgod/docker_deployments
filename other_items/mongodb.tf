resource "docker_image" "mongo" {
  name = "mongo:latest"
  force_remove = true
}

resource "docker_container" "mongo" {
    name = "mongo"
    image = docker_image.mongo.latest
    restart = "always"
    ports {
        internal = 27017
        external = 27017
    }
}