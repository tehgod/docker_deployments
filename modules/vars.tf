variable "resource_location" {
  description = "Please enter URL for the image."
  type=string
}

variable "force_remove" {
  description = ""
  type = bool
  default = true  
}

variable "container_name" {
  description = "Name of docker container"  
  type = string
}

variable "docker_ports" {
  description = ""
  type = list(map(any))
  default = []
}

variable "restart" {
  description = ""
  type = string
  default = "unless-stopped"
}

variable "env" {
  description = ""
  type = list(string)
  default = []
}

variable "network_mode" {
  description = ""
  type = string
  default = ""
}

variable "stdin_open" {
  type = bool
  default = false
}
variable "tty" {
  type = bool
  default = false
}
variable "dns" {
  type = list(string)
  default = []
}
variable "devices" {
  type = list(map(any))
  default = []
}

variable "capabilities" {
  type = list(map(any))
  default = []
}

variable "docker_volumes" {
  type = list(map(any))
  default = []
}

variable "log_opts" {
  type = map(any)
  default = {}
}