resource "aws_launch_template" "terraform_launch" {
  name_prefix   = "tf_launch"
  image_id      = aws_ami_from_instance.new_ec2_ami.id 
  instance_type = "t2.micro"
  #vpc_security_group_ids = [ var.sg1 ]
  key_name = var.key_name
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {  
      volume_size = 10
    }
  
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.sg1]
  }
}




resource "aws_autoscaling_group" "terraform_autoscaling_group" {
  name                      = "terraform_autoscaling_gp"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  #desired_capacity          = 4
  force_delete              = true
  #placement_group           = aws_placement_group.terraform-placement_group.id
  vpc_zone_identifier       = [var.subnet,var.subnet2]
  
 launch_template {
    id      = aws_launch_template.terraform_launch.id
    version = "$Latest"
  }
 
   /* 

    initial_lifecycle_hook {
    name                 = "terraform_lifecycle"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

  } */
  
}
resource "aws_ami_from_instance" "new_ec2_ami" {
  name               = "terraform-ec2"
  source_instance_id = var.instance_id2
}
resource "aws_autoscaling_policy" "target_track" {
   name = "scale-up"
   autoscaling_group_name = aws_autoscaling_group.terraform_autoscaling_group.name
  # scaling_adjustment   = 1
   adjustment_type = "ChangeInCapacity"

   policy_type            = "TargetTrackingScaling"

   target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60.0

  }
  
  
}


