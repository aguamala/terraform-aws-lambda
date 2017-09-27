#--------------------------------------------------------------
# lambda function w/VPC access
#--------------------------------------------------------------
resource "aws_lambda_function" "mod" {
    runtime           = "${var.runtime}"
    timeout           = "${var.timeout}"
    s3_bucket         = "${var.s3_bucket}"
    s3_key            = "${var.s3_key}"
    s3_object_version = "${var.s3_object_version}"
    function_name     = "${var.function_name}"
    role              = "${var.role}"
    handler           = "${var.handler}"
    description       = "${var.description}"

    environment {
        variables = "${var.environment_variables}"
    }

    vpc_config {
        subnet_ids = "${var.vpc_subnet_ids}"

        security_group_ids = "${var.vpc_security_group_ids}"
    }
}

resource "aws_lambda_permission" "cloudwatch_event" {
    count = "${var.schedule ? 1 : 0}"
    statement_id  = "AllowExecutionFromCloudWatch"
    action        = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.mod.arn}"
    principal     = "events.amazonaws.com"
    source_arn    = "${aws_cloudwatch_event_rule.mod.arn}"
}

resource "aws_cloudwatch_event_rule" "mod" {
    count = "${var.schedule ? 1 : 0}"
    name                = "${aws_lambda_function.mod.function_name}"
    schedule_expression = "${var.schedule_expression}"
    is_enabled          = "${var.schedule_is_enabled}"
}

resource "aws_cloudwatch_event_target" "mod" {
    count = "${var.schedule ? 1 : 0}"
    target_id = "${aws_lambda_function.mod.function_name}"
    rule      = "${aws_cloudwatch_event_rule.mod.name}"
    arn       = "${aws_lambda_function.mod.arn}"
}