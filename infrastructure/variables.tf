variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "DemoWebServerMahnoosh"
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "key_pair_name" {
  description = "Name of the existing AWS Key Pair"
  type        = string
  default     = "Mahnoosh_Hallo2307"
}

variable "profile" {
  description = "AWS Profile"
  type        = string
  default     = "default"
}
variable "ami" {
  description = "AWS AMI"
  type        = string
  default     = "ami-099da3ad959447ffa"
}
variable "db_username" {
  description = "RDS username"
  type        = string
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}
