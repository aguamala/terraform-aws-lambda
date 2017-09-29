#--------------------------------------------------------------
# lambda function in filename 
#--------------------------------------------------------------
resource "aws_lambda_function" "filename" {
    count = "${! var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"

    runtime         = "${var.runtime}"
    memory_size     = "${var.memory_size}"
    timeout         = "${var.timeout}"
    function_name   = "${var.function_name}"
    filename        = "${var.filename}"
    source_code_hash = "${base64sha256(file("${var.filename}"))}"
    role            = "${var.role}"
    handler         = "${var.handler}"
    description     = "${var.description}"
    publish         = "${var.publish}"

    environment {
        variables = "${var.environment_variables}"
    }

}

resource "aws_lambda_permission" "cloudwatch_event_filename" {
    count = "${! var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"

    statement_id  = "AllowExecutionFromCloudWatch"
    action        = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.filename.arn}"
    principal     = "events.amazonaws.com"
    source_arn    = "${aws_cloudwatch_event_rule.filename.arn}"
}

resource "aws_cloudwatch_event_rule" "filename" {
    count = "${! var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"

    name                = "${aws_lambda_function.filename.function_name}"
    schedule_expression = "${var.schedule_expression}"
    is_enabled          = "${var.schedule_is_enabled}"
}

resource "aws_cloudwatch_event_target" "filename" {
    count = "${! var.vpc_access && var.filename != "" && var.dead_letter_target_arn == "" ? 1 : 0}"

    target_id = "${aws_lambda_function.filename.function_name}"
    rule      = "${aws_cloudwatch_event_rule.filename.name}"
    arn       = "${aws_lambda_function.filename.arn}"
}