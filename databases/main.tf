variable "sql_root_pw" {
  type        = string
  sensitive   = true
}

module "MySQL" {
    source = "../modules"
    container_name = "MySQL"
    resource_location = "mysql:latest"
    env = [
        "MYSQL_ROOT_PASSWORD=${var.sql_root_pw}"
    ]
    docker_ports = [
        {"internal":3306, "external":3306, "protocol":"tcp"}
    ]
    docker_volumes = [
        {"host_path":"${pathexpand("~")}/config/app_config/mysql", "container_path":"/var/lib/mysql"}
    ]
}