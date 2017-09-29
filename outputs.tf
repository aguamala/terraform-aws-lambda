
output "lambda_function_s3_arn" {
  value = "${aws_lambda_function.s3.arn}"
}

output "lambda_function_s3_vpc_arn" {
  value = "${aws_lambda_function.s3_vpc.arn}"
}
