variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "db_username" {
  description = "RDS username"
  type        = string
  default     = "adminuser"
}


variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  default     = "10.10.1.0/24"
}

variable "private_subnet1_cidr" {
  description = "Private Subnet 1 CIDR"
  default     = "10.10.2.0/24"
}

variable "private_subnet2_cidr" {
  description = "Private Subnet 2 CIDR"
  default     = "10.10.3.0/24"
}
