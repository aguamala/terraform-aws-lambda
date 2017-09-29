#--------------------------------------------------------------
# lambda function in S3 bucket w/VPC access
#--------------------------------------------------------------
resource "aws_lambda_function" "s3_vpc" {
    count = "${var.vpc_access && var.filename == "" && var.dead_letter_target_arn == "" ? 1 : 0}"

    runtime           = "${var.runtime}"
    memory_size       = "${var.memory_size}"
    timeout           = "${var.timeout}"
    s3_bucket         = "${var.s3_bucket}"
    s3_key            = "${var.s3_key}"
    s3_object_version = "${var.s3_object_version}"
    function_name     = "${var.function_name}_s3_vpc"
    role              = "${var.role}"
    handler           = "${var.handler}"
    description       = "${var.description}"

    environment {
        variables = "${var.environment_variables}"
    }

    vpc_config {
        subnet_ids = ["${split(",", var.vpc_subnet_ids)}"]

        security_group_ids = ["${split(",", var.vpc_security_group_ids)}"]
    }
}

resource "aws_lambda_permission" "cloudwatch_event_s3_vpc" {
    count = "${var.vpc_access && var.filename == "" && var.dead_letter_target_arn == "" ? 1 : 0}"
    
    statement_id  = "AllowExecutionFromCloudWatch"
    action        = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.s3_vpc.arn}"
    principal     = "events.amazonaws.com"
    source_arn    = "${aws_cloudwatch_event_rule.s3_vpc.arn}"
}

resource "aws_cloudwatch_event_rule" "s3_vpc" {
    count = "${var.vpc_access && var.filename == "" && var.dead_letter_target_arn == "" ? 1 : 0}"
    
    name                = "${aws_lambda_function.s3_vpc.function_name}_s3_vpc"
    schedule_expression = "${var.schedule_expression}"
    is_enabled          = "${var.schedule_is_enabled}"
}

resource "aws_cloudwatch_event_target" "s3_vpc" {
    count = "${var.vpc_access && var.filename == "" && var.dead_letter_target_arn == "" ? 1 : 0}"
    
    target_id = "${aws_lambda_function.s3_vpc.function_name}"
    rule      = "${aws_cloudwatch_event_rule.s3_vpc.name}"
    arn       = "${aws_lambda_function.s3_vpc.arn}"
}