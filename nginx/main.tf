module "nginx" {
    source = "../modules"
    container_name = "nginx"
    resource_location = "nginx"
    docker_ports = [
        {"internal":80, "external":7979, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/nginx", "container_path":"/etc/nginx"}
    ]
}