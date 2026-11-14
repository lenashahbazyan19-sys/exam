variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "trusted_ssh_cidr" {
  description = "Trusted CIDR block allowed for SSH access"
  type        = string
  default     = "203.0.113.10/32"

  validation {
    condition     = var.trusted_ssh_cidr != "0.0.0.0/0"
    error_message = "SSH access from 0.0.0.0/0 is not allowed."
  }
}
