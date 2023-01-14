module "syncthing" {
    source = "../modules"
    container_name = "kavita"
    resource_location = "kizaing/kavita:latest"
    docker_ports = [
        {"internal":5000, "external":5000, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/kavita", "container_path":"/kavita/config"},
        {"host_path":"${pathexpand("~")}/kavita", "container_path":"/manga"}
    ]
}
