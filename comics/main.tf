module "syncthing" {
    source = "../modules"
    container_name = "kavita"
    resource_location = "kizaing/kavita:latest"
    docker_ports = [
        {"internal":5050, "external":5050, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/kavita", "container_path":"/kavita/config"},
        {"host_path":"${pathexpand("~")}/kavita", "container_path":"/manga"}
    ]
}
