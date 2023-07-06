module "wireguard" {
    source = "../modules"
    container_name = "wireguard"
    resource_location = "weejewel/wg-easy:latest"
    network_mode = "host"
    env = [
        "WG_HOST=http://cloud.bevhemotharmy.com"
    ]
    docker_ports = [
        {"internal":51820, "external":51820, "protocol":"udp"},
        {"internal":51821, "external":51821, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/wireguard", "container_path":"/etc/wireguard"}
    ]
    sysctl = {
        "net.ipv4.conf.all.src_valid_mark"="1",
        "net.ipv4.ip_forward"="1"
    }
}