module "alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = false
  #expense-dev-app-alb
  name    = "${var.project_name}-${var.environment}-web-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.public_subnet_ids
  create_security_group = false
  security_groups = [local.web_alb_sg_id]
  enable_deletion_protection = false
  
  tags = merge(
    var.common_tags,
    
    {
      Name = "${var.project_name}-${var.environment}-web-alb"
    }
  )
  
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = module.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.web_alb_certificate_arn

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello I am from Frontend WEB ALB with https </h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "web_alb" {
  zone_id = var.zone_id
  name    = "expense-${var.environment}.${var.domain_name}"
  type    = "A"
# these are ALB DNS name and zone id details
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
    
  }
}