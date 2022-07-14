locals {
  server1_name = "terraria_nonmodded"
  server2_name = "terraria_modded"
}

module "terraria" {
    source = "../modules"
    container_name = local.server1_name
    resource_location = "kaysond/docker-terraria"
    stdin_open = true
    tty = true
    env = [
        "PUID=1000",
        "PGID=1000"
    ]
    docker_ports = [
        {"internal":7777, "external":7777, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/terraria/${server1_name}/world", "container_path":"/world"},
        {"host_path":"${pathexpand("~")}/config/app_config/terraria/${server1_name}/config", "container_path":"/config"}
    ]
}

module "terraria2" {
    source = "../modules"
    container_name = local.server2_name
    resource_location = "shelby_terraria_image"
    stdin_open = true
    tty = true
    env = [
        "PUID=1000",
        "PGID=1000"
    ]
    docker_ports = [
        {"internal":7778, "external":7778, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/terraria/${server2_name}/server", "container_path":"/server"},
    ]
}