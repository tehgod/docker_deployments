resource "docker_image" "minecraft" {
  name = "itzg/minecraft:latest"
  force_remove = true
}

variable "server_name" {
  description = "Desired Server Name"
  type        = string
}

resource "docker_container" "minecraft" {
    name = "MC Server ${var.server_name}"
    image = docker_image.minecraft.latest
    restart = "always"
    ports {
        internal = 25565
        external = 25565
    }
    env = [
        "EULA=TRUE",
        "DIFFICULTY=hard",
        "SERVER_NAME=${var.server_name}"
    ]
    volumes {
        container_path = "/data"
        host_path = "${pathexpand("~")}/config/app_config/minecraft/${var.server_name}"
    }
}