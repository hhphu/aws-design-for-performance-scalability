provider "aws" {
	access_key = var.aws_access_key
	secret_key = var.aws_secret_access_key
	token = var.aws_session_token
region = var.aws_region
}

# Part 1
resource "aws_instance" "Udacity_T2" {
	ami = var.ec2_image
	count = "4"
	instance_type = "t2.micro"
	subnet_id = var.subnet_id
  tags = {
    Name = "Udacity T2"
  }
}

# To delete these two instances, we comment out these codes
resource "aws_instance" "Udacity_M4" {
	ami = var.ec2_image
	count = "2"
	instance_type = "m4.large"
	subnet_id = var.subnet_id
  tags = {
    Name = "Udacity M4"
  }
}

data "archive_file" "greet_lambda_zip" {
    type = "zip"
    source_file = "${path.module}/greet_lambda.py"
    output_path = "${path.module}/greet_lambda.zip"
}

resource "aws_lambda_function" "greet_lambda" {
    role = aws_iam_role.iam_for_lambda.arn
    filename = "greet_lambda.zip"
    source_code_hash = data.archive_file.greet_lambda_zip.output_base64sha256
    function_name = var.lambda_function_name
    handler = "${var.lambda_function_name}.lambda_handler"
    runtime = "python3.8"
}

resource "aws_cloudwatch_log_group" "greet_lambda_log" {
    name = "/aws/lambda/${aws_lambda_function.greet_lambda.function_name}"
}

resource "aws_iam_policy" "logging_lambda_function" {
	name = "logging_lambda_function"
	path = "/"
	
	
	policy = <<EOF
	{
  		"Version": "2012-10-17",
  		"Statement": [
    			{
      				"Action": [
        				"logs:CreateLogGroup",
        				"logs:CreateLogStream",
        				"logs:PutLogEvents"
      				],
      				"Resource": "arn:aws:logs:*:*:*",
      				"Effect": "Allow"
    			}
  		]
	}
	EOF
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

