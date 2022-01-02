resource "docker_image" "mongo" {
  name = "mongo:4.4.11"
  force_remove = true
}

resource "docker_container" "mongo" {
    name = "mongo"
    image = docker_image.mongo.latest
    restart = "always"
    rm = true
    ports {
        internal = 27017
        external = 27017
    }
}