variable "sql_root_pw" {
  description = "MariaDB Password"
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
}