provider "aws" {
 secret_key = var.secret_key
 access_key = var.access_key
 region     = var.region
    
}
variable "secret_key" {
  description = "secret_key for aws"
}
variable "access_key" {
  description = "Access_key for aws"
}
variable "ami" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
 
}
variable "key_name" {
  description = "aws key_name"
}
variable "region" {
  description = "aws instance region"
}

variable "availability_zone" {
  description = "aws availability_zone"
}

variable "availability_zone2" {
   description = "new"
}

variable "instance_type" {
  description = "aws instance type"
}

variable "tags" {
description = "terraform instance tag name"
type = map
}

variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map
}
variable "ec2_count" {
  type = number
  default = "1"
}
variable "allocated_storage" {
  description = "allocated space for rds"
   type = number

}
variable "engine" {
     description = "rds engine specification"
}
variable "engine_version" {
   description = " rds engine version specification"
}
variable "instance_class" {
   description = " rds engine instance_class specification"
}
variable "name" {
    description = "rds name specification"
}
variable "username" {
    description = "rds db username specification"
}
variable "password" {
    description = "rds db instance password specification"
}
variable "parameter_group_name" {
    description = "rds db engine parameter_group_name specification"
}
variable "skip_final_snapshot" {
    description = "rds db engine snapshot"
}
variable "bucket" {
  description = "aws s3 bucket-name"
}
variable "load_balancer_type" {
    description = "specify load-balancer type"
}
variable "suffix" {
   description = "add suffix value"
} 
variable "key" {
   description = "add key value"
}
