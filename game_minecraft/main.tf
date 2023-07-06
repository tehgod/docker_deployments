locals {
  server_name = "lynch_mob_server"
}

module "minecraft" {
    source = "../modules"
    container_name = "mc_server_${local.server_name}"
    resource_location = "itzg/minecraft-server:latest"
    env = [
        "EULA=TRUE",
        "DIFFICULTY=hard",
        "SERVER_NAME=${local.server_name}",
	"MEMORY=2G"
    ]
    docker_ports = [
        {"internal":25565, "external":25565, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/minecraft/${local.server_name}", "container_path":"/data"}
    ]
}
