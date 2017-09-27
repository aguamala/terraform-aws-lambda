variable "function_name" {
  description = "Lambda function name"
}

variable "description" {
  description = "Lambda function description"
}

variable "runtime" {
  description = "Lambda function runtime"
}

variable "handler" {
  description = "Lambda function handler"
}

variable "timeout" {
  description = "Lambda function timeout"
}

variable "s3_bucket" {
  description = "Lambda function package S3 bucket"
}

variable "s3_key" {
  description = "Lambda function package S3 key"
}

variable "s3_object_version" {
  description = "Lambda function package S3 version"
}

variable "role" {
  description = "Lambda function IAM role"
}

variable "tags" {
  description = "Lambda funcition map of tags"
  default     = {}
}

variable "environment_variables" {
  description = "A list of environment variables for the lambda function"
  default     = {
    workspace = "default"
  }
}

variable "vpc_subnet_ids" {
  description = "VPC access subnet ids"
  default = []
}

variable "vpc_security_group_ids" {
  description = "VPC access security groups"
  default = []
}

variable "schedule" {
  description = "Schedule lambda function with cloudwatch event"
  default = false
}

variable "schedule_is_enabled" {
  description = "Enable Schedule lambda function"
  default = true
}

variable  "schedule_expression" {
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
  default = "cron(0 0 * * ? *)"
}
