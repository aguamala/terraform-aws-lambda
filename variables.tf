variable "function_name" {
  description = "Lambda function name"
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem."
  default = ""
}

variable "description" {
  description = "Lambda function description"
}

variable "dead_letter_target_arn" {
  description = "The ARN of an SNS topic or SQS queue to notify when an invocation fails."
  default = ""
}

variable "publish" {
  description = "Publish lambda function version"
  default = false
}

variable "runtime" {
  description = "Lambda function runtime"
}

variable "memory_size" {
  description = "Lambda function memory size"
  default = "128"
}

variable "handler" {
  description = "Lambda function handler"
}

variable "timeout" {
  description = "Lambda function timeout"
}

variable "s3_bucket" {
  description = "Lambda function package S3 bucket"
  default = ""
}

variable "s3_key" {
  description = "Lambda function package S3 key"
  default = ""
}

variable "s3_object_version" {
  description = "Lambda function package S3 version"
  default = ""
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

variable "vpc_access" {
  description = "Lambda function needs VPC access"
  default = false
}

variable "vpc_subnet_ids" {
  description = "VPC access subnet ids"
  default = ""
}

variable "vpc_security_group_ids" {
  description = "VPC access security groups"
  default = ""
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
