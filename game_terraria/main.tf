locals {
  container_name = ""
}

module "terraria" {
    source = "../modules"
    container_name = local.container_name
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
        {"host_path":"${pathexpand("~")}/config/app_config/terraria/world", "container_path":"/world"},
        {"host_path":"${pathexpand("~")}/config/app_config/terraria/config", "container_path":"/config"}
    ]
}