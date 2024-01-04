## Provider Variables

variable "aws_region" {
  type        = string
  description = "AWS region to use"
  default     = "eu-north-1"
}

##############


## Instance Variables

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "TestaBurken"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instnace type"
  default     = "t3.micro"
}

variable "instance_count" {
  type        = number
  description = "Create this many EC2 instances"
  default     = 2
}

##############


## Network Variables

variable "enable_dns" {
  type        = bool
  description = "Enable DNS hostnames"
  default     = true
}

variable "vpc_network" {
  type        = string
  description = "Base CIDR Block to use"
  default     = "10.13.37.0/24"
}

variable "subnet_count" {
  type        = number
  description = "Number of subnets to create in VPC network"
  default     = 2
}

variable "vpc_subnet1" {
  type        = string
  description = "Subnet 1 in VPC"
  default     = "10.0.0.0/24"
}

variable "map_public_ip" {
  type        = bool
  description = "Map a public IP address for Subnet instances"
  default     = true
}


### Variables for naming convention

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "Gurkburk"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "test"
}