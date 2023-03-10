module "ombi" {
    source = "../modules"
    container_name = "ombi"
    resource_location = "linuxserver/ombi:development"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville",
        "BASE_URL=/ombi"
    ]
    docker_ports = [
        {"internal":3579, "external":3579, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/ombi", "container_path":"/config"}
    ]
}

module "prowlarr" {
    source = "../modules"
    container_name = "prowlarr"
    resource_location = "linuxserver/prowlarr:develop"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    docker_ports = [
        {"internal":9696, "external":9696, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/prowlarr", "container_path":"/config"}
    ]
}

module "radarr" {
    source = "../modules"
    container_name = "radarr"
    resource_location = "linuxserver/radarr:latest"
    network_mode = "host"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    docker_ports = [
        {"internal":7878, "external":7878, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/radarr", "container_path":"/config"},
        {"host_path":"${pathexpand("~")}/config/complete/movies", "container_path":"/downloads"},
        {"host_path":"${pathexpand("~")}/config/downloads/complete", "container_path":"/data/completed"}
    ]
}

module "sonarr" {
    source = "../modules"
    container_name = "sonarr"
    resource_location = "linuxserver/sonarr:latest"
    network_mode = "host"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    docker_ports = [
        {"internal":8989, "external":8989, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/sonarr", "container_path":"/config"},
        {"host_path":"${pathexpand("~")}/config/complete/tv_shows", "container_path":"/tv_shows"},
        {"host_path":"${pathexpand("~")}/config/downloads/complete", "container_path":"/data/completed"}
    ]
}

module "bazarr" {
    source = "../modules"
    container_name = "bazarr"
    resource_location = "linuxserver/bazarr:latest"
    env = [
        "PUID=1000",
        "PGID=1000",
        "TZ=America/Kentucky/Louisville"
    ]
    docker_ports = [
        {"internal":6767, "external":6767, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/bazarr", "container_path":"/config"},
        {"host_path":"${pathexpand("~")}/config/complete/movies", "container_path":"/movies"},
        {"host_path":"${pathexpand("~")}/config/complete/movies", "container_path":"/downloads"},
        {"host_path":"${pathexpand("~")}/config/complete/tv_shows", "container_path":"/tv"}
    ]
}

#defined in secret autovars
variable "openvpn_username" {
  description = "OpenVPN Username"
  type        = string
  sensitive   = true
}

#defined in secret autovars
variable "openvpn_password" {
  description = "OpenVPN Password"
  type        = string
  sensitive   = true
}

module "transmission" {
    source = "../modules"
    container_name = "transmission"
    resource_location = "haugene/transmission-openvpn:latest"
    env = [
      "OPENVPN_PROVIDER=NORDVPN",
      "OPENVPN_USERNAME=${var.openvpn_username}",
      "OPENVPN_PASSWORD=${var.openvpn_password}",
      "OPENVPN_OPTS=--inactive 3600 --ping 10 --ping-exit 60",
      "LOCAL_NETWORK=192.168.86.0/24",
      "TRANSMISSION_RATIO_LIMIT=0",
      "TRANSMISSION_RATIO_LIMIT_ENABLED=false",
      "TRANSMISSION_IDLE_SEEDING_LIMIT=0",
      "TRANSMISSION_IDLE_SEEDING_LIMIT_ENABLED=true"
	]
    dns = [
      "8.8.8.8",
      "8.8.4.4"
    ]
    capabilities = [
        {"add":["NET_ADMIN"]}
    ]
    devices = [
        {"host_path":"/dev/net/tun"}
    ]
    docker_ports = [
        {"internal":9091, "external":9091, "protocol":"tcp"},
        {"internal":8888, "external":8888, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/transmission/", "container_path":"/data/transmission-home"},
        {"host_path":"${pathexpand("~")}/config/downloads/complete", "container_path":"/data/completed"},
        {"host_path":"${pathexpand("~")}/config/downloads/incomplete", "container_path":"/data/incomplete"},
        {"host_path":"${pathexpand("~")}/config/downloads/torrent-blackhole", "container_path":"/data/watch"},
        {"host_path":"/etc/localtime", "container_path":"/etc/localtime"}
    ]
}
