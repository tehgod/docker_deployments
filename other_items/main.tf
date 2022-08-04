module "syncthing" {
    source = "../modules"
    container_name = "syncthing"
    resource_location = "linuxserver/syncthing:latest"
    network_mode = "host"
    env = [
        "PUID=1000",
        "PGID=1000"
    ]
    docker_ports = [
        {"internal":8384, "external":8384, "protocol":"tcp"},
        {"internal":22000, "external":22000, "protocol":"tcp"},
        {"internal":21027, "external":21027, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/syncthing", "container_path":"/config"},
        {"host_path":"${pathexpand("~")}/syncthing", "container_path":"/syncthing"}
    ]
}

module "ddclient" {
    source = "../modules"
    container_name = "ddclient"
    resource_location = "lscr.io/linuxserver/ddclient:latest"
    env = [
      "PUID=1000",
      "PGID=1000",
      "TZ=America/Kentucky/Louisville"
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/ddclient", "container_path":"/config"}
    ]
}

module "changedetection" {
    source = "../modules"
    container_name = "changedetection.io"
    resource_location = "dgtlmoon/changedetection.io:latest"
    docker_ports = [
        {"internal":5000, "external":5000, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/changedetection", "container_path":"/datastore"}
    ]
}