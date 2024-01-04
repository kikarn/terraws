#### AWS Application Loadbalancer configuration
#Loadbalance HTTP between the different EC2 instances

resource "aws_lb" "testburk-lb" {
  name                       = "${local.naming_prefix}-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.SG-LB.id]
  subnets                    = aws_subnet.subnets[*].id
  enable_deletion_protection = false
}




# Load balancer listener. Listen on port 80 and forward to target group 
#created below
resource "aws_lb_listener" "testburk-listen" {
  load_balancer_arn = aws_lb.testburk-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.testburk-lbtg.arn
  }
}

# Load balancer target group
resource "aws_lb_target_group" "testburk-lbtg" {
  name     = "${local.naming_prefix}-lbtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.VPC-1.id
}

# Attach target group cretated above to instances
resource "aws_lb_target_group_attachment" "testburk-tga" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.testburk-lbtg.arn
  target_id        = aws_instance.testburk[count.index].id
  port             = 80
}