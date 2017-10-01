
output "lambda_function_s3_arn" {
  value = "${aws_lambda_function.s3.arn}"
}

output "lambda_function_s3_vpc_arn" {
  value = "${aws_lambda_function.s3_vpc.arn}"
}

output "lambda_function_s3_vpc_dl_arn" {
  value = "${aws_lambda_function.s3_vpc_dl.arn}"
}

output "lambda_function_s3_dl_arn" {
  value = "${aws_lambda_function.s3_dl.arn}"
}

output "lambda_function_arn" {
  value = "${aws_lambda_function.s3.arn}"
}

output "lambda_function_filename_vpc_arn" {
  value = "${aws_lambda_function.filename_vpc.arn}"
}

output "lambda_function_filename_vpc_dl_arn" {
  value = "${aws_lambda_function.filename_vpc_dl.arn}"
}

output "lambda_function_filename_dl_arn" {
  value = "${aws_lambda_function.filename_dl.arn}"
}