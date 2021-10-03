variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "vpc_id" {
  description = "The VPC ID to deploy to (e.g. us-east-1)"
}

variable "sg_groups" {
  type        = any
  description = "List of Security Groups that include list of maps of ingress and egress"
}