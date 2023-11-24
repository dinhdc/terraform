# # Target Group
# resource "aws_lb_target_group" "alb_target_group" {
#   name        = "app1-target-group"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "instance"

#   health_check {
#     enabled             = true
#     interval            = 30
#     path                = "/app1/index.html"
#     port                = "traffic-port"
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#     timeout             = 6
#     protocol            = "HTTP"
#     matcher             = "200-399"
#   }

#   vpc_id = module.vpc.vpc_id

#   tags = local.common_tags # Target Group Tags
# }


# # Listener
# resource "aws_lb_listener" "alb_listener" {
#   load_balancer_arn = aws_lb_target_group.alb_target_group.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb_target_group.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "alb_target_group_instances" {

#   for_each = module.ec2_private
#   target_group_arn = aws_lb_target_group.alb_target_group.arn
#   target_id        = each.value.id
#   port             = 80
# }
