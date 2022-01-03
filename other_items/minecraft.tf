resource "docker_image" "minecraft" {
  name = "itzg/minecraft-server:latest"
  force_remove = true
}

variable "server_name" {
  description = "Desired Server Name"
  type        = string
}

resource "docker_container" "minecraft" {
    name = "MC_Server_${var.server_name}"
    image = docker_image.minecraft.latest
    rm = true
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