locals {
  container_name = ""
}

module "omada" {
    source = "./modules"
    container_name = local.container_name
    resource_location = "mbentley/omada-controller:latest"
    network_mode = "host"
    env = [
      "PUID=1000",
      "PGID=1000",
      "TZ=America/Kentucky/Louisville",
      "MANAGE_HTTP_PORT=8088",
      "MANAGE_HTTPS_PORT=8043",
      "PORTAL_HTTP_PORT=8088",
      "PORTAL_HTTPS_PORT=8043",
      "SHOW_SERVER_LOGS=true",
      "SHOW_MONGODB_LOGS=false"
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/omada/data", "container_path":"/opt/tplink/EAPController/data"},
        {"host_path":"${pathexpand("~")}/config/app_config/omada/work", "container_path":"/opt/tplink/EAPController/work"},
        {"host_path":"${pathexpand("~")}/config/app_config/omada/logs", "container_path":"/opt/tplink/EAPController/logs"}
    ]
}