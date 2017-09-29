#--------------------------------------------------------------
# lambda function in filename  w/VPC access
#--------------------------------------------------------------
resource "aws_lambda_function" "filename_vpc" {
    count = "${var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"

    runtime           = "${var.runtime}"
    memory_size       = "${var.memory_size}"
    timeout           = "${var.timeout}"
    filename          = "${var.filename}"
    source_code_hash = "${base64sha256(file("${var.filename}"))}"
    function_name     = "${var.function_name}_vpc"
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

resource "aws_lambda_permission" "cloudwatch_event_filename_vpc" {
    count = "${var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"
    
    statement_id  = "AllowExecutionFromCloudWatch"
    action        = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.filename_vpc.arn}"
    principal     = "events.amazonaws.com"
    source_arn    = "${aws_cloudwatch_event_rule.filename_vpc.arn}"
}

resource "aws_cloudwatch_event_rule" "filename_vpc" {
    count = "${var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"
    
    name                = "${aws_lambda_function.filename_vpc.function_name}_filename_vpc"
    schedule_expression = "${var.schedule_expression}"
    is_enabled          = "${var.schedule_is_enabled}"
}

resource "aws_cloudwatch_event_target" "filename_vpc" {
    count = "${var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"
    
    target_id = "${aws_lambda_function.filename_vpc.function_name}"
    rule      = "${aws_cloudwatch_event_rule.filename_vpc.name}"
    arn       = "${aws_lambda_function.filename_vpc.arn}"
}