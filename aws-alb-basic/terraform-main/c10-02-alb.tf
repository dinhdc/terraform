module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.2.0"

  name   = "${local.name}-lb"
  vpc_id = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]

  security_groups = [module.loadbalancer_sg.security_group_id]

  # Listeners
  listeners = {
    ex-http = {
      port        = 80
      protocol    = "HTTP"
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        status_code  = "200"
        message_body = "OK"
      }
    }
  }

  # Target Group
  target_groups = {
    ex-instance = {
      name_prefix      = "app1-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      targets = {
        my_app1_vm1 = {
          id                = module.ec2_private[0].id
          port              = 80
          create_attachment = true
        },
        my_app1_vm2 = {
          id                = module.ec2_private[1].id
          port              = 80
          create_attachment = true
        }
      }
      target_id = module.ec2_private[0].id
      tags = local.common_tags # Target Group Tags
    }
  }


  tags = local.common_tags # ALB Tags
}
