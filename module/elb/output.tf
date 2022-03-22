output "elb_dns" {
  value = aws_lb.elb-terraform.dns_name
}
output "elb_zone_id" {
  value = aws_lb.elb-terraform.zone_id
}
output "elb_arn" {
  value = aws_lb_target_group.terraform-target_group.id
}
