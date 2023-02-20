variable "maria_db_user" {
  description = "MariaDB Username"
  type        = string
  sensitive   = true
}

#defined in secret autovars
variable "maria_db_user_pw" {
  description = "MariaDB Password"
  type        = string
  sensitive   = true
}

variable "maria_db_root_pw" {
  description = "MariaDB Password"
  type        = string
  sensitive   = true
}

module "Mariadb" {
    source = "../modules"
    container_name = "mariadb"
    resource_location = "mariadb:latest"
    network_mode = "host"
    env = [
        "MARIADB_USER=${var.maria_db_user}",
        "MARIADB_PASSWORD=${var.maria_db_user_pw}",
        "MARIADB_ROOT_PASSWORD=${var.maria_db_root_pw}"
    ]
    docker_ports = [
        {"internal":3306, "external":3306, "protocol":"tcp"}
    ]
}