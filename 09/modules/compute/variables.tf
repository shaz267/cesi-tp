variable "name" {
  description = "Nom du serveur"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Liste des subnets où créer l'instance"
  type        = list(string)
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI à utiliser pour l'instance (Ubuntu par exemple)"
  type        = string
}

variable "key_name" {
  description = "Nom de la clé SSH pour accéder à l'instance"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR autorisé pour SSH"
  type        = string
  default     = "0.0.0.0/0"
}
