# create load balancer 
resource "aws_lb" "load_balancer" {
  name = var.lb_name
  load_balancer_type = var.lb_type
  internal = false
  security_groups = [var.load_balancer_sg]
  subnets = [var.public_subnet1_id, var.public_subnet2_id, var.public_subnet3_id]


}

# create a target group
resource "aws_lb_target_group" "target_group" {
 name = var.target-group-name 
 target_type = "instance"
 port = 80
 protocol = "HTTP"
 vpc_id = var.vpc_id
 health_check {
   enabled = true
   healthy_threshold = 3
   interval = 10
   matcher = 200
   path = "/"
   timeout = 3
   unhealthy_threshold = 3
 }
}


resource "aws_lb_listener" "listener_rule-HTTP" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

  # attach target group to load balancer
  resource "aws_lb_target_group_attachment" "target-group-attach" {
  count = 3

  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = [var.pub-ec2-instance1-id, var.pub-ec2-instance2-id, var.pub-ec2-instance3-id][count.index]
  port             = 80
}
