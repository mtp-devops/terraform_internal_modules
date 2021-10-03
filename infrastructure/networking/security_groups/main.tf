locals {
  default_egress_rules = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
resource "aws_security_group" "sg_group" {
  for_each    = var.sg_groups
  
  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = rule
    for_each = each.value.ingress_rule
    content {
      from_port   = rule.value["from_port"]
      to_port     = rule.value["to_port"]
      protocol    = rule.value["protocol"]
      cidr_blocks = lookup(rule.value, "cidr_blocks", null)
      security_groups = lookup(rule.value, "security_groups", null)
      description = lookup(rule.value, "description", null)
      self = lookup(rule.value, "self", false)
    }
  }

  dynamic "egress" {
    iterator = rule
    for_each = lookup(each.value, "egress_rule", local.default_egress_rules)
    content {
      from_port   = rule.value["from_port"]
      to_port     = rule.value["to_port"]
      protocol    = rule.value["protocol"]
      cidr_blocks = rule.value["cidr_blocks"]
    }
  }

  tags = each.value.tags
}
