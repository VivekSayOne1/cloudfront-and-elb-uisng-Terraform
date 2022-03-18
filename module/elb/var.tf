variable "lb_sg" {
  description = "lb sg"
}
variable "lb_subnet" {
  description = "lb subnet"
}
variable "lb_subnet2" {
  description = "lb subnet"
}

variable "lb_vpc" {
  description = "lb vpc"
}

variable "lb_instance" {
  description = "new ln instance"
}
variable "acm_certificate" {
  description = "new acm cert"
}
variable "name" {
   description = "name for elb"
}
variable "load_balancer_type" {
    description = "specify load-balancer type"
}
