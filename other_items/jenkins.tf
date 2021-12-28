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

resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:latest"
  force_remove = true
}

resource "docker_container" "jenkins" {
  name = "jenkins"
  image = docker_image.jenkins.latest
  restart = "unless-stopped"
  user = "root"
  volumes {
      container_path = "/var/jenkins_home"
      host_path = "${pathexpand("~")}/config/app_config/jenkins"
  }
  ports {
        internal = 8080
        external = 4545
    }
    ports {
        internal = 50000
        external = 50000
    }
}