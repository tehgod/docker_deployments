locals {
  server_name = ""
}

module "minecraft" {
    source = "../modules"
    container_name = "mc_server_${local.server_name}"
    resource_location = "itzg/minecraft-bedrock-server:latest"
    env = [
        "EULA=TRUE",
        "DIFFICULTY=normal",
        "SERVER_NAME=${local.server_name}"
    ]
    docker_ports = [
        {"internal":19132, "external":19132, "protocol":"udp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/minecraft_bedrock/${local.server_name}", "container_path":"/data"}
    ]
}