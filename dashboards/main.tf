module "heimdall" {
    source = "../modules"
    container_name = "heimdall"
    resource_location = "linuxserver/heimdall:latest"
    env = [
      "PUID=1000",
      "PGID=1000",
      "TZ=America/Kentucky/Louisville"
    ]
    docker_ports = [
        {"internal":443, "external":4443, "protocol":"tcp"},
        {"internal":80, "external":7888, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/heimdall", "container_path":"/config"}
    ]
}

module "portainer" {
    source = "../modules"
    container_name = "portainer"
    resource_location = "portainer/portainer-ce:latest"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    docker_ports = [
        {"internal":8000, "external":8000, "protocol":"tcp"},
        {"internal":9443, "external":9443, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"/var/run/docker.sock", "container_path":"/var/run/docker.sock"},
        {"host_path":"${pathexpand("~")}/config/app_config/portainer", "container_path":"/data"}
    ]
}

