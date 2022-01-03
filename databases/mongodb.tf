terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "mongo" {
  name = "mongo:4.4.11"
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