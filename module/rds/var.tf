variable "security-groupid" {
  description = "new sg"
}
variable "subnetid" {
  description = "rds-subnet"
}
variable "subnetid2" {
  description = "rds-subnet"
}
variable "allocated_storage" {
  description ="allocated storage space for rds"
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
