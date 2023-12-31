#--- autoscaling/bastion-nginx.tf ----

#### create sns topic for all the auto scaling groups
resource "aws_sns_topic" "mayor-sns" {
  name = "Default_CloudWatch_Alarms_Topic"
}

#create notification for all auto scaling groups
resource "aws_autoscaling_notification" "mayor_notifications" {
  group_names = [
    aws_autoscaling_group.bastion-asg.name,
    aws_autoscaling_group.nginx-asg.name,
    aws_autoscaling_group.wordpress-asg.name,
    aws_autoscaling_group.tooling-asg.name,
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.mayor-sns.arn
}


# data "local_file" "public_key" {
#   depends_on = [ null_resource.generate_ssh_key ]
#   filename = "/Users/mozart/.ssh/id_rsa.pub"
# }

# resource "aws_key_pair" "terraform-pbl19" {
#   key_name   = "pbl19-key"
#   public_key = file("../modules/autoscaling/pbl19-key.pub")
# }

#-----------------------------------------------------
#create bastion launch template

resource "aws_launch_template" "bastion-launch-template" {
  image_id               = var.ami-bastion
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.bastion-sg]

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.key_pair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "bastion-launch-template"
      },
    )
  }

}

# ------ Autoscaling for bastion  hosts

resource "aws_autoscaling_group" "bastion-asg" {
  name                      = "bastion-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity

  vpc_zone_identifier = [
    var.public_subnet_1,
    var.public_subnet_2
  ]

  launch_template {
    id      = aws_launch_template.bastion-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "bastion_asg"
    propagate_at_launch = true
  }

}

# launch template for nginx

resource "aws_launch_template" "nginx-launch-template" {
  image_id               = var.ami-nginx
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.nginx-sg]

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.key_pair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "nginx-launch-template"
      },
    )
  }

}

# ------ Autoscslaling group for reverse proxy nginx ---------

resource "aws_autoscaling_group" "nginx-asg" {
  name                      = "nginx-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity

  vpc_zone_identifier = [
    var.private_subnet_1,
    var.private_subnet_2
  ]

  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "nginx_asg"
    propagate_at_launch = true
  }

}

#--- attaching autoscaling group of nginx to external load balancer

resource "aws_autoscaling_attachment" "asg_attachment_nginx" {
  autoscaling_group_name = aws_autoscaling_group.nginx-asg.id
  lb_target_group_arn    = var.nginx-alb-tg
}





