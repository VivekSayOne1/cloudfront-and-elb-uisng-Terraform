/*
resource "aws_placement_group" "terraform-placement_group" {
  name     = "placement_group"
  strategy = "cluster"
}*/

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
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  #desired_capacity          = 4
  #force_delete              = true
  #placement_group           = aws_placement_group.terraform-placement_group.id
  vpc_zone_identifier       = [var.subnet,var.subnet2]
  target_group_arns         = [var.alb1]
  termination_policies      = ["NewestInstance"] 
  
 launch_template {
    id      = aws_launch_template.terraform_launch.id
    version = "$Latest"
  }
 
/*  initial_lifecycle_hook {
    name                 = "terraform_lifecycle"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

  } */
  
}
resource "aws_ami_from_instance" "new_ec2_ami" {
  name               = "terraform-ec2"
  source_instance_id = var.instance_id2
  depends_on = [var.wait_30_seconds]
    
  
}
resource "aws_autoscaling_policy" "step_scaling1" {
   name = "scale-up"
   autoscaling_group_name = aws_autoscaling_group.terraform_autoscaling_group.name
  # scaling_adjustment   = 1
   adjustment_type = "ChangeInCapacity"

   policy_type            = "StepScaling"

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 30
    metric_interval_upper_bound = 40
  }

  step_adjustment {
    scaling_adjustment          = 2
    metric_interval_lower_bound = 40
    #metric_interval_upper_bound = 
  }
   
  
  
}

resource "aws_autoscaling_policy" "step_scaling2" {
   name = "scale-down"
   autoscaling_group_name = aws_autoscaling_group.terraform_autoscaling_group.name
  # scaling_adjustment   = 1
   adjustment_type = "ChangeInCapacity"

   policy_type            = "StepScaling"

  step_adjustment {
    scaling_adjustment          = -2
    metric_interval_lower_bound = 10
    metric_interval_upper_bound = 20
  }

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = 20
    #metric_interval_upper_bound = 30
  }
   
  
  
}
