output "asg_name" {
    value = aws_autoscaling_group.terraform_autoscaling_group.name 
  
}
output "asg_policy1" {
    value = aws_autoscaling_policy.step_scaling1.arn
  
}
output "asg_policy2" {
    value = aws_autoscaling_policy.step_scaling2.arn
  
}
