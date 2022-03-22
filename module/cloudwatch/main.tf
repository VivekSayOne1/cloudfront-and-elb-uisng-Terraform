resource "aws_cloudwatch_metric_alarm" "terraform_alarm" {
  alarm_name                = "terraform-test-auto"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "50"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

   alarm_actions     = [var.asg_policy1]
}

resource "aws_cloudwatch_metric_alarm" "terraform_alarm2" {
  alarm_name                = "terraform-test-auto1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "20"
  alarm_description         = "This metric monitors ec2 cpu utilization"


  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

   alarm_actions     = [var.asg_policy2]
}
